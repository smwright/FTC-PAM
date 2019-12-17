<template>
  <div class="">
    <div class="typed-on-paper" v-if="this.unit !== undefined">
      MISSION-SYNOP {{ this.$route.params.depl_unit_id }}

      {{ JSON.stringify(this.unit) }}
      <div>
        <img class="unitEmblem" v-bind:src="unit.image"/>
        <span class="heading">{{ this.unit.hist_unit_name }} mission synopsis</span>
      </div>

      <!--Info about subunits-->
      <template v-if="subunits.length > 0">
        <p>
          {{ this.unit.hist_unit_name }} consisted of the following subunits:
        </p>
        <ul>
          <li v-for="s_unit in subunits">
            {{ s_unit.hist_unit_name }}
          </li>
        </ul>
      </template>

      <!--Info about sorties and pilot numbers-->
      <p>
        {{ unit_name_extended }} flew {{ subUnitStats.sorties }} {{ sorties }};
        {{ subUnitStats.n_pilots }} {{ pilots }} participated in this mission.
      </p>

      <!--For development reference-->
      <div class="padding-10">
        {{ JSON.stringify(this.subUnitStats) }}
      </div>

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

    unit: function () {

      return this.filterByKey("campaign_units", "depl_unit_id", this.$route.params.depl_unit_id)[0];
    },

    unit_name_extended: function () {

      if(this.subunits.length > 0){
        return this.unit.hist_unit_name + " and it's subunits";
      } else {
        return this.unit.hist_unit_name;
      }
    },

    sorties: function () {

      if(this.subUnitStats.sorties > 1){
        return "sorties";
      } else {
        return "sortie";
      }
    },

    pilots: function () {

      if(this.subUnitStats.n_pilots > 1){
        return "pilots";
      } else {
        return "pilot";
      }
    },

    subunits: function () {

      return this.subTree("campaign_units", "depl_unit_id", this.$route.params.depl_unit_id);
    },

    subUnitStats: function () {

      let unit_stats = {
        sorties: 0,
        n_pilots: 0,
      };
      let pilot_buffer = [];
      let sub_units = this.subunits;
      sub_units.unshift(this.unit);
      for(let i=0; i<sub_units.length; i++){

        let unit_reports = this.filterByKey("reports", "depl_unit_id", sub_units[i].depl_unit_id);
        for(let j=0; j<unit_reports.length; j++){

          let report = unit_reports[j];
          // only accepted reports are counted
          if(!report.accepted){
            continue;
          }
          unit_stats.sorties++;

          // count pilots only once
          if(!pilot_buffer.includes(report.character_id)){
            unit_stats.n_pilots++;
            pilot_buffer.push(report.character_id);
          }


        }
      }

      return unit_stats;
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
