# acg-frontend

> Frontend for the Air Combat Group's website and Pilot and Mission Database (PAM).

## Tools Setup

# To make the build setup below work properly you want to install a couple of tools on your computer.

# 1. Install Node.js, which comes with a wonderful little package manager called Node Package Manager, or npm for short.
#    Link to Node.js: https://nodejs.org/en/
# 2. Install Yarn, which is an improved package manager, using npm. 
#    Run "npm install -g yarn", or visit here for more details: https://yarnpkg.com/en/

# After that you should be able to run the build setup below, unless I missed something. Have fun!
# // Niwsters

## Build Setup

# Run the following commands before and during development according to what you need.
# If you're unsure, just run "yarn install" and then "yarn dev" before you start developing.
# The "yarn dev" thing runs a local server that compiles the frontend code so you can look at it
# in a web browser through the link http://localhost:8080

``` bash
# install dependencies
yarn install

# serve with hot reload at localhost:8080
yarn run dev

# build for production with minification
yarn run build

# build for production and view the bundle analyzer report
yarn run build --report

# run unit tests
yarn run unit

# run all tests
yarn test
```

For a detailed explanation on how things work, check out the [guide](http://vuejs-templates.github.io/webpack/) and [docs for vue-loader](http://vuejs.github.io/vue-loader).
