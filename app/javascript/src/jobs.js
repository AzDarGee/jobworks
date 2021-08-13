document.addEventListener("turbolinks:load", function() {

    var instrumentImage = document.querySelector('.job-images');

    function handleFileSelect(evt) {
        var files = evt.target.files; // FileList object

        // Loop through the FileList and render image files as thumbnails.
        if (files) {
            for (var i = 0, f; f = files[i]; i++) {

                // Only process image files.
                if (!f.type.match('image.*')) {
                    continue;
                }

                var reader = new FileReader();

                // Closure to capture the file information.
                reader.onload = (function(theFile) {
                    return function(e) {
                        // Render thumbnail.
                        var span = document.createElement('span');
                        span.innerHTML = ['<img class="images-preview-thumb border-light" src="', e.target.result,
                            '" title="', escape(theFile.name), '"/>'
                        ].join('');
                        document.getElementById('list').insertBefore(span, null);
                    };
                })(f);
                // Read in the image file as a data URL.
                reader.readAsDataURL(f);
            }
        }
    }

    if (instrumentImage) {
        this.addEventListener('change', handleFileSelect, false);
    }


    //    Pagination of jobs
    (function() {
        $(function() {
            if ($('.pagination').length && $('#jobs').length) {
                $(window).scroll(function() {
                    var url;
                    url = $('.pagination .next_page').attr('href');
                    if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 50) {
                        $('.pagination').text('Loading more job posts...');
                        return $.getScript(url);
                    }
                });
                return $(window).scroll;
            }
        });

    }).call(this);

});