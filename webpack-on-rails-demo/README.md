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

