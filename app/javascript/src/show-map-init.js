import 'mapbox-gl/dist/mapbox-gl.css';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';
import mapboxgl from 'mapbox-gl';

mapboxgl.workerClass = require('worker-loader!mapbox-gl/dist/mapbox-gl-csp-worker').default;

const fitMapToMarkers = (map, features) => {
    const bounds = new mapboxgl.LngLatBounds();
    features.forEach(({ geometry }) => bounds.extend(geometry.coordinates));
    map.fitBounds(bounds, { padding: 70, maxZoom: 12 });
};

const initShowMapBox = () => {
    const mapElement = document.getElementById('show-map');

    if (mapElement) {
        mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
        const map = new mapboxgl.Map({
            container: 'show-map',
            style: 'mapbox://styles/mapbox/dark-v10'
        });

        // disable map zoom when using scroll
        map.scrollZoom.disable();

        map.on('load', function() {
            const jobs = JSON.parse(mapElement.dataset.jobs);
            map.addSource('jobs', {
                type: 'geojson',
                data: jobs,
                cluster: true,
                clusterMaxZoom: 14,
                clusterRadius: 30
            });

            map.addLayer({
                id: 'clusters',
                type: 'circle',
                source: 'jobs',
                filter: ['has', 'point_count'],
                paint: {
                    'circle-color': [
                        'step',
                        ['get', 'point_count'],
                        '#51bbd6',
                        100,
                        '#f1f075',
                        750,
                        '#f28cb1'
                    ],
                    'circle-radius': [
                        'step',
                        ['get', 'point_count'],
                        20,
                        100,
                        30,
                        750,
                        40
                    ]
                }
            });

            map.addLayer({
                id: 'cluster-count',
                type: 'symbol',
                source: 'jobs',
                filter: ['has', 'point_count'],
                layout: {
                    'text-field': '{point_count_abbreviated}',
                    'text-font': ['DIN Offc Pro Medium', 'Arial Unicode MS Bold'],
                    'text-size': 12
                }
            });

            map.addLayer({
                id: 'unclustered-point',
                type: 'circle',
                source: 'jobs',
                filter: ['!', ['has', 'point_count']],
                paint: {
                    'circle-color': '#11b4da',
                    'circle-radius': 10,
                    'circle-stroke-width': 1,
                    'circle-stroke-color': '#fff'
                }
            });

            map.on('click', 'clusters', function (e) {
                const features = map.queryRenderedFeatures(e.point, { layers: ['clusters'] });
                const clusterId = features[0].properties.cluster_id;

                map.getSource('jobs').getClusterExpansionZoom(clusterId, function (err, zoom) {
                    if (err) return;

                    map.easeTo({
                        center: features[0].geometry.coordinates,
                        zoom: zoom
                    });
                });
            });

            map.on('mouseenter', 'clusters', function (e) {
                map.getCanvas().style.cursor = 'pointer';
            });

            map.on('mouseleave', 'clusters', function () {
                map.getCanvas().style.cursor = '';
            });

            map.on('click', 'unclustered-point', function (e) {
                const features = map.queryRenderedFeatures(e.point, { layers: ['unclustered-point'] });
                const infoWindow = features[0].properties.info_window;
                const coordinates = features[0].geometry.coordinates;

                map.easeTo({
                    center: features[0].geometry.coordinates
                });

                new mapboxgl.Popup()
                    .setLngLat(coordinates)
                    .setHTML(infoWindow)
                    .addTo(map);
            });

            map.on('mouseenter', 'unclustered-point', function () {
                map.getCanvas().style.cursor = 'pointer';
            });

            map.on('mouseleave', 'unclustered-point', function () {
                map.getCanvas().style.cursor = '';
            });

            fitMapToMarkers(map, jobs.features);
        });
    }
};

export { initShowMapBox };