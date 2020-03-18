<template>
  <div>
    <!--This part is for showing the report and claim slip edit elements-->

    <template v-if="this.show_edit_display">
      <div class="clearfix container margin-left-right">

        <div class="float-right">
          <button v-if="this.show_edit_button" v-on:click="toggleEdit" class="float-right">Exit edit</button>
          <button v-if="this.show_edit_button" v-on:click="sendReport" class="float-right">Send report</button>
        </div>
        <div class="info-text float-right">
          {{ info_text }}
        </div>
      </div>

      <div class="typed-on-paper" v-if="report_loaded">
        <EditReportLW v-if="report_info.faction==1" v-bind="report_info"></EditReportLW>
        <EditReportRAF v-else-if="report_info.faction==2" v-bind="report_info"></EditReportRAF>
        <EditReportVVS v-else-if="report_info.faction==3" v-bind="report_info"></EditReportVVS>
      </div>
      <br>
      <div class="typed-on-paper" v-if="report_loaded">
        <EditClaimSlipLW v-if="report_info.faction==1" v-bind="report_info"></EditClaimSlipLW>
        <EditClaimSlipRAF v-else-if="report_info.faction==2" v-bind="report_info"></EditClaimSlipRAF>
        <EditClaimSlipVVS v-else-if="report_info.faction==3" v-bind="report_info"></EditClaimSlipVVS>
      </div>
    </template>

    <!--This part is for showing the report and claim slip -->

    <template v-else>
      <div class="clearfix container">
        <button v-if="this.show_edit_button" v-on:click="toggleEdit" class="float-right">Edit report</button>
      </div>
      <!--<template v-if="report_info != undefined && report_details != undefined">-->
      <div class="typed-on-paper" v-if="report_loaded">
        <ReportLW v-if="report_info.faction==1" v-bind="report_info"></ReportLW>
        <ReportRAF v-else-if="report_info.faction==2" v-bind="report_info"></ReportRAF>
        <ReportVVS v-else-if="report_info.faction==3" v-bind="report_info"></ReportVVS>
      </div>
      <br>
      <div class="typed-on-paper" v-if="report_loaded">
        <ClaimSlipLW v-if="report_info.faction==1" v-bind="report_info"></ClaimSlipLW>
        <ClaimSlipRAF v-else-if="report_info.faction==2" v-bind="report_info"></ClaimSlipRAF>
        <ClaimSlipVVS v-else-if="report_info.faction==3" v-bind="report_info"></ClaimSlipVVS>

      </div>

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
import EditReportRAF from "./EditReportRAF"
import EditReportVVS from "./EditReportVVS"
import ClaimSlipRAF from "./ClaimSlipRAF"
import EditClaimSlipRAF from "./EditClaimSlipRAF"
import ClaimSlipLW from "./ClaimSlipLW"
import EditClaimSlipLW from "./EditClaimSlipLW"
import ClaimSlipVVS from "./ClaimSlipVVS"
import EditClaimSlipVVS from "./EditClaimSlipVVS"
import { mapState, mapGetters } from "vuex"



export default {
  name: "Report",
  components: {
    EditClaimSlipLW,
    ClaimSlipLW,
    EditClaimSlipRAF,
    ClaimSlipRAF,
    ReportLW,
    ReportRAF,
    ReportVVS,
    EditReportLW,
    EditReportRAF,
    EditReportVVS,
    ClaimSlipVVS,
    EditClaimSlipVVS
  },
  mounted () {

      this.loadReportInfo();
  },
  data () {
    return {

      report_loaded: false,
      edit_display: false,
      user_id: null,
      send_button_text: "Send Report",
      info_text: "",
      send_button_active: true,

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

      this.info_text = "Sending...";
      this.$store.dispatch('missionStore/sendReport',
        {
          caller: this.$options.name,
          path: this.$route.path
        })
        .then(response => {

          this.info_text = response;

        })
        .catch(error => {
          this.info_text = "ERROR: "+error;

        });
    }

  }
}
</script>

<style scoped>

.margin-left-right button{
  margin: 0px 5px;
}

.info-text{
  text-align: center;
  padding: 5px;
}

</style>
