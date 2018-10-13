# A Beginner’s Guide to Webpack 4 and Module Bundling

# Intro Webpack 4:

Webpack is a **module bundler**. Its main purpose is to bundle JavaScript files for usage in a browser, yet it is also capable of transforming, bundling, or packaging just about any resource or asset.

Webpack has become one of the most important tools for modern web development. It’s primarily a module bundler for your JavaScript, but it can be taught to transform all of your front-end assets like HTML, CSS, even images. It can give you more control over the number of HTTP requests your app is making and allows you to use other flavors of those assets (Pug, Sass, and ES8, for example). Webpack also allows you to easily consume packages from npm.

> bundler mean: A collection of things - wrapped up together

### Main features:

- Module bundler front-end assets (JS, CSS, IMAGES, FONTS, SVG)
- it more control over the number of HTTP requests
- it easily consume packages from npm
- Use other flavors of those assets (SASS, SCSS..)

### Component Webpack features:

- Configuration
- Modules
- Loaders
- Plugins
- Code splitting
- Hot module replacement

------

# Demo and deep learn about Webpack 4 features:

#### Setup

Let’s initialize a new project with npm and install webpack and webpack-cli

```
mkdir webpack-demo && cd webpack-demo
npm init -y
npm install --save-dev webpack webpack-cli
```

Next we’ll create the following directory structure and contents:

```
webpack-demo
  |- package.json
+ |- webpack.config.js
+ |- /src
+   |- index.js
+ |- /dist
+   |- index.html
```

dist/index.html

```
<!doctype html>
<html>
  <head>
    <title>Hello Webpack</title>
  </head>
  <body>
    <script src="bundle.js"></script>
  </body>
</html>
```

src/index.js

```
const root = document.createElement("div")
root.innerHTML = `<p>Hello Webpack.</p>`
document.body.appendChild(root)
```

webpack.config.js

```
const path = require('path')

module.exports = {
  entry: './src/index.js',
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'dist')
  }
}
```

This tells Webpack to compile the code in our entry point src/index.js and output a bundle in /dist/bundle.js. Let’s add an npm script for running Webpack.

package.json

```
{
    ...
    "scripts": {
-     "test": "echo \"Error: no test specified\" && exit 1"
+     "develop": "webpack --mode development --watch",
+     "build": "webpack --mode production"
    },
    ...
}
```

Using the npm run develop command, we can create our first bundle! You should now be able to load dist/index.html in your browser and be greeted with “Hello Webpack”.
Restart the build with Ctrl + C and run npm run build to compile our bundle in production mode.

```
--mode development optimizes for build speed and debugging
--mode production optimizes for execution speed at runtime and output file size.
```

### Modules

Using ES Modules, you can split up your large programs into many small, self-contained programs.

Out of the box, Webpack knows how to consume ES Modules using import and export statements. As an example, let’s try this out now by installing lodash-es and adding a second module:

```
npm install --save-dev lodash-es
```

src/index.js

```
import { groupBy } from "lodash-es"
import people from "./people"

const managerGroups = groupBy(people, "manager")

const root = document.createElement("div")
root.innerHTML = `<pre>${JSON.stringify(managerGroups, null, 2)}</pre>`
document.body.appendChild(root)
```

src/people.js

```
const people = [
  {
    manager: "Jen",
    name: "Bob"
  },
  {
    manager: "Jen",
    name: "Sue"
  },
  {
    manager: "Bob",
    name: "Shirley"
  }
]

export default people
```

Run npm run develop to start Webpack and refresh index.html. You should see an array of people grouped by manager printed to the screen.

Note: Imports without a relative path like 'es-lodash' are modules from npm installed to /node_modules. Your own modules will always need a relative path like './people', as this is how you can tell them apart.

### Loaders

Loaders let you run preprocessors on files as they’re imported. This allows you to bundle static resources beyond JavaScript, but let’s look at what can be done when loading .js modules first.

