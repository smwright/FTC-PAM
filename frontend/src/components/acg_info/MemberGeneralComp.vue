<template>
  <div class="typed-on-paper">

    <div class="padding-10">
      <table>
        <tr><td>Name:</td><td>{{ memberById(member_id).callsign }}</td></tr>
        <tr><td>Status:</td><td>{{ memberStatus[memberById(member_id).member_status] }}</td></tr>
        <tr><td>Length of service:</td><td>{{ lengthOfService }}</td></tr>
        <tr><td>Current unit:</td><td>{{ currentACGUnitById(member_id).name }}</td></tr>
      </table>
    </div>

    <div class="clearfix">
      <!--<div class="inline-table float-left half-width">-->
        <SortiePilotAssetStats></SortiePilotAssetStats>
        <ClaimStats></ClaimStats>
      <!--</div>-->

      <!--<div class="inline-table float-left half-width">-->
        <!--<MemberCampaignAttendance></MemberCampaignAttendance>-->
      <!--</div>-->
    </div>

    <div class="padding-10">
      <h1>Status updates:</h1>
      <table>
        <tr>
          <th>Status:</th>
          <th>Date:</th>
        </tr>
        <tr v-for="status in status_log">
          <td>{{ memberStatus[status.member_status] }}</td>
          <td>{{ status.status_date_in }}</td>
        </tr>
      </table>
    </div>

    <div class="padding-10">
      <h1>Transfer overview:</h1>
      <table>
        <tr>
          <th>Date:</th>
          <th>To unit:</th>
        </tr>
        <tr v-for="transfer in transfer_log">
          <td>{{ transfer.transfer_date_in }}</td>
          <td>{{ unitById(transfer.acg_unit_id).name }}</td>
        </tr>
      </table>
    </div>

    <div class="padding-10">
      <h1>Promotion/Demotion overview:</h1>
      <table>
        <tr>
          <th>Date:</th>
          <th>To rank:</th>
          <th>Comment:</th>
        </tr>
        <tr v-for="promotion in promotion_log">
          <td>{{ promotion.promotion_date }}</td>
          <td>{{ promotion.rank_name }}</td>
          <td>{{ decodeHTML(promotion.comment) }}</td>
        </tr>
      </table>
    </div>

  </div>
</template>

<script>
import statConv from "../../resource/statusConverter"
import stringConv from "../../resource/stringConverter"
import { mapState, mapGetters } from "vuex"
import SortiePilotAssetStats from "./SortiePilotAssetStatsComp"
import MemberCampaignAttendance from "./MemberCampaignAttendance"
import ClaimStats from "./ClaimStatsComp"

export default {
  name: "MemberGeneralComp",
  mixins: [
    statConv,
    stringConv
  ],
  components: {
    SortiePilotAssetStats,
    ClaimStats,
    MemberCampaignAttendance
  },
  props: {
    member_id: {
      type: Number,
      default: 0
    }
  },
  computed: {

    ...mapState("memberInfo", {

      status_log: state => state.member_status_log,
      transfer_log: state => state.transfer_log,
      promotion_log: state => state.promotion_log
    }),

    ...mapGetters("memberInfo", [
      "memberById",
      "lengthOfService",
      "currentACGUnitById",
      "unitById"

    ])

  },

}
</script>

<style scoped>

</style>
