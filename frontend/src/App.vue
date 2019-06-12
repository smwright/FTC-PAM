<template>
  <div id="app">
    <div class="clearfix navbar">
      <!--Navbar for main navigation.-->
      <Navbar class="float-left"></Navbar>
      <div class="float-right">{{this.$session.get('username')}}</div>
    </div>
    <div class="clearfix contentWrapper">
      <!--Clearfix is used to help align sidenav and main divs horizonatally next to-->
      <!--each other.-->
      <div class="sidenav">
        <!--The sidenav view is used on some pages for a vertical navigation menu.-->
        <!--For example unit- or flight-school-topic-navigation.-->
        <router-view name="sidenav"></router-view>
      </div>
      <div class="main">
        <!--<EventLog></EventLog>-->
        <!--The main view is where all the content appart from navigation menues goes.-->
        <router-view/>
      </div>
      <div class="full-main">
        <router-view name="fullmain"></router-view>
      </div>
    </div>
  </div>
</template>

<script>
import Navbar from './components/Navbar'
import EventLog from './components/EventLog'

export default {
  name: 'App',
  components: {
    Navbar,
    EventLog
  },
  mounted() {
    this.$auth.syncSession(this.$options.name);
  }
}
</script>

<style>
#app {
  font-family: Roboto, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;

}

@font-face {
  font-family: "Remingtoned Type";
  src: url("/static/TypewriterFont.ttf");
}

body {
  width: 1800px;
  background:url("http://www.mediafire.com/convkey/abbb/i1nbz888niblfoqzg.jpg");
  background-color: #FFFFFF;
  background-repeat: no-repeat;
  background-position: center top;
  background-size: cover;
  background-attachment: fixed;
  padding: 10px;
  color: #ffffff;
  font-size: 17px;
}

.contentWrapper {
  width: calc(100% - 20px);
  min-height: 800px;
  padding: 10px;
  border-style: solid;
  border-width: 1px;
  border-radius: 15px;
  border-color: rgba(0, 0, 0, 0.4);
  background: rgba(0, 0, 0, 0.5);
}

.navbar {
  height: 50px;
  width: calc(100% - 20px);; /* Whished widht in % minus 2x border size */
  padding: 10px;
  list-style: none;
  border-style: solid;
  border-width: 1px;
  border-radius: 15px;
  border-color: rgba(0, 0, 0, 0.4);
  background: rgba(101, 21, 22, .8);
  text-align: center;
  display: table;
}

h1, h2, h3, h4{
  color: #F28900;
  padding: 2px 0px;
  background-image: linear-gradient(to right, rgba(0, 0, 0, 0), rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0))
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

button {

  text-align: center;
  padding: 5px;
  border-style: solid;
  border-width: 1px;
  border-radius: 10px;
  border-color: rgba(0, 0, 0, 0.4);
  background-color: rgb(255, 255, 255);
}

button:hover {

  text-align: center;
  padding: 5px;
  border-style: solid;
  border-width: 1px;
  border-radius: 10px;
  color: rgb(255, 255, 255);
  border-color: #F28900;
  background-color: rgb(95, 95, 95);
}

input, textarea {

  border:none;
  background: rgba(255, 255, 255, 0.5);
  border-color: #646464;
  border-radius: 5px;
  padding: 5px;
  color: #1b1b1b;
}

select {

  border: none;
  background: rgba(255, 255, 255, 0.5);
  border-color: #646464;
  border-radius: 2px;
  padding: 2px;
  margin: 2px;
  color: #1b1b1b;
}

.clearfix::after {
  content: "";
  clear: both;
  display: table;
}

.sidenav {
  float: left;
  min_width: calc(20% - 7px);
  width: calc(20% - 7px); /* Whished widht in % minus 2x border size */
  padding-right: 5px;
  /*border: 1px blue solid;*/
}

.sidenav a{
  display: block;
}

.main {
  float: left;
  width: calc(80% - 7px); /* Whished widht in % minus 2x border size */
  padding-left: 5px;
}

.container {
  margin: 10px 2px 10px 2px;
  padding: 10px;
  border-style: solid;
  border-width: 0px;
  border-radius: 15px;
  border-color: rgba(0, 0, 0, 0.0);
  background: rgba(0, 0, 0, 0.1);
}

.side-nav-heading {

  color: #F28900;
  padding: 5px;
  border-radius: 10px;
  text-align: center;
  background-image: linear-gradient(to right, rgba(0, 0, 0, 0), rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0))

}

.div-button{

  width: calc(100% - 26px);
  margin: 10px 2px 10px 2px;
  padding: 10px;
  cursor: pointer;
  border-style: solid;
  border-width: 1px;
  border-radius: 15px;
  border-color: rgba(0, 0, 0, 0.0);
  background: rgba(0, 0, 0, 0.1);
}

.div-button:hover {
  border-style: solid;
  border-width: 1px;
  border-radius: 15px;
  border-color: #F28900;
  background: rgba(0, 0, 0, 0.4);

}

/*General quick style aspects*/
.full-width{
  width: 100%;
}

.half-width{
  width: calc(50% - 2px);
}

.width-80{
  width: 80%;
}

.width-30{
  width: 30%;
}

.width-auto{
  width: auto;
}

.inline-block{
  display: inline-block;
}

.table {
  display: table;
}

.float-left{
  float: left;
}

.float-right{
  float: right;
}

.heading{
  font-weight: bold;
  font-size: 1.2em;
}

.white-space-pre-line{
  white-space: pre-line;
}

/*Style for typewriter on paper look*/

.typed-on-paper {
  background: rgb(243, 231, 146);
  border-radius: 2px;
  padding: 30px;
  color: #1b1b1b;
  font-family: "Remingtoned Type";
  box-shadow: 10px 10px 10px rgba(10,10,10,0.5);
}

.typed-on-paper button {

  background: rgba(0, 0, 0, 0);
  border-color: #646464;
  color: #1b1b1b;
  font-family: "Remingtoned Type";
}

.typed-on-paper button:hover {

  background: rgba(255, 255, 255, 0.5);
  border-color: #646464;
  color: #1b1b1b;
  font-family: "Remingtoned Type";
}

.typed-on-paper textarea,
.typed-on-paper input {

  border:none;
  background: rgba(255, 255, 255, 0.5);
  border-color: #646464;
  border-radius: 5px;
  padding: 5px;
  color: #1b1b1b;
  font-family: "Remingtoned Type";
}

.typed-on-paper select {

  border: none;
  background: rgba(255, 255, 255, 0.5);
  border-color: #646464;
  border-radius: 2px;
  padding: 2px;
  margin: 2px;
  color: #1b1b1b;
  font-family: "Remingtoned Type";
}


/*CSS FOR draggable-nested-tree*/

DraggableTree div {
  border: none;
}

.he-tree{
  /*border: 1px solid #ccc;*/
  padding: 20px;
}

.tree-node{
}

.tree-node {
  border: none
}

.tree-node-children{
  border: none
}

.tree-node-inner{
  /*padding: 5px;*/
  /*border: 1px solid #ccc;*/
  cursor: pointer;
}

.tree-node-inner div {
  /*border: 1px solid red*/
}

.tree-node-inner-back{
  border: none
}
.draggable-placeholder{
}
.draggable-placeholder-inner{
  /*border: 1px dashed #0088F8;*/
  box-sizing: border-box;
  background: rgba(0, 136, 249, 0.09);
  /*color: #0088f9;*/
  text-align: center;
  padding: 0;
  display: flex;
  align-items: center;
}


</style>
