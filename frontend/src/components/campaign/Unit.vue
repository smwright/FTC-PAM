<template>
  <div>
    <div v-if="campaign" class="container">
      <p class="text-align-justify">
        The list below shows all units that
        <template v-if="campaign.campaign_status > 1">
          took
        </template>
        <template v-else>
          take
        </template>
        part in {{ campaign.name }}. Each campaign has a distinct structure of historical units and subunits, depending
        on the historical context of the campaign. Some of the units are represented by ACG base units, that is a group
        of ACG pilots flying at that unit.
      </p>
      <p class="text-align-justify">
        Click on the + and - buttons of each unit to unfold and fold the unit structure. Click on the units to get collected
        statistics of the unit and all of its subunits, or the pilot roster of a unit.
      </p>
    </div>
    <div v-for="child in nestedData('campaign_units')">
      <UnitBaseComp v-bind="child"></UnitBaseComp>
    </div>
  </div>
</template>

<script>
import UnitBaseComp from "./UnitBaseComp";
import { mapState, mapGetters } from "vuex"

export default {
  name: 'Unit',
  components: {UnitBaseComp},
  mounted () {

    this.$store.dispatch('unitAdmin/loadStoreData',
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

    this.$store.dispatch('unitAdmin /loadStoreData',
      {
        caller: this.$options.name,
        call_object: {
          view: "campaign_unit_member_info",
          campaign_id: this.campaign_id
        },
        data_array_name: "member_info",
      }
    ).catch(error => {
      console.log(error.message);
    });

    this.$store.dispatch('unitAdmin/loadStoreData',
      {
        caller: this.$options.name,
        call_object: {
          view: "rank_lookup",
        },
        data_array_name: "rank_lookup"
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

    ...mapState("missionStore", {

      campaign: state => state.campaign[0],
    }),

    ...mapGetters("unitAdmin", [
      "nestedData",
    ])

  }
}


</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style>

</style>
