<template>
  <div class="typed-on-paper">
    <div v-if="campaign_unit_stats.length > 0">
      <table>
        <thead>
          <tr>
            <th></th>
            <th></th>
            <th>Pilot status:</th>
            <th></th>
            <th>Asset status:</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
        <tr>
          <td>Sorties:</td>
          <td>{{campaign_unit_stats[0].sorties}}</td>
          <td>Ok:</td>
          <td>{{campaign_unit_stats[0].pilot_ok}}</td>
          <td>OK:<td>
          <td>{{campaign_unit_stats[0].asset_ok}}</td>
        </tr>
        <tr>
          <td></td>
          <td></td>
          <td>Wounded:</td>
          <td>{{campaign_unit_stats[0].pilot_wounded}}</td>
          <td>Damaged:<td>
          <td>{{campaign_unit_stats[0].asset_damaged}}</td>
        </tr>
        <tr>
          <td></td>
          <td></td>
          <td>POW:</td>
          <td>{{campaign_unit_stats[0].pilot_pow}}</td>
          <td>Lost:<td>
          <td>{{campaign_unit_stats[0].asset_lost}}</td>
        </tr>
        <tr>
          <td></td>
          <td></td>
          <td>KIA:</td>
          <td>{{campaign_unit_stats[0].pilot_kia}}</td>
          <td><td>
          <td></td>
        </tr>
        </tbody>
      </table>
    </div>
    <div v-if="this.$props.acg_unit_id != null">
      <div class="heading">Unit roster:</div>
      <Roster
        v-bind:unit_id="this.acg_unit_id"
        v-bind:campaign_id="this.$route.params.campaign_id"
      >
      </Roster>
    </div>
  </div>
</template>

<script>
import { mapState, mapGetters } from "vuex"
import Roster from "../acg_unit/UnitRoster"

export default {
  name: "UnitMembersComp",
  components: {
    Roster
  },
  props: {
    depl_unit_id: {
      type: Number,
      default: 0
    },
    acg_unit_id: {
      type: Number,
      default: 0
    }
  },
  computed: {

    campaign_unit_stats: function() {

      return this.filterByKey("campaign_unit_plane_asset_status", "depl_unit_id", this.depl_unit_id);
    },

    // campaign_unit_member: function() {
    //
    //   return this.filterByKey("campaign_unit_member_info", "depl_unit_id", this.depl_unit_id);
    // },

    ...mapGetters("missionStore", [

      "filterByKey"

    ]),

    // ...mapGetters({
    //   missionFindByKey: 'missionStore/filterByKey',
    //   unitFindByKey: 'unitInfo/filterByKey'
    // })

  },
  methods: {

  },
}
</script>

<style scoped>



</style>
