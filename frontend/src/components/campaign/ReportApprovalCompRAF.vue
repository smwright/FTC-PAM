<template>
  <div class="clearfix">
    <span>Approved by:</span>
    <br>
    <span class="bigSignature" v-if="report_info.accepted && report_info.accepted_by !== null">{{ memberById(report_info.accepted_by).callsign }}</span>
    <br>
    <br>
    <button
      v-if="isAdmin"
      class="float-right"
      v-on:click="acceptRejectReport"
    >{{ acceptButtonText }}</button>
  </div>
</template>

<script>

import { mapState, mapGetters } from "vuex"

export default {
  name: "ReportApprovalCompRAF",
  mounted ()  {

    this.checkAdmin();
  },
  data () {
    return {

      isAdmin: false
    }
  },
  computed: {

    acceptButtonText() {

      if(this.report_info.accepted){
        return "Revoke report acceptance";
      } else {
        return "Approve report";
      }
    },

    ...mapState("missionStore", {
      report_info: state => state.report,
    }),

    ...mapGetters("missionStore", [
      "memberById"
    ])
  },
  methods: {

    checkAdmin: async function () {

      this.isAdmin = await this.$auth.isAdmin(this.$options.name);
    },

    acceptRejectReport: async function () {

      this.$store.dispatch('missionStore/acceptRejectReport',
        {
          caller: this.$options.name,
          member_id: await this.$auth.getUserId(),
        });
    }
  }

}
</script>

<style scoped>

</style>
