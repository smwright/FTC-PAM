<template>
  <div class="frontpage">
    <h1>Air Combat Group - Mission and Pilot Database</h1>
    <img src="../assets/ww2paperworksimulator.png">
    
    <p>This is new. We're working here.</p>
    
    <p>Welcome to the Air Combat Group Pilot and Mission database - The place where information on ACG pilots, squadrons and missions is stored and presented.</p>

    <p>Flying the Air Combat Group campaign means flying for historical immersion. We do not seek competition or try to win, we try to re-enact and get a feel for what it was like to be a fighter pilot during World War II.</p>

    <p>As the pilots back then, ACG-Pilots are required to write an After Action Report after each campaign mission, where they claim victories and describe the course of events of their mission. The reports are written, submitted and presented via these pages. Information from the reports is used to create pilot- and squadron profiles and various other statistics.</p>

    <p>There are currently {{active_pilots}} active pilots flying for ACG. The whole group consists of {{raf_squadrons}} Royal Air Force squadrons and {{lw_staffeln}} Luftwaffe Staffeln. There are {{aar_stored}} after action reports stored in this database, each representing a mission flown by one of our members during a campaign night.</p>

    <p>Have a look around and feel welcome to register in our forums or to join our Teamspeak channel to say hello. We are always searching for new pilots of any standard or experience, even if they have never flown before.</p>
  </div>
</template>

<script>
export default {
  name: 'Frontpage',
  data () {
    // TODO: Make this get data from an HTTP request
    return {
      active_pilots: 183,
      raf_squadrons: 7,
      lw_staffeln: 9,
      aar_stored: 12030
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
