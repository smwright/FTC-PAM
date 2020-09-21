<template>
  <div v-if="this.unit != undefined" class="typed-on-paper">

    <div class="container-transparent">
      <img class="unitEmblem" v-bind:src="unit.image"/>
      <span class="heading">{{ this.unit.hist_unit_name }} mission synopsis</span>
    </div>

    <SynopGeneral
      class="container-transparent"
    ></SynopGeneral>

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

export default {

  name: "Synop",
  components: {
    SynopGeneral,
    SynopReports,
    SynopPilotFate
  },
  computed: {


    reports: function () {

      return this.filterByKey("reports", "depl_unit_id", this.$route.params.depl_unit_id);
    },

    unit: function () {

      return this.filterByKey("campaign_units", "depl_unit_id", this.$route.params.depl_unit_id)[0];
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
