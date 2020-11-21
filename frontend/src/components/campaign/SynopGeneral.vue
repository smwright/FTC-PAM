<template>
  <div>
    <!--MISSION-SYNOP {{ this.$route.params.depl_unit_id }}-->

    <!--{{ JSON.stringify(this.unit) }}-->
    <!--<div>-->
      <!--<img class="unitEmblem" v-bind:src="unit.image"/>-->
      <!--<span class="heading">{{ this.unit.hist_unit_name }} mission synopsis</span>-->
    <!--</div>-->

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

    <p>
      The following information is based on approved After Action Reports for this mission.
    </p>

    <div class="padding-10">

      <table>
        <tr>
          <td>Participating pilots:</td>
          <td>{{ subUnitStats.n_pilots }}</td>
        </tr>
        <tr>
          <td>Sorties:</td>
          <td>{{ subUnitStats.sorties }}</td>
        </tr>
      </table>
      <div class="clearfix">
        <div class="inline-table float-left">
          <table>
            <tr><td>Pilot status</td></tr>
            <tr><td colspan="2"><hr></td></tr>
            <tr v-if="subUnitStats.pilot_ok > 0">
              <td>OK:</td>
              <td>{{ subUnitStats.pilot_ok }}</td>
            </tr>
            <tr v-if="subUnitStats.pilot_wounded > 0">
              <td>Wounded:</td>
              <td>{{ subUnitStats.pilot_wounded }}</td>
            </tr>
            <tr v-if="subUnitStats.pilot_pow > 0">
              <td>POW:</td>
              <td>{{ subUnitStats.pilot_pow }}</td>
            </tr>
            <tr v-if="subUnitStats.pilot_kia > 0">
              <td>KIA:</td>
              <td>{{ subUnitStats.pilot_kia }}</td>
            </tr>
          </table>
        </div>
        <div class="inline-table float-left">
          <table>
            <tr><td>Aircraft status</td></tr>
            <tr><td colspan="2"><hr></td></tr>
            <tr v-if="subUnitStats.asset_ok > 0">
              <td>OK:</td>
              <td>{{ subUnitStats.asset_ok }}</td>
            </tr>
            <tr v-if="subUnitStats.asset_damaged > 0">
              <td>Damaged:</td>
              <td>{{ subUnitStats.asset_damaged }}</td>
            </tr>
            <tr v-if="subUnitStats.asset_lost > 0">
              <td>Lost:</td>
              <td>{{ subUnitStats.asset_lost }}</td>
            </tr>
          </table>
        </div>
      </div>
    </div>

    <!--Info about sorties and pilot numbers-->
    <!--<p>-->
      <!--{{ unit_name_extended }} flew {{ subUnitStats.sorties }} {{ sorties }};-->
      <!--{{ subUnitStats.n_pilots }} {{ pilot_pilots(subUnitStats.n_pilots) }} participated in this mission;-->
      <!--{{ subUnitStats.pilot_wounded}} {{ pilot_pilots(subUnitStats.pilot_wounded) }} {{ was_were(subUnitStats.pilot_wounded) }}-->
      <!--wounded.-->
      <!--{{ subUnitStats.pilot_pow + subUnitStats.pilot_kia }} {{ pilot_pilots(subUnitStats.pilot_pow + subUnitStats.pilot_kia) }}-->
      <!--{{ is_are(subUnitStats.pilot_pow + subUnitStats.pilot_kia) }} missing and assumed captured or dead.-->
    <!--</p>-->



    <!--For development reference-->
    <!--<div class="padding-10">-->
      <!--{{ JSON.stringify(this.subUnitStats) }}-->
    <!--</div>-->



  </div>
</template>

<script>
import {mapGetters} from "vuex"

