webpack = require 'webpack'
HtmlWebPackPlugin = require 'html-webpack-plugin'
validate = require 'webpack-validator'

TARGET = process.env.npm_lifecycle_event
PATHS =
  app: "#{__dirname}/app"
  build: "#{__dirname}/build"

BUILD =

  common:

    entry:
      app: PATHS.app

    output:
      path: PATHS.build
      filename: '[name].js'

    plugins: [
      new HtmlWebPackPlugin title: 'Webpack demo'
      
      if TARGET is 'dev'
        new webpack.HotModuleReplacementPlugin multiStep: true
    ]


  dev:

    devServer:
      historyApiFallback: true
      hot: true
      inline: true
      progress: true
      stats: 'errors-only'
      host:
        process.env.HOST
      port:
        process.env.PORT


  prod:

    {}



#module.exports = validate build TARGET
do ({common, "#{TARGET}": target} = BUILD) ->
  target[key] = val for key, val of common
  module.exports = validate target
