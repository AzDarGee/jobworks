const { environment } = require('@rails/webpacker')

const webpack = require("webpack")
environment.plugins.append("Provide", new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery',
    jquery: 'jquery',
    Popper: ['popper.js/core', 'default']
}))

module.exports = environment
