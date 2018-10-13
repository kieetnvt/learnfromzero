# Webpack on Rails demo

Purpose:
- Module bundler front-end assets
- More control over the number of HTTP requests
- Code Splitting: This feature allows you to split your code into various bundles which can then be loaded on demand or in parallel.

# Demo

## Step 1: set up npm & webpack

```
rails new webpack-on-rails-demo && cd webpack-on-rails-demo && rails g controller welcome
npm init -y
npm install --save-dev webpack webpack-cli
```

## Step 2: split code by page

Use webpack.config.js to define the main js of each page. Then each main js need import only this page need to load.

Example: welcome_index page just need welcome_index.scss, don't need load all scss or js as traditional way of rails with application.js & application.scss

With split code of webpack, the application.js & application.scss of rails just load the common js & scss for all page need.


```
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
```

## Step 3: Run npm build the bundle.js files, and put script tag on each page to load the bundle.js file.