<template>
  <div id="app">
    <div id="header">
        <Navbar class=""></Navbar>
    </div>

    <div id="body">
      <div class="clearfix contentWrapper">
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
        <div class="full-main">
          <router-view name="fullmain"></router-view>
        </div>
      </div>
    </div>
    <div id="footer">
      <div class="text-align-center padding-10">
        Air Combat Group
      </div>
    </div>
  </div>
</template>

<script>
import Navbar from './components/Navbar'
import Logger from './components/Logger'
import Footer from './components/Footer'

export default {
  name: 'App',
  components: {
    Navbar,
    Logger,
    Footer
  },
  mounted() {
    this.$auth.syncSession(this.$options.name);
  }
}
</script>

<style>
#app {
  min-height: 100%;
  position: relative;

  font-family: Roboto, Arial, sans-serif, Remingtoned Type, Dawning of a New Day;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;

}

#header {
  /*height: 50px;*/
  width: 100%;
  border-style: solid;
  border-width: 1px;
  border-radius: 15px;
  border-color: rgba(0, 0, 0, 0.4);
  background: rgba(101, 21, 22, .8);
}

#body {
  height:100%;
  /*padding: 10px;*/
  padding-bottom: 82px; /* Height of footer */
  /*overflow: scroll;*/
}

#footer {
  position: absolute;
  bottom: 0;
  width: 100%;
  height: 82px;
  border-style: solid;
  border-width: 1px;
  border-radius: 15px;
  border-color: rgba(0, 0, 0, 0.4);
  background: rgba(101, 21, 22, .8);
}

@font-face {
  font-family: "Remingtoned Type";
  src: url("/assets/fonts/TypewriterFont.ttf");
  /*src: local("Remingtoned Type");*/
}

@font-face {
  font-family: "Dawning of a New Day";
  src: url("/assets/fonts/DawningofaNewDay.ttf");
  /*src: local("Dawning of a New Day");*/

}

@font-face {
  font-family: "TrueTypewriter PolygLOTT";
  src: url("/assets/fonts/TTWPGOTT.ttf");
  /*src: local("TrueTypewriter PolygLOTT");*/

}

@font-face {
  font-family: "Deutschische";
  src: url("/assets/fonts/Deutschische.otf");
  /*src: local("Deutschische");*/

}

@font-face {
  font-family: "DSWallau";
  src: url("/assets/fonts/DSWallau.ttf");
  /*src: local("DSWallau");*/

}

/*div{*/
  /*border: 1px solid yellow;*/
/*}*/

html {
  /*height: 100%;*/
  background:url("/assets/images/background.jpg");
  /*background-color: #FFFFFF;*/
  background-repeat: no-repeat;
  background-position: center center;
  background-attachment: fixed;
  -webkit-background-size: cover;
  -moz-background-size: cover;
  -o-background-size: cover;
  background-size: cover;

}

body {
  min-width: 1020px;
  color: #ffffff;

}

.contentWrapper {
  width: calc(100% - 20px);
  /*height: 100%;*/
  /*min-height: 800px;*/
  padding: 10px;
  border-style: solid;
  border-width: 1px;
  border-radius: 15px;
  border-color: rgba(0, 0, 0, 0.4);
  background: rgba(0, 0, 0, 0.5);
}

.fixed {
  position: fixed;
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

th {
  padding: 0px 5px;
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
  max-width: 99%;
}

textarea {
  width: 75%;
}

select {

  border: none;
  background: rgba(255, 255, 255, 0.5);
  border-color: #646464;
  border-radius: 2px;
  font-size: large;
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

.container-transparent {
  margin: 10px 2px 10px 2px;
  padding: 10px;
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

.div-button-inactive{

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

/*General quick style aspects*/

.full-height{
  height: 100%;
}

.full-width{
  width: 100%;
}

.half-width{
  width: calc(50% - 2px);
}

.width-90{
  width: 90%;
}

.width-80{
  width: 80%;
}

.width-70{
  width: 70%;
}

.width-60{
  width: 60%;
}

.width-40{
  width: 40%;
}

.width-30{
  width: 30%;
}

.width-20{
  width: 20%;
}

.width-10{
  width: 10%;
}

.width-5{
  width: 5%;
}

.width-auto{
  width: auto;
}

.padding-10{
  padding: 10px;
}

.margin-auto{
  margin: auto;
}

.text-align-left{
  text-align: left;
}

.text-align-center{
  text-align: center;
}

.text-align-right{
  text-align: right;
}

.text-align-justify{
  text-align: justify;
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
  background: #ecd7b0;
  border-radius: 2px;
  padding: 30px;
  color: #1b1b1b;
  font-family: "Remingtoned Type";
  box-shadow: 10px 10px 10px rgba(10,10,10,0.5);
}

.typed-on-paper-link:hover {
  background: rgba(255, 255, 255, 0.5);
  border-color: transparent;
}

.bigSignature {
  font-size: xx-large;
  opacity: 0.8;
  color: #000F55;
  font-weight: bold;
  font-family: "Dawning of a New Day";
}


.polyglottTypewriter {
  text-decoration: black;
  font-size: larger;
  font-family: "TrueTypewriter PolyglOTT";
}


.Deutschische {
  text-decoration: black;
  font-family: "Deutschische";
}

.dsWallau {
  text-decoration: black;
  font-family: "DSWallau";
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
  font-size: large;
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

.typed-on-paper h1 {
  font-size: inherit;
  font-weight: bolder;
  color: inherit;
  background-image: none;
}

.typed-on-paper th {
  font-weight: normal;
}

.typed-on-paper hr {
  border: 1px solid black;

}

.axis {
  background-color: rgba(0,0,102,0.25);
  padding: 4px;
  border-radius: 15px;
}

.allied {
  background-color: rgba(153,0,0,0.25);
  padding: 4px;
  border-radius: 15px;
}

.luftwaffe {
  background-color: rgba(0,0,102,0.25);
  border-radius: 15px;
}

.vvs {
  background-color: rgba(100,0,0,0.25);
  border-radius: 15px;
}

.raf {
  background-color: rgba(200, 0, 0, 0.25);
  border-radius: 15px;
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

.fa {
  padding: 5px;
  font-size: 20px;
  width: 20px;
  text-align: center;
  text-decoration: none;
  margin: 0px 0px;
  border-radius: 50%;
}

.fa:hover {
  opacity: 0.7;
}

.fa-facebook {
  background: #3B5998;
  color: white;
}

.fa-youtube {
  background: #bb0000;
  color: white;
}

.unit-buttons{
  color: #F28900;
  font-size: 1em;
  margin: 2px 0px 0px 20px;
  padding-top: 5px;
  padding-bottom: 5px;
  width: calc(100% - 20px - 26px);
}
</style>
