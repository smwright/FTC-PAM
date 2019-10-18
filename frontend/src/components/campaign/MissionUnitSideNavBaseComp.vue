<template>
  <div class="mainContainer" >
    <div>
      <div class="inline" v-bind:class="{ axis: isAxis, allied: isAllied }">
        <button v-show="children.length >0" v-on:click.stop="toggleChildUnits">{{showChildUnitsButtonText}}</button>
        <button v-show="reportsByUnit(depl_unit_id).length > 0" v-on:click.stop="toggleReports">{{showReportsButtonText}}</button>
        <img class="unitEmblem" :src="image"/>
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

        // hasReports: false,
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

      // hasReports: function () {
      //
      //   return this.reportsByUnit(dep_unit_id).length > 0;
      // },
      isAxis: function () {

        return this.faction === 1;
      },

      isAllied: function () {

        return this.faction === 2 || this.faction ===3;
      },

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

        if(this.$props.depl_unit_id !== null){

          this.$store.dispatch('missionStore/loadReports',
            {
              caller: this.$options.name,
              mission_id:this.$route.params.mission_id,
              depl_unit_id:this.$props.depl_unit_id
            })
            .then(response => {
               // this.hasReports = response;
               // this.reports = this.$dbCon.nestData(response);
            })
            .catch(error => {
              console.log(error.message);
            });
        }
      }
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
