<template>
  <div>

    <UnitReportComp class="container"></UnitReportComp>
    <UnitDecorationComp class="container"></UnitDecorationComp>

  </div>

</template>

<script>
import UnitDecorationComp from './UnitDecorationComp'
import UnitReportComp from './UnitReportComp'

export default {
  name: "UnitGeneralComp",
  components:{
    UnitReportComp,
    UnitDecorationComp
  },
  computed: {

  },
  methods: {

  }
}
</script>

<style scoped>

</style>
