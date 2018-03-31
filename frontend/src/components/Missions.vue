<template>
  <div class="frontpage">
    <h1>ACG-Missions</h1>
    <p>These pages list all ACG missions with their name, real- and historic date, associated campaign and status. The real date is the date at which the mission was performed as part of a ACG campaign. The historic date is the date at which the mission took place in an historic context. Each mission is part of a ACG campaign. The status of the mission has implications on the accessibility of mission briefings and After Action Reports (AAR's).</p>
    <p>The mission statuses are:</p> 
    <ul>
      <li>Briefing: Before mission start. Briefings can only be seen by the associated faction. AARs can not be created or edited.</li>
      <li>Debriefing: After mission has ended. Briefings can only be seen by the associated faction. AARs can be created or edited.</li>
      <li>Closed: After debriefing period has ended (usually one week after the mission has ended). Breifings can be seen by all factions. AARs can not be created or edited.</li>
    </ul>
    <p>Click anywhere on the mission information to request mission details.</p>
  </div>
</template>

<script>
export default {
  name: 'Frontpage',
  data () {
    return {
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
