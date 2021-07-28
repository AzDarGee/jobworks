// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()


// Import User JS
import '../src/bootstrap'
import "@fortawesome/fontawesome-free/css/all"
import 'mdb-ui-kit'
import { initMapbox } from '../src/init-mapbox'
import { initShowMapBox } from '../src/show-map-init'
import '../src/jobs'
import '../src/stripe'

require("trix")
require("@rails/actiontext")

document.addEventListener('turbolinks:load', () => {
    initMapbox();
    initShowMapBox();
});