<template>
  <div id="app">
    <div class="navbar">
      <!--Navbar for main navigation.-->
      <navbar></navbar>
    </div>
    <div class="clearfix">
      <!--Clearfix is used to help align sidenav and main divs horizonatally next to-->
      <!--each other.-->
      <div class="sidenav">
        <!--The sidenav view is used on some pages for a vertical navigation menu.-->
        <!--For example unit- or flight-school-topic-navigation.-->
        <router-view name="sidenav"></router-view>
      </div>
      <div class="main">
        <!--The main view is where all the content appart from navigation menues goes.-->
        <router-view/>
      </div>
    </div>
    
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
  /*margin-top: 60px;*/
  /*max-width: 480px;*/
  margin: 1%;
}

div {
  border: 1px red solid;
}

h1 {
  clear: both;
}

ul {
  list-style-type: none;
  margin: 0;
  padding: 0;
  clear: both;
}

a {
  padding-right: 5px;
}

table {
  border-collapse: collapse;
}

tr,td {
  margin: 0;
  padding: 0px 5px 0px 5px;
  /*border: 1px solid green;*/
}

.navbar {
  height: 50px;
  border: 1px green solid;
}

.clearfix::after {
  content: "";
  clear: both;
  display: table;
}

.sidenav {
  float: left;
  width: calc(20% - 2px); /* Whished widht in % minus 2x border size */
  border: 1px blue solid;
}

.sidenav a{
  display: block;
}

.main {
  float: left;
  width: calc(80% - 2px); /* Whished widht in % minus 2x border size */
}



.link {
  cursor: pointer;
}

.link:hover {
  background: gray;
}

tr.link {
  cursor: pointer;
}

tr.link:hover {
  background: gray;
}
</style>
