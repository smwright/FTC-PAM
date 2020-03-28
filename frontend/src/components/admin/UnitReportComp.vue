<template>
  <div>

    <p class="heading">After Action Reports for approval:</p>
    <template v-if="mission_ids.length > 0">
      <p>The following AAR's need approval by the commanding officer or squadron/Staffel adjutant.</p>

      <div
        v-for="mission_id in mission_ids">

        <template v-for="(report, index) in filterByKey('reports', 'mission_id', mission_id)">

          <div
            v-if="index == 0"
            class="heading">
            {{ report.campaign_name }} - {{ report.mission_name }} ( {{report.mission_real_date }} )
          </div>

          <DivLinkButton
            v-bind:class="{ axis: isAxis(report.faction), allied: isAllied(report.faction) }"
            v-bind="{routeName: 'Report',
                routeParams: {
                  campaign_id: report.campaign_id,
                  mission_id: report.mission_id,
                  report_id: report.report_id
                }
              }"
          >
            <span class="report-span">
              Report {{ report.report_id }} by {{ report.abreviation }}
              {{ report.first_name }} '{{ report.callsign }}' {{ report.last_name }}
              of {{ report.hist_unit_name }}, submitted on {{ report.date_submitted }}.
            </span>
          </DivLinkButton>
        </template>

      </div>

    </template>
    <template v-else>
      <p>No reports are currently pending for approval.</p>
    </template>


  </div>

</template>

<script>
import {mapState, mapGetters} from "vuex"
import DivLinkButton from "../basic_comp/DivLinkButton"

export default {
  name: "UnitReportComp",
  components: {
    DivLinkButton
  },
  computed: {

    mission_ids: function() {

      return [...new Set(this.reports.map(item => item.mission_id))];

    },

    ...mapState("characterStore", {

      reports: state => state.reports,
    }),

    ...mapGetters("characterStore", [
      "filterByKey"
    ])

  },
  methods: {

    isAxis: function (faction) {

      return faction === 1;
    },

    isAllied: function (faction) {

      return faction === 2 || faction ===3;
    },
  }
}
</script>

<style scoped>

.report-span {
  padding: 10px;
}

</style>
