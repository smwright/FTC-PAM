<template>
  <div>
    <div class="container">
      <button v-on:click="changeTab('general')">General</button>
      <button v-on:click="changeTab('roster')">Roster</button>
    </div>
    <div>
      <UnitGeneralComp
        v-show="tabToShow === 'general'"></UnitGeneralComp>
      <UnitRosterComp
        v-show="tabToShow === 'roster'"
        v-bind:acg_unit_id="unit_id"
      ></UnitRosterComp>

    </div>



  </div>

</template>

<script>
import UnitGeneralComp from "./UnitGeneralComp"
import UnitRosterComp from "./UnitRosterComp"


export default {
  name: "UnitAdmin",
  components: {
    UnitGeneralComp,
    UnitRosterComp,
  },
  mounted () {

    this.updateUnitID(this.$route.params.unit_id);
  },

  data () {
    return {

      unit_id: 0,
      tabToShow: "roster",
      selectedAsset: 0
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

        this.$store.dispatch('unitAdmin/loadStoreData',
          {
            caller: this.$options.name,
            call_object: {
              view: "rank_lookup"
            },
            data_array_name: "rank_lookup"
          });

        this.$store.dispatch('unitAdmin/loadStoreData',
          {
            caller: this.$options.name,
            call_object: {
              view: "campaign_info_unit",
              acg_unit_id: id,
            },
            data_array_name: "campaign_units"
          });

        this.$store.dispatch('unitAdmin/loadStoreData',
          {
            caller: this.$options.name,
            call_object: {
              view: "campaign_unit_member_info",
              acg_unit_id: id,
            },
            data_array_name: "member_info"
          });

        this.$store.dispatch('unitAdmin/loadStoreData',
          {
            caller: this.$options.name,
            call_object: {
              view: "asset_info",
            },
            data_array_name: "assets"
          });

        this.$store.dispatch('unitAdmin/loadStoreData',
          {
            caller: this.$options.name,
            call_object: {
              view: "roster_asset_info",
            },
            data_array_name: "r_assets"
          });

        this.$store.dispatch('unitAdmin/loadStoreData',
          {
            caller: this.$options.name,
            call_object: {
              view: "member_roster_asset",
            },
            data_array_name: "member_r_assets"
          });
      }
    }
  }
}
</script>

<style scoped>

</style>
