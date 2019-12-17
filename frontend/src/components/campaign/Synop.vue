<template>
  <div class="">
    MISSION-SYNOP {{ this.$route.params.depl_unit_id }}
    {{ reports.length }}
    <div class="typed-on-paper">
      <ul>
        <li v-for="unit in subunits">
          {{ unit.hist_unit_name }}
        </li>
      </ul>

    </div>
    <SynopReports
      v-if="reports.length > 0"
      class="typed-on-paper"
    ></SynopReports>
  </div>
</template>

<script>
import { mapState, mapGetters} from "vuex"
import SynopReports from "./SynopReports"

export default {

  name: "Synop",
  components: {
    SynopReports
  },
  computed: {


    reports: function () {

      return this.filterByKey("reports", "depl_unit_id", this.$route.params.depl_unit_id);
    },

    subunits: function () {

      return this.subTree("campaign_units", "depl_unit_id", this.$route.params.depl_unit_id)
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

</style>
