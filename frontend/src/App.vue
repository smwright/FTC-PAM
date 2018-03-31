<template>
  <div id="app">
    <navbar></navbar>
    <router-view/>
  </div>
</template>

<script>
import Navbar from './components/Navbar'

export default {
  name: 'App',
  components: {
    'navbar': Navbar
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  margin-top: 60px;
  max-width: 480px;
  margin: auto;
}

h1 {
  clear: both;
}

nav ul {
  list-style-type: none;
  margin: 0;
  padding: 0;
  clear: both;
}

nav li {
  float: left;
}

nav a {
  padding-right: 5px;
}

table {
  border-collapse: collapse;
}

tr,td {
  margin: 0;
  padding: 0;
}

tr.link {
  cursor: pointer;
}

tr.link:hover {
  background: gray;
}
</style>
