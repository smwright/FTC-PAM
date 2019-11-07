<template>
  <div>
    <table>
      <tr>
        <th>
          Mission date:
        </th>
        <th>
          Mission name:
        </th>
        <th>
          Victories:
        </th>
        <th>
          Pilot status:
        </th>
        <th>
          Asset status:
        </th>
      </tr>
      <TRLinkButton
        v-for="report in reportStats(this.character_id)"
        v-bind:key="report.report_id"
        class="typed-on-paper-link"
        v-bind="{routeName: 'Report',
          routeParams: {
            campaign_id: report.campaign_id,
            mission_id: report.mission_id,
            report_id: report.report_id
          }
        }"
      >
        <td>
          {{ report.mission_hist_date }}
        </td>
        <td>
          {{ report.mission_name }}
        </td>
        <td>
          <ClaimStats
            v-bind:report_id="report.report_id"
            v-bind:compact_style="true"
          ></ClaimStats>
        </td>
        <td>
          {{ pilotStatus[report.pilot_status] }}
        </td>
        <td>
          {{ assetStatus[report.asset_status] }}
        </td>
      </TRLinkButton>
    </table>
  </div>
</template>

<script>
import { mapState, mapGetters } from "vuex"
import ClaimStats from "./ClaimStatsComp"
import TRLinkButton from "../basic_comp/TRLinkButton"
import statConv from "../../resource/statusConverter"

export default {
  name: "SortieComp",
  mixins: [statConv],
  components: {
    ClaimStats,
    TRLinkButton
  },
  props: {
    character_id: {
      type: [Number, String],
      default: null
    }
  },
  computed: {


    ...mapGetters("memberInfo", [
      "reportStats"
    ])
  }
}
</script>

<style scoped>

</style>
