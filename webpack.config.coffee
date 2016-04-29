webpack = require 'webpack'
HtmlWebPackPlugin = require 'html-webpack-plugin'
validate = require 'webpack-validator'

TARGET = process.env.npm_lifecycle_event
PATHS =
  app: "#{__dirname}/app"
  build: "#{__dirname}/build"

console.log "FYI: TARGET is #{TARGET}"


BUILD =

  common:
    entry:
      app: PATHS.app
    output:
      path: PATHS.build
      filename: '[name].js'
    module:
      loaders: [
        { test: /\.css$/, loaders:['style','css'], include: PATHS.app }
      ]
    plugins: [
      new HtmlWebPackPlugin title: 'Webpack demo'
    ].concat switch TARGET

      when 'build' then [
        new webpack.HotModuleReplacementPlugin
          multiStep: true
        new webpack.optimize.UglifyJsPlugin
          compress:
            warnings: false
          mangle:
            props: /matching_props/
            except: [
              'Array'
              'BigInteger'
              'Boolean'
              'Buffer'
            ]
        new webpack.DefinePlugin
          'process.env.NODE_ENV': 'production'
      ]

      when 'dev' then [
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
    devtool: 'eval-source-map'





#module.exports = validate build TARGET
do ({common: build, "#{TARGET}": target} = BUILD) ->
  build[key] = val for key, val of target
  module.exports = validate build
