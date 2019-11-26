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
      <table>
        <thead>
        <tr>
          <th>Pilots:</th>
          <th></th>
          <th></th>
        </tr>
        </thead>
        <tbody>
          <template v-for="(member, index) in campaign_unit_member">
            <tr v-if="showName(index)">
              <td>{{member.rank_abr}}</td>
              <td>{{member.callsign}}</td>
              <td></td>
            </tr>
            <template v-if="member.event_type === 'transfer'">
              <tr v-if="member.show_event_start">
                <td></td>
                <td></td>
                <td>Transferred into unit {{member.event_date_in}}.</td>
              </tr>
              <tr v-if="member.show_event_end">
                <td></td>
                <td></td>
                <td>Transferred out of unit {{member.event_date_out}}.</td>
              </tr>
            </template>
            <template v-else-if="member.event_type === 'status'">
              <tr v-if="member.show_event_start & member.event_value === 0">
                <td></td>
                <td></td>
                <td>Joined/Rejoined ACG {{member.event_date_in}}.</td>
              </tr>
              <tr v-if="member.show_event_start & member.event_value === 1">
                <td></td>
                <td></td>
                <td>Left ACG {{member.event_date_in}}.</td>
              </tr>
              <tr v-if="member.show_event_start & member.event_value === 2">
                <td></td>
                <td></td>
                <td>Went on leave {{member.event_date_in}}.</td>
              </tr>
            </template>
          </template>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script>
import { mapState, mapGetters } from "vuex"

export default {
  name: "UnitMembersComp",
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

    campaign_unit_member: function() {

      return this.filterByKey("campaign_unit_member_info", "depl_unit_id", this.depl_unit_id);
    },

    ...mapGetters("missionStore", [

      "filterByKey"

    ])

  },
  methods: {

    showName: function(index){
      if(index > 0){
        return this.campaign_unit_member[index].callsign != this.campaign_unit_member[index-1].callsign;
      } else {
        return true
      }
    },
  },
}
</script>

<style scoped>



</style>
