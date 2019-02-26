<template>
  <div>
    <div class="to-add">REPORTS NEED TO BE ADDED</div>
    <ReportLW v-if="report_info.faction==1" v-bind="report_info"></ReportLW>
    <ReportRAF v-else-if="report_info.faction==2" v-bind="report_info"></ReportRAF>
  </div>
</template>

<script>
import ReportLW from "./ReportLW"
import ReportRAF from "./ReportRAF"

export default {
  name: "Report",
  components: {
    ReportLW,
    ReportRAF
  },
  mounted () {

    this.loadReportInfo();
  },
  data () {
    return {
      report_info: {},
    }
  },
  watch: {
    '$route.params.report_id': function () {
      this.loadReportInfo();
    }
  },
  methods: {

    loadReportInfo: function () {
      this.requestViewData(this.$options.name, {view: "report_info", report_id: this.$route.params.report_id})
        .then(response => {
          this.report_info = response[0];
          console.log(JSON.stringify(this.report_info));
        })
        .catch(error => {
          console.log(error.message);
        });
    }
  }
}
</script>

<style scoped>

</style>
