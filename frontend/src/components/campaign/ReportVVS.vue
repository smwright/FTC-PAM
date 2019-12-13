<template>
  <div class="polyglottTypewriter">
    <div class="biggerCenter">
      <span>ОТЧЕТ О БОЕВОМ ВЫЛЕТЕ.</span>
    </div>
    <br>
    <div style="margin-left: 8%;margin-right: 8%">
      <span>Ниже следует отчет подписавшегося внизу пилота который выполнял боевое задание {{ decodeHTML(report_info.mission_hist_date) }} защищая Советский Союз. Если ниже сообщение отсутствует, то сообщать не о чем.</span>
      <TextWithImage class="white-space-pre-line" v-bind:original_text="decodeHTML(report_info.synopsis)"></TextWithImage>
      <!--<p class="white-space-pre-line">{{ decodeHTML(report_info.synopsis) }}</p>-->
    </div>
    <br>
    <div class="bigRight">
      <ReportApprovalCompVVS></ReportApprovalCompVVS>
    </div>
    <div>
      <span style="margin-left: 8%" class="bigSignature">
        {{ decodeHTML(report_info.rank_name) }}
        {{ decodeHTML(report_info.first_name) }}
        {{ decodeHTML(report_info.last_name) }}
      </span>
    </div>
    <div style="margin-left: 8%;margin-right: 8%">
      <span> {{ decodeHTML(report_info.rank_name) }}
        {{ decodeHTML(report_info.first_name) }} '{{ report_info.callsign }}' {{ decodeHTML(report_info.last_name) }}
      </span>
    </div>
    <div style="margin-left: 8%;margin-right: 8%">
      <span>{{ reportAsset.name }}</span>
      <span>{{ decodeHTML(report_info.markings) }}</span>
    </div>
    <div style="margin-left: 8%;margin-right: 8%">
      <span>{{ reportUnit.hist_unit_name }}</span>,
      <span>{{ reportUnit.hist_unit_code }}</span>
    </div>
    <div style="margin-left: 8%;margin-right: 8%">
      <span>{{ decodeHTML(report_info.base) }}, {{ decodeHTML(report_info.mission_hist_date) }}</span>
    </div>
  </div>
</template>

<script>
  import stringConv from "../../resource/stringConverter"
  import statConv from "../../resource/statusConverter"
  import TextWithImage from "../basic_comp/TextWithImages"
  import ReportApprovalCompVVS from "./ReportApprovalCompVVS"
  import { mapState, mapGetters } from "vuex"

  export default {
    name: "ReportVVS",
    components: {
      TextWithImage,
      ReportApprovalCompVVS
    },
    mixins: [
      stringConv,
      statConv
    ],
    props: {

    },
    mounted () {

    },
    data () {
      return {
      }
    },
    computed: {

      ...mapState("missionStore", {
        report_info: state => state.report,
        report_details: state => state.report_details,
        aerial_claims: state => state.aerial_claims,
        ground_claims: state => state.ground_claims
      }),

      ...mapGetters("missionStore", [
        "reportUnit",
        "reportAsset"
      ])
    }
  }
</script>

<style scoped>

  .biggerCenter {
    font-size: x-large;
    text-align: center
  }

  .bigRight {
    float: right;
    font-size: large;
    margin-right: 8%;
  }


</style>

