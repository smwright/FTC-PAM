<template>
  <div class="home">
    <nav>
      <ul>
        <li><a href="#/campaign-statistics">Campaign Statistics</a></li>
      </ul>
    </nav>
    <router-view></router-view>
  </div>
</template>

<script>
export default {
  name: 'Home',
  data () {
    return {
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
ul {
  list-style-type: none;
  margin: 0;
  padding: 0;
  clear: both;
}
</style>
