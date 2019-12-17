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

    <div class="reportContainer clearfix">
      <div class="float-left">
        <div class="bigSignature">
          {{ decodeHTML(report_info.rank_name) }}
          {{ decodeHTML(report_info.first_name) }}
          {{ decodeHTML(report_info.last_name) }}
        </div>
        <div>
          {{ decodeHTML(report_info.rank_name) }}
          {{ decodeHTML(report_info.first_name) }}
          '{{ report_info.callsign }}'
          {{ decodeHTML(report_info.last_name) }}
        </div>
        <div>
          {{ reportAsset.name }}
          {{ decodeHTML(report_info.markings) }}
        </div>
        <div>
          {{ reportUnit.hist_unit_name }},
          {{ reportUnit.hist_unit_code }}
        </div>
        <div>
          {{ decodeHTML(report_info.base) }},
          {{ decodeHTML(report_info.mission_hist_date) }}
        </div>
      </div>

      <ReportApprovalComp
      class="float-right"
      v-bind="{stampImage:'/assets/images/webpage_images/vvs-stamp.png'}"
      ></ReportApprovalComp>
    </div>

  </div>
</template>

<script>
  import stringConv from "../../resource/stringConverter"
  import statConv from "../../resource/statusConverter"
  import TextWithImage from "../basic_comp/TextWithImages"
  import ReportApprovalComp from "./ReportApprovalComp"
  import { mapState, mapGetters } from "vuex"

  export default {
    name: "ReportVVS",
    components: {
      TextWithImage,
      ReportApprovalComp
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

  .reportContainer {
    margin-left: 8%;
    margin-right: 8%;
  }

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

