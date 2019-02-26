<template>
  <div class="heading">
      <span>{{ real_date }}</span>
      <span>{{ mission_name }}</span>
      <span>({{ hist_date }})</span>
    <div class="inline float-right">
      <span v-if="mission_status===0">Briefing</span>
      <span v-else-if="mission_status===1">Debriefing</span>
      <span v-else-if="mission_status===2">closed</span>
    </div>
  </div>
</template>

<script>
export default {
  name: "MissionHeader",
  props: {
    id: {
      type: Number,
      default: null
    },
    mission_name: {
      type: String,
      default: null
    },
    real_date: {
      type: String,
      default: null
    },
    hist_date: {
      type: String,
      default: null
    },
    mission_status: {
      type: Number,
      default: null
    }
  },
}
</script>

<style scoped>

</style>
