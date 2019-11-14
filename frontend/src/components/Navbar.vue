<template>
  <!--<div>-->
    <div class="clearfix navbar">
      <!--Navbar for main navigation.-->
      <div class="float-left width-10">
        <img class="iconImage" src="/assets/images/acg_icon.png"/>
      </div>
      <div class="inline-block width-90 full-height">
        <div class="inline-block float-left width-90 full-height vertical-middle">
          <nav class="navigationList inline-block">
            <ul>
              <!--Use <router-link :to="{...}">...</router-link> format for links.-->
              <!--Please reference the routes by name.-->
              <!--Use CamelCase for route names.-->
              <li><router-link :to="{name: 'Home'}">Home</router-link></li>
              <li><router-link :to="{name: 'AboutACG'}">About ACG</router-link></li>
              <li><router-link :to="{name: 'ACGJoining'}">Joining</router-link></li>
              <li><router-link :to="{name: 'ACGComms'}">Communications</router-link></li>
              <li><a href="http://www.aircombatgroup.co.uk/forum" >Forums</a></li>
              <li><router-link :to="{name: 'CampaignList'}">Campaigns</router-link></li>
              <li><router-link :to="{name: 'Members'}">Members</router-link></li>
              <li><router-link :to="{name: 'Admin'}">Administration</router-link></li>
              <!--<li v-if="isAdmin()"><router-link :to="{name: 'Admin'}">Administration</router-link></li>-->
              <!--<li><router-link :to="{name: 'FlightSchool'}">FlightSchool</router-link></li>-->
            </ul>
          </nav>
          <Logger class="logger"></Logger>
        </div>

        <div class="float-right">{{this.$session.get('username')}}</div>

      </div>
    </div>

</template>

<script>
import Logger from './Logger'

export default {
  name: 'Navbar',
  components: {
    Logger
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

.iconImage {
  max-height: 70px;
}

.navbar {
  height: 90px;
  width: calc(100% - 20px); /* Whished widht in % minus 2x border size */
  padding: 10px;
}


.navigationList li {
  display: table-cell;
  font-size: 125%;
  text-align: center;
}

.navigationList li a {
  padding: 0px 5px;
  text-decoration: none;
  font-weight: bold;
  color: #FFF6FD;
}

.navigationList li a:hover{
  color: #F28900;
}

.logger {
  padding: 2px;
  border-radius: 15px;
  background: rgba(0, 0, 0, 0.1);
  vertical-align: bottom;
}

</style>
