<template>
  <div class="mainContainer">
    <div>
      <div class="inline">
        <button v-show="children.length >0" v-on:click.stop="toggleChildUnits">{{showChildUnitsButtonText}}</button>
        <button v-show="hasReports" v-on:click.stop="toggleReports">{{showReportsButtonText}}</button>
        <span class="heading">{{ hist_unit_name }}</span>
      </div>
    </div>
    <div class="unit-name" v-show="showChildUnits" v-for="child in children">
      <MissionUnitsSideNavBaseComp v-bind="child"></MissionUnitsSideNavBaseComp>
    </div>
    <DivLinkButton
      v-if="showReports"
      v-for="report in reportsByUnit(depl_unit_id)"
      v-bind:key="report.report_id"
      v-bind:class="{ acceptedReport: report.accepted }"
      v-bind="{routeName: 'Report', routeParams: {report_id: report.report_id}}"
    >
     {{report.abreviation}} {{ decodeHTML(report.first_name) }} '{{report.callsign}}' {{ decodeHTML(report.last_name) }}
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
    },
    data () {
      return {

        hasReports: false,
        showChildUnits: true,
        showChildUnitsButtonText: "-",
        showReports: false,
        showReportsButtonText: "+",
      }
    },
    mounted () {

      this.loadReports();
    },
    computed: {

      ...mapGetters("missionStore", [
        "reportsByUnit",
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
      loadReports: function(){

        this.$store.dispatch('missionStore/loadReports',
          {
            caller: this.$options.name,
            mission_id:this.$route.params.mission_id,
            depl_unit_id:this.$props.depl_unit_id
          })
          .then(response => {
             this.hasReports = response;
             // this.reports = this.$dbCon.nestData(response);
          })
          .catch(error => {
            console.log(error.message);
          });
      }
    },
  }
</script>

<style scoped>

.unit-name {
  margin: 5px 0px;
}

.mainContainer {
  margin: 0px 0px 0px 5px;
}

.acceptedReport {
  background-color: rgba(0,255,0,0.25);
}
</style>
