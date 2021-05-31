<template>
  <div>
    <p class="text-align-justify">
      This page gives you access to the briefings and AAR’s of '{{ mission_name }}'. ACG members have the possibility to create
      and edit AAR’s.
    </p>
    <p class="text-align-justify">
      On the left you have a side menu to select the briefings for all factions that took part in this mission. Depending
      on the status of the mission and your membership status, some briefings might not be readable to you.
    </p>
    <p class="text-align-justify">
      Below the briefings you’ll find a list of all units that took part in this mission. Click on the + and - buttons of
      each unit to unfold and fold the unit structure. Click on the units to access a list of submitted AAR’s for that unit.
      In case of a BoX mission you’ll also get a list with pilot fates for the pilots of the unit. You can access the list
      of the AAR’s in the side menu as well. The buttons for the AAR’s in the side menu are grey for AAR’s that are pending
      approval. AAR’s that are approved will show up green with a check mark.
    </p>
    <p class="text-align-justify">
      Click on ‘Add new report’ to create a new AAR for {{ mission_name }}. NOTE: This will create a new AAR! To edit an
      already existing AAR you need to select the AAR first, then you click on the ‘Edit report’ button in the upper right
      of the report document.
    </p>
  </div>
</template>

<script>


export default {
  name: "MissionLobbyHelp",
  props: {
    mission_name: {
      type: String,
      default: "this mission"
    }
  }

}
</script>

<style scoped>

</style>
