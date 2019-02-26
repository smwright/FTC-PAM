<template>
  <div>
    <p>Here you find a list of all units of the campaign {{campaign_id}}.</p>
    <div v-for="child in campaign_units">
      <UnitBaseComp v-bind="child"></UnitBaseComp>
    </div>
  </div>
</template>

<script>
import UnitBaseComp from "./UnitBaseComp";

export default {
  name: 'Unit',
  components: {UnitBaseComp},
  mounted () {

    this.requestViewData(this.$options.name, {view:"campaign_info_unit", campaign_id:this.$route.params.campaign_id})
      .then(response => {
        this.campaign_units = this.nestData(response);
      })
      .catch(error => {
        console.log(error.message);
      });
  },
  data () {
    return {
      campaign_id: this.$route.params.campaign_id,
      campaign_units: null
    }
  }
}


</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style>

</style>
