<template>
  <div>
    <div class="container">
      <button v-on:click="changeTab('general')">General</button>
    </div>
    <div>
      <UnitGeneralComp
        v-show="tabToShow === 'general'"
      >
      </UnitGeneralComp>

    </div>



  </div>

</template>

<script>
import UnitGeneralComp from "./UnitGeneralComp"

export default {
  name: "UnitAdmin",
  components: {
    UnitGeneralComp
  },
  mounted () {

    this.updateUnitID(this.$route.params.unit_id);
  },

  data () {
    return {

      unit_it: 0,
      tabToShow: "general"
    }
  },

  beforeRouteUpdate (to, from, next) {
    // called when the route that renders this component has changed,
    // but this component is reused in the new route.
    // For example, for a route with dynamic params `/foo/:id`, when we
    // navigate between `/foo/1` and `/foo/2`, the same `Foo` component instance
    // will be reused, and this hook will be called when that happens.
    // has access to `this` component instance.
    this.updateUnitID(to.params.unit_id);
    next();
  },
  methods: {

    changeTab: function (tab) {

      console.log("Change tab to: "+tab);
      this.tabToShow = tab;
    },

    updateUnitID: function (id) {

      this.unit_id = Number(id);
      if(id >= 0) {

        this.$store.dispatch('characterStore/loadStoreData',
          {
            caller: this.$options.name,
            call_object: {
              view: "decoration_info",
              acg_unit_id: id,
              awarded: 0
            },
            data_array_name: "decorations"
          });

        this.$store.dispatch('characterStore/loadStoreData',
          {
            caller: this.$options.name,
            call_object: {
              view: "report_info",
              acg_unit_id: id,
              accepted: 0
            },
            data_array_name: "reports"
          });

      }
    }
  }
}
</script>

<style scoped>

</style>
