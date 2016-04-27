
module.exports =
  context: "#{__dirname}"
  entry:
    app: './src/index.js'
  output:
    path: './dist/js'
    filename: '[name].bundle.js'
    publicPath: '/js'

  devtool: 'inline-source-map'
  devServer:
    contentBase: './build'
  debug: true