Let’s keep our code modern by running all .js files through the next-generation JavaScript transpiler Babel:

```
npm install --save-dev "babel-loader@^8.0.0-beta" @babel/core @babel/preset-env
```

webpack.config.js

```
const path = require('path')

  module.exports = {
    entry: './src/index.js',
    output: {
      filename: 'bundle.js',
      path: path.resolve(__dirname, 'dist')
    },
+   module: {
+     rules: [
+       {
+         test: /\.js$/,
+         exclude: /(node_modules|bower_components)/,
+         use: {
+           loader: 'babel-loader',
+         }
+       }
+     ]
+   }
  }
```

.babelrc

```
{
  "presets": [
    ["@babel/env", {
      "modules": false
    }]
  ],
  "plugins": ["@babel/syntax-dynamic-import"]
}
```

This config prevents Babel from transpiling import and export statements into ES5, and enables dynamic imports — which we’ll look at later in the section on Code Splitting.

We’re now free to use modern language features, and they’ll be compiled down to ES5 that runs in all browsers.

#### Sass

Loaders can be chained together into a series of transforms. A good way to demonstrate how this works is by importing Sass from our JavaScript:

```
npm install --save-dev style-loader css-loader sass-loader node-sass
```

webpack.config.js

```
  module.exports = {
    ...
    module: {
      rules: [
        ...
+       {
+         test: /\.scss$/,
+         use: [{
+           loader: 'style-loader'
+         }, {
+           loader: 'css-loader'
+         }, {
+           loader: 'sass-loader'
+         }]
+       }
      ]
    }
  }

```

These loaders are processed in reverse order:

- sass-loader transforms Sass into CSS.
- css-loader parses the CSS into JavaScript and resolves any dependencies.
- style-loader outputs our CSS into a <style> tag in the document.

You can think of these as function calls. The output of one loader feeds as input into the next:

```styleLoader(cssLoader(sassLoader("source")))```

Let’s add a Sass source file and import is a module.

src/style.scss

```
$bluegrey: #2b3a42;

pre {
  padding: 8px 16px;
  background: $bluegrey;
  color: #e1e6e9;
  font-family: Menlo, Courier, monospace;
  font-size: 13px;
  line-height: 1.5;
  text-shadow: 0 1px 0 rgba(23, 31, 35, 0.5);
  border-radius: 3px;
}

```

src/index.js

```
import { groupBy } from 'lodash-es'
  import people from './people'

+ import './style.scss'

  ...
```

#### CSS in JS

We just imported a Sass file from our JavaScript, as a module.

