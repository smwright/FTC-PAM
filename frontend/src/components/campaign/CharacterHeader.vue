<template>
  <div class="heading">
      <span>{{rank_abreviation}}</span>
      <span>{{first_name}} {{last_name}}</span>
    <div class="inline float-right">
      <span>{{pilotStatus[character_status]}}</span>
    </div>
  </div>
</template>

<script>
import statConv from "../../resource/statusConverter"

export default {
  name: "CharacterHeader",
  mixins: [statConv],
  props: {
    first_name: {
      type: String,
      default: null
    },
    last_name: {
      type: String,
      default: null
    },
    rank_abreviation: {
      type: String,
      default: null
    },
    character_status: {
      type: Number,
      default: null
    },
  },
}
</script>

<style scoped>

</style>
