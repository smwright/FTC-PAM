<template>
      <nav class="navigationList">
        <ul>
          <!--Use <router-link :to="{...}">...</router-link> format for links.-->
          <!--Please reference the routes by name.-->
          <!--Use CamelCase for route names.-->
          <li><router-link :to="{name: 'Home'}">Home</router-link></li>
          <li><a href="http://www.aircombatgroup.co.uk/forum" >Forums</a></li>
          <li><router-link :to="{name: 'AboutACG'}">About Us</router-link></li>
          <li><a href="https://www.aircombatgroup.co.uk/field_book.pdf" >Field Book</a></li>
          <li><router-link :to="{name: 'ACGHistory'}">History</router-link></li>
          <li><router-link :to="{name: 'ACGJoining'}">Joining</router-link></li>
          <li><router-link :to="{name: 'ACGComms'}">Communications</router-link></li>
          <li><router-link :to="{name: 'Members'}">Members</router-link></li>
          <li><router-link :to="{name: 'CampaignList'}">Campaigns</router-link></li>
          <li><router-link :to="{name: 'Admin'}">Administration</router-link></li>
          <!--<li v-if="isAdmin()"><router-link :to="{name: 'Admin'}">Administration</router-link></li>-->
          <!--<li><router-link :to="{name: 'FlightSchool'}">FlightSchool</router-link></li>-->
        </ul>
      </nav>
</template>

<script>

export default {
  name: 'Navbar',
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

.navigationList {
  list-style: none;
  text-align: center;
  display: table;
}

.navigationList li {
  display: table-cell;
  font-size: 19px;
  font-weight: bold;
}

.navigationList li a {
  display: block;
  padding: 0px 10px;
  text-decoration: none;
  margin-top: 13px;
  font-size: 19px;
  font-weight: bold;
  color: #FFF6FD;
}

.navigationList li a:hover{
  color: #F28900;
}

ul {
  display: table;
}

li {
  display: table-cell;
}
</style>