Open up `dist/bundle.js` and search for “pre {”. Indeed, our Sass has been compiled to a string of CSS and saved as a module within our bundle. When we import this module into our JavaScript, `style-loader` outputs that string into an embedded `<style>` tag.

**Why would you do such a thing?**

I won’t delve too far into this topic here, but here are a few reasons to consider:

- A JavaScript component you may want to include in your project may *depend* on other assets to function properly (HTML, CSS, Images, SVG). If these can all be bundled together, it’s far easier to import and use.
- Dead code elimination: When a JS component is no longer imported by your code, the CSS will no longer be imported either. The bundle produced will only ever contain code that does something.
- CSS Modules: The global namespace of CSS makes it very difficult to be confident that a change to your CSS will not have any side effects. [CSS modules](https://github.com/css-modules/css-modules) change this by making CSS local by default and exposing unique class names that you can reference in your JavaScript.
- Bring down the number of HTTP requests by bundling/splitting code in clever ways.



### Images

The last example of loaders we’ll look at is the handling of images with `file-loader`.

In a standard HTML document, images are fetched when the browser encounters an `img` tag or an element with a `background-image` property. With Webpack, you can optimize this in the case of small images by storing the source of the images as strings inside your JavaScript. By doing this, you preload them and the browser won’t have to fetch them with separate requests later:

```
npm install --save-dev file-loader
```



**webpack.config.js**

```
  module.exports = {
    ...
    module: {
      rules: [
        ...
+       {
+         test: /\.(png|svg|jpg|gif)$/,
+         use: [
+           {
+             loader: 'file-loader'
+           }
+         ]
+       }
      ]
    }
  }
```

Download a [test image](https://raw.githubusercontent.com/sitepoint-editors/webpack-demo/master/src/code.png) with this command:

```
curl https://raw.githubusercontent.com/sitepoint-editors/webpack-demo/master/src/code.png --output src/code.png
```



**src/index.js**

```
  import { groupBy } from 'lodash-es'
  import people from './people'

  import './style.scss'
+ import './image-example'

  ...
```

**src/image-example.js**

```
import codeURL from "./code.png"

const img = document.createElement("img")
img.src = codeURL
img.style = "background: #2B3A42; padding: 20px"
img.width = 32
document.body.appendChild(img)
```

This will include an image where the `src` attribute contains a [data URI](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Data_URIs) of the image itself:

```
<img src="data:image/png;base64,iVBO..." style="background: #2B3A42; padding: 20px" width="32">
```

Background images in our CSS are also processed by `file-loader`.

**src/style.scss**

```
  $bluegrey: #2b3a42;

  pre {
    padding: 8px 16px;
-   background: $bluegrey;
+   background: $bluegrey url("code.png") no-repeat center center / 32px 32px;
    color: #e1e6e9;
    font-family: Menlo, Courier, monospace;
    font-size: 13px;
    line-height: 1.5;
    text-shadow: 0 1px 0 rgba(23, 31, 35, 0.5);
    border-radius: 3px;
  }
```



### Dependency Graph

You should now be able to see how loaders help to build up a tree of dependencies amongst your assets. This is what the image on the Webpack home page is demonstrating.

![dependency graph](https://www.evernote.com/shard/s430/res/1240b740-98b8-4b47-9f5a-a56878fc213c/1484692838webpack-dependency-tree.png)

Though JavaScript is the entry point, Webpack appreciates that your other asset types — like HTML, CSS, and SVG — each have dependencies of their own, which should be considered as part of the build process.



## Code Splitting

Code splitting is one of the most compelling features of Webpack. This feature allows you to split your code into various bundles which can then be loaded on demand or in parallel. It can be used to achieve smaller bundles and control resource load prioritization which, if used correctly, can have a major impact on load time.

So far, we’ve only seen a single entry point — `src/index.js` — and a single output bundle — `dist/bundle.js`. When your app grows, you’ll need to split this up so that the entire codebase isn’t downloaded at the start. A good approach is to use [Code Splitting](https://webpack.js.org/guides/code-splitting/) and [Lazy Loading](https://webpack.js.org/guides/lazy-loading/) to fetch things on demand as the code paths require them.

Let’s demonstrate this by adding a “chat” module, which is fetched and initialized when someone interacts with it. We’ll make a new entry point and give it a name, and we’ll also make the output’s filename dynamic so it’s different for each chunk.

**webpack.config.js**

```
   const path = require('path')

  module.exports = {
-   entry: './src/index.js',
+   entry: {
+     app: './src/app.js'
+   },
    output: {
-     filename: 'bundle.js',
+     filename: '[name].bundle.js',
      path: path.resolve(__dirname, 'dist')
    },
    ...
  }
```

**src/app.js**

```
import './app.scss'

const button = document.createElement("button")
button.textContent = 'Open chat'
document.body.appendChild(button)

button.onclick = () => {
  import(/* webpackChunkName: "chat" */ "./chat").then(chat => {
    chat.init()
  })
}
```

**src/chat.js**

```
import people from "./people"

export function init() {
  const root = document.createElement("div")
  root.innerHTML = `<p>There are ${people.length} people in the room.</p>`
  document.body.appendChild(root)
}
```

**src/app.scss**

```
button {
  padding: 10px;
  background: #24b47e;
  border: 1px solid rgba(#000, .1);
  border-width: 1px 1px 3px;
  border-radius: 3px;
  font: inherit;
  color: #fff;
  cursor: pointer;
  text-shadow: 0 1px 0 rgba(#000, .3), 0 1px 1px rgba(#000, .2);
}
```

*Note: Despite the /\* webpackChunkName */ comment for giving the bundle a name, this syntax is* *not* Webpack specific. It’s the [proposed syntax for dynamic imports](https://github.com/tc39/proposal-dynamic-import) intended to be supported directly in the browser.



**dist/index.html**

```
  <!doctype html>
  <html>
    <head>
      <title>Hello Webpack</title>
    </head>
    <body>
-     <script src="bundle.js"></script>
+     <script src="app.bundle.js"></script>
    </body>
  </html>
```

Let’s start up a server from the dist directory to see this in action:

```
cd dist
npx serve
```

Open http://localhost:5000 in the browser and see what happens. Only `bundle.js` is fetched initially. When the button is clicked, the chat module is imported and initialized.

![open-chat](https://www.evernote.com/shard/s430/res/c342f462-cfe4-4880-9860-39a222e1a9d7/1521906882lazy-loading.png)

With very little effort, we’ve added dynamic code splitting and lazy loading of modules to our app. This is a great starting point for building a highly performant web app.

## Plugins

While *loaders* operate transforms on single files, *plugins* operate across larger chunks of code.

Now that we’re bundling our code, external modules *and* static assets, our bundle will grow — *quickly*. Plugins are here to help us split our code in clever ways and optimize things for production.

Without knowing it, we’ve actually already used many [default Webpack plugins with “mode”](https://webpack.js.org/concepts/mode/#usage)

**development**

- Provides `process.env.NODE_ENV` with value “development”
- NamedModulesPlugin

**production**

- Provides `process.env.NODE_ENV` with value “production”
- UglifyJsPlugin
- ModuleConcatenationPlugin
- NoEmitOnErrorsPlugin

### Production

Before adding additional plugins, we’ll first split our config up so that we can apply plugins specific to each environment.

Rename `webpack.config.js` to `webpack.common.js` and add a config file for development and production.

```
- |- webpack.config.js
+ |- webpack.common.js
+ |- webpack.dev.js
+ |- webpack.prod.js
```

We’ll use `webpack-merge` to combine our common config with the environment-specific config:

```
npm install --save-dev webpack-merge
```

**webpack.dev.js**

```
const merge = require('webpack-merge')
const common = require('./webpack.common.js')

module.exports = merge(common, {
  mode: 'development'
})
```

**webpack.prod.js**

```
const merge = require('webpack-merge')
const common = require('./webpack.common.js')

module.exports = merge(common, {
  mode: 'production'
})
```

**package.json**

```
   "scripts": {
-    "develop": "webpack --watch --mode development",
-    "build": "webpack --mode production"
+    "develop": "webpack --watch --config webpack.dev.js",
+    "build": "webpack --config webpack.prod.js"
   },
```

Now we can add plugins specific to development into `webpack.dev.js` and plugins specific to production in `webpack.prod.js`.

### Split CSS

It’s considered best practice to split your CSS from your JavaScript when bundling for production using [ExtractTextWebpackPlugin](https://webpack.js.org/plugins/extract-text-webpack-plugin).

The current `.scss` loaders are perfect for development, so we’ll move those from `webpack.common.js` into `webpack.dev.js` and add `ExtractTextWebpackPlugin` to `webpack.prod.js` only.

```
npm install --save-dev extract-text-webpack-plugin@4.0.0-beta.0
```

**webpack.common.js**

```
  ...
  module.exports = {
    ...
    module: {
      rules: [
        ...
-       {
-         test: /\.scss$/,
-         use: [
-           {
-             loader: 'style-loader'
-           }, {
-             loader: 'css-loader'
-           }, {
-             loader: 'sass-loader'
-           }
-         ]
-       },
        ...
      ]
    }
  }
```

**webpack.dev.js**

```
  const merge = require('webpack-merge')
  const common = require('./webpack.common.js')

  module.exports = merge(common, {
    mode: 'development',
+   module: {
+     rules: [
+       {
+         test: /\.scss$/,
+         use: [
+           {
+             loader: 'style-loader'
+           }, {
+             loader: 'css-loader'
+           }, {
+             loader: 'sass-loader'
+           }
+         ]
+       }
+     ]
+   }
  })
```

**webpack.prod.js**

```
  const merge = require('webpack-merge')
+ const ExtractTextPlugin = require('extract-text-webpack-plugin')
  const common = require('./webpack.common.js')

  module.exports = merge(common, {
    mode: 'production',
+   module: {
+     rules: [
+       {
+         test: /\.scss$/,
+         use: ExtractTextPlugin.extract({
+           fallback: 'style-loader',
+           use: ['css-loader', 'sass-loader']
+         })
+       }
+     ]
+   },
+   plugins: [
+     new ExtractTextPlugin('style.css')
+   ]
  })
```

Let’s compare the output of our two build scripts:

```
> npm run develop

Asset           Size      Chunks           Chunk Names
app.bundle.js   28.5 KiB  app   [emitted]  app
chat.bundle.js  1.4 KiB   chat  [emitted]  chat
> npm run build

Asset           Size       Chunks        Chunk Names
chat.bundle.js  375 bytes  0  [emitted]  chat
app.bundle.js   1.82 KiB   1  [emitted]  app
style.css       424 bytes  1  [emitted]  app
```

Now that our CSS is extracted from our JavaScript bundle for production, we need to `<link>` to it from our HTML.

**dist/index.html**

```
  <!DOCTYPE html>
  <html>
    <head>
      <meta charset="UTF-8">
      <title>Code Splitting</title>
+     <link href="style.css" rel="stylesheet">
    </head>
    <body>
      <script type="text/javascript" src="app.bundle.js"></script>
    </body>
  </html>
```

This allows for parallel download of the CSS and JavaScript in the browser, so will be faster-loading than a single bundle. It also allows the styles to be displayed before the JavaScript finishes downloading.

### Generating HTML

Whenever our outputs have changed, we’ve had to keep updating `index.html` to reference the new file paths. This is precisely what `html-webpack-plugin` was created to do for us automatically.

We may as well add `clean-webpack-plugin` at the same time to clear out our `/dist` directory before each build.

```
npm install --save-dev html-webpack-plugin clean-webpack-plugin
```

**webpack.common.js**

```
  const path = require('path')
+ const CleanWebpackPlugin = require('clean-webpack-plugin');
+ const HtmlWebpackPlugin = require('html-webpack-plugin');

  module.exports = {
    ...
+   plugins: [
+     new CleanWebpackPlugin(['dist']),
+     new HtmlWebpackPlugin({
+       title: 'My killer app'
+     })
+   ]
  }
```

Now every time we build, dist will be cleared out. We’ll now see `index.html` output too, with the correct paths to our entry bundles.

Running `npm run develop` produces this:

```
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>My killer app</title>
  </head>
  <body>
    <script type="text/javascript" src="app.bundle.js"></script>
  </body>
</html>
```

And `npm run build` produces this:

```
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>My killer app</title>
    <link href="style.css" rel="stylesheet">
  </head>
  <body>
    <script type="text/javascript" src="app.bundle.js"></script>
  </body>
</html>
```

## Development

The webpack-dev-server provides you with a simple web server and gives you *live reloading*, so you don’t need to manually refresh the page to see changes.

```
npm install --save-dev webpack-dev-server
```

**package.json**

```
  {
    ...
    "scripts": {
-     "develop": "webpack --watch --config webpack.dev.js",
+     "develop": "webpack-dev-server --config webpack.dev.js",
    }
    ...
  }
> npm run develop

 ｢wds｣: Project is running at http://localhost:8080/
 ｢wds｣: webpack output is served from /
```

Open up http://localhost:8080/ in the browser and make a change to one of the JavaScript or CSS files. You should see it build and refresh automatically.

### HotModuleReplacement

The `HotModuleReplacement` plugin goes one step further than Live Reloading and swaps out modules at runtime *without the refresh*. When configured correctly, this saves a huge amount of time during development of single page apps. Where you have a lot of state in the page, you can make incremental changes to components, and only the changed modules are replaced and updated.

**webpack.dev.js**

```
+ const webpack = require('webpack')
  const merge = require('webpack-merge')
  const common = require('./webpack.common.js')

  module.exports = merge(common, {
    mode: 'development',
+   devServer: {
+     hot: true
+   },
+   plugins: [
+     new webpack.HotModuleReplacementPlugin()
+   ],
    ...
  }
```

Now we need to *accept* changed modules from our code to re-initialize things.

**src/app.js**

```
+ if (module.hot) {
+   module.hot.accept()
+ }

  ...
```

*Note: When Hot Module Replacement is enabled, module.hot is set to true for development and false for production, so these are stripped out of the bundle.*

Restart the build and see what happens when we do the following:

- Click *Open chat*
- Add a new person to the `people.js` module
- Click *Open chat* again.

![open-chat-2](https://www.evernote.com/shard/s430/res/eb3abc5c-0415-4892-8562-2ee389e48419/1521906879hmr.png)

Here’s what’s happening:

1. 1When *Open chat* is clicked, the `chat.js` module is fetched and initialized
2. 2HMR detects when `people.js` is modified
3. 3`module.hot.accept()` in `index.js` causes all modules loaded by this entry chunk to be replaced
4. 4When *Open chat* is clicked again, `chat.init()` is run with the code from the updated module.

### CSS Replacement

Let’s change the button color to red and see what happens:

**src/app.scss**

```
  button {
    ...
-   background: #24b47e;
+   background: red;
    ...
  }
```

![open-chat-3](https://www.evernote.com/shard/s430/res/3bec4919-c6ce-43a6-ac34-5ad49bdf54fc/1521906881hmr2.png)



Now we get to see instant updates to our styles without losing any state. This is a much-improved developer experience! And it feels like the future.

## HTTP/2

One of the primary benefits of using a module bundler like Webpack is that it can help you improve performance by giving you control over how the assets are *built* and then *fetched* on the client. It has been considered [best practice](https://developer.yahoo.com/performance/rules.html) for years to concatenate files to reduce the number of requests that need to be made on the client. This is still valid, but [HTTP/2 now allows multiple files to be delivered in a *single* request](https://www.sitepoint.com/file-bundling-and-http2/), so concatenation isn’t a silver bullet anymore. Your app may actually benefit from having many small files individually cached. The client could then fetch a single changed module rather than having to fetch an entire bundle again with *mostly* the same contents.

The creator of Webpack, [Tobias Koppers](https://twitter.com/wSokra), has written an informative post explaining why bundling is still important, even in the HTTP/2 era.

Read more about this over at [Webpack & HTTP/2](https://medium.com/webpack/webpack-http-2-7083ec3f3ce6).

## Over to You

I hope you’ve found this introduction to Webpack helpful and are able to start using it to great effect. It can take a little time to wrap your head around Webpack’s configuration, loaders and plugins, but learning how this tool works will pay off.

The documentation for Webpack 4 is currently being worked on, but is really well put together. I highly recommend reading through the [Concepts](https://webpack.js.org/concepts/) and [Guides](https://webpack.js.org/guides/) for more information. Here’s a few other topics you may be interested in:



origin-source: https://www.sitepoint.com/beginners-guide-webpack-module-bundling/