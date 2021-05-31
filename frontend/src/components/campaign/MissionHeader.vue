<template>
  <div class="heading">
      <span>{{ real_date }}</span>
      <span>{{ name }}</span>
      <span>({{ hist_date }})</span>
    <div class="float-right">
      <span>{{ missionStatus[mission_status] }}</span>
    </div>
  </div>
</template>

<script>
import statConv from "../../resource/statusConverter"

export default {
  name: "MissionHeader",
  mixins: [statConv],
  props: {
    id: {
      type: Number,
      default: null
    },
    name: {
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
