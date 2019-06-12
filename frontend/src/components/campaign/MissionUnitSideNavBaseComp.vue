<template>
  <div class="mainContainer">
    <div>
      <div class="inline">
        <button v-show="children.length >0" v-on:click.stop="toggleChildUnits">{{showChildUnitsButtonText}}</button>
        <button v-show="hasReports" v-on:click.stop="toggleReports">{{showReportsButtonText}}</button>
        <span class="heading">{{ name }}</span>
      </div>
    </div>
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
    </DivLinkButton>
  </div>
</template>

<script>
import MissionUnitsSideNavBaseComp from "./MissionUnitSideNavBaseComp";
import DivLinkButton from "../basic_comp/DivLinkButton";
import stringConv from "../../resource/stringConverter"

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
      id: {
        type: Number,
        default: null
      },
      name: String,
      children: {
        type: Array,
        default: function () {
          return [];
        }
      },
    },
    data () {
      return {
        reports: [],
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
    watch: {
      '$route.params.mission_id': function () {
        this.loadReports();
      }
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
        if(this.$props.children.length === 0)
          this.$dbCon.requestViewData(this.$options.name, {view:"mission_report_nav_list", mission_id:this.$route.params.mission_id,
          depl_unit_id:this.$props.id})
            .then(response => {
              this.hasReports = response.length > 0;
              this.reports = this.$dbCon.nestData(response);
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
