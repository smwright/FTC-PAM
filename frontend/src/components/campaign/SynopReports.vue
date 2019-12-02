<template>
  <div>
    <table>
      <tr>
        <th colspan="2">Pilot</th>
        <th>Submissions date</th>
        <th>Status</th>
        <th>Approved by</th>
      </tr>
      <TRLinkButton
        v-for="report in reports"
        v-bind:key="report.report_id"
        class="typed-on-paper-link"
        v-bind="{routeName: 'Report',
          routeParams: {
            report_id: report.report_id
          }
        }"
      >
        <td>{{ report.abreviation }}</td>
        <td>{{ decodeHTML(report.first_name) }} '{{report.callsign}}' {{ decodeHTML(report.last_name) }}</td>
        <td>{{ report.date_submitted }}</td>
        <td v-if="report.accepted == 1">Approved</td>
        <td v-else >Pedning approval</td>
        <td>{{ report.accepting_member }}</td>
      </TRLinkButton>
    </table>

  </div>
</template>

<script>
import { mapState, mapGetters} from "vuex"
import stringConv from "../../resource/stringConverter"
import TRLinkButton from "../basic_comp/TRLinkButton"

export default {
  name: "SynopReports",
  mixins: [
    stringConv
  ],
  components: {
    TRLinkButton
  },
  computed: {

    reports: function () {

      return this.filterByKey("reports", "depl_unit_id",  this.$route.params.depl_unit_id);
    },

    ...mapGetters("missionStore", [
      "filterByKey"
    ])
  },
}
</script>

<style scoped>

</style>
