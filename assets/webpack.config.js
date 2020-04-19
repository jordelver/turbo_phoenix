const path = require('path');
const glob = require('glob-all');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const TerserPlugin = require('terser-webpack-plugin');
const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');
const PurgecssPlugin = require('purgecss-webpack-plugin');

const PATHS = {
  // Files from the Phoenix app in /lib
  elixir: path.join(__dirname, '../lib'),

  // JavaScript code under /assets/js/
  js: path.join(__dirname, 'js')
}

module.exports = (env, options) => ({
  optimization: {
    minimizer: [
      new TerserPlugin({ cache: true, parallel: true, sourceMap: false }),
      new OptimizeCSSAssetsPlugin({})
    ],
    splitChunks: {
      cacheGroups: {
        styles: {
          name: 'styles',
          test: /\.css$/,
          chunks: 'all',
          enforce: true
        }
      }
    }
  },
  entry: {
    './js/app.js': glob.sync('./vendor/**/*.js').concat(['./js/app.js'])
  },
  output: {
    filename: 'app.js',
    path: path.resolve(__dirname, '../priv/static/js')
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader'
        }
      },
      {
        test: /\.s?css$/,
        use: [MiniCssExtractPlugin.loader, 'css-loader', 'sass-loader']
      }
    ]
  },
  plugins: [
    new MiniCssExtractPlugin({ filename: '../css/app.css' }),
    new PurgecssPlugin({
      paths: glob.sync([
        `${PATHS.elixir}/**/*`,
        `${PATHS.js}/**/*`
      ], { nodir: true })
    }),
    new CopyWebpackPlugin([{ from: 'static/', to: '../' }])
  ]
});
