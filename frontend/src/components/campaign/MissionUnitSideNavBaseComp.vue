<template>
  <div class="mainContainer" >
      <DivLinkButton
        class="inline"
        v-bind:class="{ axis: isAxis, allied: isAllied }"
        v-bind="{routeName: 'MissionSynop', routeParams: {depl_unit_id: depl_unit_id}}"
      >
        <button v-show="children.length > 0" v-on:click.stop="toggleChildUnits">{{showChildUnitsButtonText}}</button>
        <button v-show="reports.length > 0" v-on:click.stop="toggleReports">{{showReportsButtonText}}</button>
        <img class="unitEmblem" :src="image"/>
        <span class="heading">{{ hist_unit_name }}</span>
      </DivLinkButton>
    <div class="unit-name" v-show="showChildUnits" v-for="child in children">
      <MissionUnitsSideNavBaseComp v-bind="child"></MissionUnitsSideNavBaseComp>
    </div>
    <DivLinkButton
      v-if="showReports"
      v-for="report in reports"
      v-bind:key="report.report_id"
      v-bind:class="{ acceptedReport: report.accepted }"
      v-bind="{routeName: 'Report', routeParams: {report_id: report.report_id}}"
    >
     {{report.abreviation}} {{ decodeHTML(report.first_name) }} '{{report.callsign}}' {{ decodeHTML(report.last_name) }}
      <span v-if="report.accepted" class="float-right">
        &#10004;
      </span>
    </DivLinkButton>
  </div>
</template>

<script>
import MissionUnitsSideNavBaseComp from "./MissionUnitSideNavBaseComp";
import DivLinkButton from "../basic_comp/DivLinkButton";
import stringConv from "../../resource/stringConverter"
import { mapState, mapGetters} from "vuex"

  export default {
    name: "MissionUnitsSideNavBaseComp",
    components: {
      MissionUnitsSideNavBaseComp,
      DivLinkButton,
    },
    mixins: [
      stringConv
    ],
    props: {
      depl_unit_id: {
        type: Number,
        default: null
      },
      hist_unit_name: String,
      children: {
        type: Array,
        default: function () {
          return [];
        }
      },
      faction: {
        type: Number,
        default: null
      },
      image: {
        type: String,
        default: null
      }

    },
    data () {
      return {

        showChildUnits: true,
        showChildUnitsButtonText: "-",
        showReports: false,
        showReportsButtonText: "+",
      }
    },
    computed: {

      reports: function () {

        return this.filterByKey("reports", "depl_unit_id", this.depl_unit_id);
      },

      isAxis: function () {

        return this.faction === 1;
      },

      isAllied: function () {

        return this.faction === 2 || this.faction ===3;
      },

      ...mapGetters("missionStore", [
        "filterByKey"
      ])
    },
    methods: {

      toggleChildUnits: function () {
        this.showChildUnits = !this.showChildUnits
        if(this.showChildUnits) {
          this.showChildUnitsButtonText = "-"
        } else {
          this.showChildUnitsButtonText = "+"
        }
      },
      toggleReports: function () {
        this.showReports = !this.showReports
        if(this.showReports) {
          this.showReportsButtonText = "-"
        } else {
          this.showReportsButtonText = "+"
        }
      },
    },
  }
</script>

<style scoped>

.unit-name {
  margin: 10px 0px;
}

.mainContainer {
  margin: 0px 0px 0px 5px;

}

.acceptedReport {
  background-color: rgba(0,255,0,0.25);
}

.unitEmblem {
  height: 37px;
  vertical-align: middle;
}

</style>
