const path = require('path')

module.exports = {
  entry: {
    welcome_index: './app/assets/javascripts/welcome_index.js',
    about_page: './app/assets/javascripts/about_page.js',
    people_page: './app/assets/javascripts/people_page.js',
  },
  output: {
    filename: '[name].bundle.js',
    path: path.resolve(__dirname, 'app/assets/javascripts/dist')
  },
  module: {
    rules: [
      {
        test: /.scss$/,
        use: [
          {
            loader: 'style-loader'
          },
          {
            loader: 'css-loader'
          },
          {
            loader: 'sass-loader'
          }
        ]
      },
    ]
  }
}