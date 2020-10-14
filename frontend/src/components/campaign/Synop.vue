<template>
  <div v-if="this.unit != undefined" class="typed-on-paper">

    <div class="container-transparent">
      <img class="unitEmblem" v-bind:src="unit.image"/>
      <span class="heading">{{ this.unit.hist_unit_name }} mission synopsis</span>
    </div>

    <SynopGeneral
      class="container-transparent"
    ></SynopGeneral>

    <div class="heading padding-10-0">Recommended reading:</div>
    <ReportRecommendations
      v-if="report_recommendations.length > 0"
      class="container-transparent"
      v-bind:showMissionName="false"
      v-bind:show-campaign-name="false"
      v-bind:recommendations="this.report_recommendations"
    ></ReportRecommendations>

    <SynopReports
      class="container-transparent"
      v-if="reports.length > 0"
    ></SynopReports>

    <SynopPilotFate
      class="container-transparent"
    ></SynopPilotFate>
  </div>
</template>

<script>
import { mapState, mapGetters} from "vuex"
import SynopGeneral from "./SynopGeneral"
import SynopReports from "./SynopReports"
import SynopPilotFate from "./SynopPilotFate"
import ReportRecommendations from "./ReportRecommendationsComp"

export default {

  name: "Synop",
  components: {
    SynopGeneral,
    SynopReports,
    SynopPilotFate,
    ReportRecommendations
  },
  computed: {


    reports: function () {

      return this.filterByKey("reports", "depl_unit_id", this.$route.params.depl_unit_id);
    },

    unit: function () {

      return this.filterByKey("campaign_units", "depl_unit_id", this.$route.params.depl_unit_id)[0];
    },

    report_recommendations: function () {

      let sub_units = this.subTree("campaign_units", "depl_unit_id", this.$route.params.depl_unit_id);
      let recommendations = [];

      if(this.$route.params.depl_unit_id === undefined){
        return this.filterByKey("report_response", "mission_id", this.$route.params.mission_id)
      }

      for(let i=0; i<sub_units.length; i++){
        let reports = this.filterByKey("report_response", "depl_unit_id", sub_units[i].depl_unit_id);
        if(reports.length > 0) recommendations = recommendations.concat(reports);
      }

      return recommendations;
    },

    ...mapState("missionStore", {
      campaign_units: state => state.campaign_units,
    }),

    ...mapGetters("missionStore", [
      "filterByKey",
      "subTree"
    ])
  },
}
</script>

<style scoped>


.unitEmblem {
  height: 100px;
  vertical-align: middle;
}

</style>
