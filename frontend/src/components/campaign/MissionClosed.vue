<template>
  <div>

  </div>
</template>

<script>
import Briefing from "./Briefing"

export default {
  name: "MissionsClosed",
  components: {Briefing},
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
