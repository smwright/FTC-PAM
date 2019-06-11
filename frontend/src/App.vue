<template>
  <div id="app">
    <div class="clearfix">
      <!--Navbar for main navigation.-->
      <navbar class="float-left navbar"></navbar>
      <div class="float-right">{{this.$session.get('username')}}</div>
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
  },
  mounted() {
    this.$auth.syncSession(this.$options.name);
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
  width: calc(80% - 2px); /* Whished widht in % minus 2x border size */
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


/*Clearly visible div to mark placeholders for elements that haven't been added to the pam yet*/
.to-add{
  font-weight: bold;
  color: yellow;
  border: 2px yellow dashed;
  background-color: black;
}

/*Styles for listing elements (members list, campaigns list, missions list....)*/

/*.link-list{*/
  /*margin: 10px 2px 10px 2px;*/
  /*cursor: pointer;*/
/*}*/

/*.link-list:hover {*/
  /*background: gray;*/
/*}*/

/*.link-list-heading{*/
  /*font-weight: bold;*/
  /*font-size: 1.2em;*/
/*}*/

/*.multi-line-link-button {*/
  /*display: inline-block;*/
/*}*/

/*.multi-line-link-button span {*/
  /*margin: 10px;*/
  /*width: auto;*/
/*}*/

/*CSS FOR draggable-nested-tree*/

DraggableTree div {
  border: none
}

.he-tree{
  border: 1px solid #ccc;
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
  padding: 5px;
  border: 1px solid #ccc;
  cursor: pointer;
}

.tree-node-inner div {
  border: 1px solid red
}

.tree-node-inner-back{
  border: none
}
.draggable-placeholder{
}
.draggable-placeholder-inner{
  border: 1px dashed #0088F8;
  box-sizing: border-box;
  background: rgba(0, 136, 249, 0.09);
  color: #0088f9;
  text-align: center;
  padding: 0;
  display: flex;
  align-items: center;
}


</style>
