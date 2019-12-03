<template>
  <div class="polyglottTypewriter">
    <div class="biggerCenter">
      <span>ОТЧЕТ О БОЕВОМ ВЫЛЕТЕ.</span>
    </div>
    <div style="margin-left: 8%;margin-right: 8%">
      <TextWithImage class="white-space-pre-line" v-bind:original_text="decodeHTML(report_info.synopsis)"></TextWithImage>
      <!--<p class="white-space-pre-line">{{ decodeHTML(report_info.synopsis) }}</p>-->
    </div>
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


    <div>
      <hr>
      Claims:
      <ClaimVVS
        v-for="aerial_claim in aerial_claims"
        v-bind:key="aerial_claim.claim_id"
        v-bind="aerial_claim"
      ></ClaimVVS>
    </div>

    <div>
      <hr>
      Ground Claims:
      <ClaimGround
        v-for="ground_claim in ground_claims"
        v-bind:key="ground_claim.claim_id"
        v-bind="ground_claim"
      ></ClaimGround>
    </div>

    <div>
      <hr>
      <span>Pilot status:</span>
      <span>{{ pilotStatus[report_info.pilot_status] }}</span>
    </div>

    <div>
      <span>Aircraft status:</span>
      <span>{{ assetStatus[report_info.asset_status] }}</span>
      <hr>
    </div>


    <Comment></Comment>
  </div>
</template>

<script>
  import stringConv from "../../resource/stringConverter"
  import statConv from "../../resource/statusConverter"
  import TextWithImage from "../basic_comp/TextWithImages"
  import ClaimVVS from "./ClaimVVS"
  import ClaimGround from "./ClaimGround"
  import Comment from "./Comment"
  import ReportApprovalCompVVS from "./ReportApprovalCompVVS"
  import { mapState, mapGetters } from "vuex"

  export default {
    name: "ReportVVS",
    components: {
      ClaimVVS,
      ClaimGround,
      Comment,
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

