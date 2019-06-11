<template>
      <nav>
        <ul>
          <!--Use <router-link :to="{...}">...</router-link> format for links.-->
          <!--Please reference the routes by name.-->
          <!--Use CamelCase for route names.-->
          <li><router-link :to="{name: 'Home'}">Home</router-link></li>
          <li><router-link :to="{name: 'AboutACG'}">About ACG</router-link></li>
          <li><router-link :to="{name: 'CampaignList'}">Campaigns</router-link></li>
          <li><router-link :to="{name: 'Admin'}">Administration</router-link></li>
          <!--<li v-if="isAdmin()"><router-link :to="{name: 'Admin'}">Administration</router-link></li>-->

          <li><router-link :to="{name: 'FlightSchool'}">FlightSchool</router-link></li>
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

ul {
  display: table;
}

li {
  display: table-cell;
}
</style>
