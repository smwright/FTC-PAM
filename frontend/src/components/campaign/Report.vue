<template>
  <div>
    <!--This part is for showing the report edit elements-->

    <template v-if="this.show_edit_display">
      <div class="clearfix">
        <button v-if="this.show_edit_button" v-on:click="toggleEdit" class="float-right">Exit edit</button>
        <button v-if="this.show_edit_button" v-on:click="sendReport" class="float-right">Send report</button>
      </div>
      <template v-if="report_loaded">
        <EditReportLW v-if="report_info.faction==1" v-bind="report_info"></EditReportLW>
        <!--<ReportRAF v-else-if="report_info.faction==2" v-bind="report_info"></ReportRAF>-->
        <EditReportVVS v-else-if="report_info.faction==3" v-bind="report_info"></EditReportVVS>
      </template>
    </template>

    <!--This part is for showing the report -->

    <template v-else>
      <div class="clearfix">
        <button v-if="this.show_edit_button" v-on:click="toggleEdit" class="float-right">Edit report</button>
      </div>
      <!--<template v-if="report_info != undefined && report_details != undefined">-->
      <template v-if="report_loaded">
        <ReportLW v-if="report_info.faction==1" v-bind="report_info"></ReportLW>
        <ReportRAF v-else-if="report_info.faction==2" v-bind="report_info"></ReportRAF>
        <ReportVVS v-else-if="report_info.faction==3" v-bind="report_info"></ReportVVS>
      </template>
      <template v-else>
        Loading report...
      </template>
    </template>
  </div>
</template>

<script>
import ReportLW from "./ReportLW"
import ReportRAF from "./ReportRAF"
import ReportVVS from "./ReportVVS"
import EditReportLW from "./EditReportLW"
import EditReportVVS from "./EditReportVVS"
import { mapState, mapGetters } from "vuex"

export default {
  name: "Report",
  components: {
    ReportLW,
    ReportRAF,
    ReportVVS,
    EditReportLW,
    EditReportVVS
  },
  mounted () {

      this.loadReportInfo();
  },
  data () {
    return {

      report_loaded: false,
      edit_display: false,
      user_id: null
    }
  },
  computed: {

    show_edit_button: function () {
      return (this.missionStatusById(this.$route.params.mission_id) == 1
        && this.report_info != undefined
        && this.report_info.member_id == this.user_id) ;
    },

    show_edit_display: function () {
      return (this.missionStatusById(this.$route.params.mission_id) == 1
        && this.edit_display
        && this.report_info != undefined
        && this.report_info.member_id == this.user_id) ;
    },
    ...mapState("missionStore", {
      report_info: state => state.report,
      report_details: state => state.report_details,
    }),

    ...mapGetters("missionStore", [
      "missionById",
      "missionStatusById"
    ])
  },
  watch: {
    '$route.params.report_id': function () {
      this.loadReportInfo();
    }
  },
  methods: {

    loadReportInfo: async function () {

      this.report_loaded = false;
      this.user_id = await this.$auth.getUserId(this.$options.name);
      this.$store.dispatch('missionStore/loadReport',
        {
          caller: this.$options.name,
          report_id: this.$route.params.report_id,
          campaign_id: this.$route.params.campaign_id
        }
        ).then(response => {
          this.report_loaded = true;
        }).catch(error => {
          console.log(error.message);
        });

      if(this.$route.params.report_id < 0 ){
        this.edit_display = true;
      }
    },

    toggleEdit: function () {

      this.edit_display = !this.edit_display;

    },

    sendReport: function () {

      this.$store.dispatch('missionStore/sendReport', {caller: this.$options.name})
        .catch(error => {
          console.log(error.message);
        });
    }

  }
}
</script>

<style scoped>

</style>
