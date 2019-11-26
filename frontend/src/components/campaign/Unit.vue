<template>
  <div>
    <p>Here you find a list of all units of the campaign {{campaign_id}}.</p>
    <div v-for="child in nestedData('campaign_units')">
      <UnitBaseComp v-bind="child"></UnitBaseComp>
    </div>
  </div>
</template>

<script>
import UnitBaseComp from "./UnitBaseComp";
import { mapGetters } from "vuex"

export default {
  name: 'Unit',
  components: {UnitBaseComp},
  mounted () {

    this.$store.dispatch('missionStore/loadStoreData',
      {
        caller: this.$options.name,
        call_object: {
          view: "campaign_info_unit",
          campaign_id: this.campaign_id
        },
        data_array_name: "campaign_units",
      }
    ).catch(error => {
      console.log(error.message);
    });

    this.$store.dispatch('missionStore/loadStoreData',
      {
        caller: this.$options.name,
        call_object: {
          view: "campaign_unit_plane_asset_status",
          campaign_id: this.campaign_id
        },
        data_array_name: "campaign_unit_plane_asset_status",
      }
    ).catch(error => {
      console.log(error.message);
    });

    this.$store.dispatch('missionStore/loadStoreData',
      {
        caller: this.$options.name,
        call_object: {
          view: "campaign_unit_member_info",
          campaign_id: this.campaign_id
        },
        data_array_name: "campaign_unit_member_info",
      }
    ).catch(error => {
      console.log(error.message);
    });

  },
  data () {
    return {
      campaign_id: this.$route.params.campaign_id,
    }
  },
  computed: {


    ...mapGetters("missionStore", [
      "nestedData",
    ])

  }
}


</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style>

</style>