export default {
  name: "SynopGeneral",
  computed: {

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

    subunits: function () {

      return this.subTree("campaign_units", "depl_unit_id", this.$route.params.depl_unit_id);
    },

    subUnitStats: function () {

      let unit_stats = {
        sorties: 0,
        n_pilots: 0,
        pilot_ok: 0,
        pilot_ok_names: [],
        pilot_wounded: 0,
        pilot_wounded_names: [],
        pilot_pow: 0,
        pilot_pow_names: [],
        pilot_kia: 0,
        pilot_kia_names: [],
        asset_ok: 0,
        asset_damaged: 0,
        asset_lost: 0
      };
      let pilot_buffer = [];
      let pilot_status_buffer = [];
      let asset_status_buffer = [];

      let sub_units = this.subunits;
      sub_units.unshift(this.unit);
      for(let i=0; i<sub_units.length; i++){

        let unit_reports = this.filterByKeys("reports",
          {
            depl_unit_id: sub_units[i].depl_unit_id,
            accepted: 1
          }
        );
        for(let j=0; j<unit_reports.length; j++){

          let report = unit_reports[j];
          unit_stats.sorties++;

          // count pilots only once
          if(!pilot_buffer.includes(report.character_id)){
            unit_stats.n_pilots++;
            pilot_buffer.push(report.character_id);
          }
        }

        pilot_status_buffer = unit_reports.filter(
          function (item) {
            return item.pilot_status === 0;
          });
        unit_stats.pilot_ok_names.push(Array.from(new Set(pilot_status_buffer.map(
          function (item) {
            return {first_name: item.first_name, callsign: item.callsign, last_name: item.last_name};
          }
        ))));
        unit_stats.pilot_ok += pilot_status_buffer.length;

        pilot_status_buffer = unit_reports.filter(
          function (item) {
            return item.pilot_status === 1;
          });
        unit_stats.pilot_wounded_names.push(Array.from(new Set(pilot_status_buffer.map(
          function (item) {
            return {first_name: item.first_name, callsign: item.callsign, last_name: item.last_name};
          }
        ))));
        unit_stats.pilot_wounded += pilot_status_buffer.length;

        pilot_status_buffer = unit_reports.filter(
          function (item) {
            return item.pilot_status === 2;
          });
        unit_stats.pilot_pow_names.push(Array.from(new Set(pilot_status_buffer.map(
          function (item) {
            return {first_name: item.first_name, callsign: item.callsign, last_name: item.last_name};
          }
        ))));
        unit_stats.pilot_pow += pilot_status_buffer.length;

        pilot_status_buffer = unit_reports.filter(
          function (item) {
            return item.pilot_status === 3;
          });
        unit_stats.pilot_kia_names.push(Array.from(new Set(pilot_status_buffer.map(
          function (item) {
            return {first_name: item.first_name, callsign: item.callsign, last_name: item.last_name};
          }
        ))));
        unit_stats.pilot_kia += pilot_status_buffer.length;

        asset_status_buffer = unit_reports.filter(
          function (item) {
            return item.asset_status === 0;
          });
        unit_stats.asset_ok += asset_status_buffer.length;

        asset_status_buffer = unit_reports.filter(
          function (item) {
            return item.asset_status === 1;
          });
        unit_stats.asset_damaged += asset_status_buffer.length;

        asset_status_buffer = unit_reports.filter(
          function (item) {
            return item.asset_status === 2;
          });
        unit_stats.asset_lost += asset_status_buffer.length;


      }

      return unit_stats;
    },

    ...mapGetters("missionStore", [
      "filterByKey",
      "filterByKeys",
      "subTree"
    ])
  },

  methods: {

    pilot_pilots: function (number) {

      if(number > 1){
        return "pilots";
      } else {
        return "pilot";
      }
    },

    is_are: function (number) {

      if(number > 1){
        return "are";
      } else {
        return "is";
      }
    },

    was_were: function (number) {

      if(number > 1){
        return "were";
      } else {
        return "was";
      }
    },
  }
}
</script>

<style scoped>

</style>
