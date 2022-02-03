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

require('@uppy/core/dist/style.css')
require('@uppy/dashboard/dist/style.css')

// Import User JS
import '../src/bootstrap'
import "@fortawesome/fontawesome-free/css/all"
import { initMapbox } from '../src/init-mapbox'
import { initShowMapBox } from '../src/show-map-init'
import '../src/jobs'

require("trix")
require("@rails/actiontext")
import "../src/trix-editor-overrides"

// Uppy Image Uploads
const Uppy = require('@uppy/core')
const Dashboard = require('@uppy/dashboard')
const ActiveStorageUpload = require('@excid3/uppy-activestorage-upload')

require('@uppy/core/dist/style.css')
require('@uppy/dashboard/dist/style.css')


document.addEventListener('turbolinks:load', () => {
    initMapbox();
    initShowMapBox();



});

