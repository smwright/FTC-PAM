<template>
  <div>
    <br>
    <br>
    <br>
    <div class="big">
      <span style="float: left"> {{ decodeHTML(report_info.last_name) }}, {{ decodeHTML(report_info.rank_name) }}
        <br>
        {{ swarmPosStatus[report_details.swarm_pos] }} {{ swarmStatus[report_details.swarm] }}, {{ reportUnit.hist_unit_name }}
        <br>
        {{ reportAsset.name }} / {{ decodeHTML(report_info.markings) }}
      </span>
      <span style="float: right"> {{ decodeHTML(report_info.base) }} am {{ decodeHTML(report_info.mission_hist_date) }} </span>
    </div>
    <br>
    <br>
    <br>
    <br>
    <div class="biggerCenter">
      <span style="text-decoration: underline">G e f e c h t s b e r i c h t</span>
    </div>
    <br>
    <br>
    <div class="bigLWText">
      <span>Zum Feindflug des {{ decodeHTML(report_info.abreviation) }} {{ decodeHTML(report_info.last_name) }}, verfasst im Felde am {{ decodeHTML(report_info.mission_hist_date) }}. Wenn nichts hier folgt, ist nichts zu berichten.</span>
    </div>
    <div class="bigLWText">
      <TextWithImage class="white-space-pre-line" v-bind:original_text="decodeHTML(report_info.synopsis)"></TextWithImage>
      <!--<p class="white-space-pre-line">{{ decodeHTML(report_info.synopsis) }}</p>-->
    </div>

    <div class="bigLWText clearfix">
      <div class="bigSignature">
        {{ decodeHTML(report_info.abreviation) }}
        {{ decodeHTML(report_info.first_name) }}
        {{ decodeHTML(report_info.last_name) }}
      </div>
      <div>
        {{ decodeHTML(report_info.first_name) }}
        '{{ report_info.callsign }}'
        {{ decodeHTML(report_info.last_name) }},
        {{ decodeHTML(report_info.rank_name) }}
      </div>

      <ReportApprovalCompLW class="float-right"></ReportApprovalCompLW>
    </div>

  </div>
</template>

<script>
import statConv from "../../resource/statusConverter"
import stringConv from "../../resource/stringConverter"
import TextWithImage from "../basic_comp/TextWithImages"
import ClaimLW from "./ClaimLW"
import ClaimGround from "./ClaimGround"
import Comment from "./Comment"
import ReportApprovalCompLW from "./ReportApprovalCompLW"
import { mapState, mapGetters } from "vuex"

export default {
  name: "ReportLW",
  components: {
    ClaimLW,
    ClaimGround,
    Comment,
    TextWithImage,
    ReportApprovalCompLW
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

.top-bottom-margin {
  margin: 5px 0px;
}

.biggerCenter {
  font-size: x-large;
  text-decoration: underline;
  text-align: center;
}

.bigRight {
  float: right;
  font-size: large;
  margin-right: 15%;
}

.bigLeft {
  font-size: large;
  margin-left: 15%;
}

.big{
  font-size: large;
  margin-left: 8%;
  margin-right: 8%;
}

.bigLWText {
  font-size: large;
  margin-left: 15%;
  margin-right: 15%;
}
</style>
