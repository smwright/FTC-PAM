<template>
  <div>
    <div class="container">
      <button v-on:click="addUnit">Add unit</button>
    </div>
    <HistUnitsBaseComp
      v-for="unit in hist_units"
      v-bind:key="unit.id"
      v-bind="unit"
      v-on:deleteUnit="onDeleteUnit"
    ></HistUnitsBaseComp>
  </div>

</template>

<script>
import HistUnitsBaseComp from "./HistUnitsBaseComp"

export default {
  name: "HistUnits",
  components: {HistUnitsBaseComp},
  mounted () {

    this.$dbCon.requestViewData(this.$options.name, {view: "hist_unit_info"})
      .then(response => {
        this.hist_units = response;
        console.log(JSON.stringify(this.hist_units));
      })
      .catch(error => {
        console.log(error.message);
      });
  },
  data () {
    return {
      hist_units: null,
      new_unit_counter: 0
    }
  },
  methods: {

    addUnit: function () {

      this.new_unit_counter--;
      this.hist_units.unshift(
        {
          // Auto decrement id of new items to give them unique negative id's
          id: this.new_unit_counter,
          name: "New Unit "+this.new_unit_counter*(-1),
          code: null,
          faction: 0,
          type: 1,
          description: null,
          image: null
        }
      )
    },

    onDeleteUnit: function (id) {

        for(var i=0; i < this.hist_units.length; i++){
          if(this.hist_units[i].id === id){
            this.hist_units.splice(i,1)
          }
        }
    }
  }
}
</script>

<style scoped>

</style>
