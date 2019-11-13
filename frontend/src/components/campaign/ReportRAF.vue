<template>
  <div>
    <div>
      <br>
      <span class="bigLeft">SECRET.</span>
      <span class="bigRight">FORM "F"</span>
    </div>
    <br>
    <br>
    <br>
    <div>
      <span class="biggerCenter">COMBAT REPORT.</span>
    </div>
    <br>
    <br>
    <br>
    <br>
    <br>
    <div>
      <span class="bigLeft">Sector Serial No.</span>
      <span class="bigCenterLettersA">(A)</span>
      <span class="bigContentRight"> J.1 </span>
    </div>
    <br>
    <div>
      <span class="bigLeft">Serial Number of Order Detailing Flight or Squadron to Patrol</span>
      <span class="bigCenterLettersB">(B)</span>
      <span class="bigContentRight"> NIL </span>
    </div>
    <br>
    <div>
      <span class="bigLeft">Date</span>
      <span class="bigCenterLettersC">(C)</span>
      <span class="bigContentRight">{{ decodeHTML(report_info.mission_hist_date) }} </span>
    </div>
    <br>
    <div>
      <span class="bigLeft">Flight, Squadron</span>
      <span class="bigCenterLettersD">(D)</span>
      <span class="bigContentRight">{{ flightStatus[report_details.flight] }}, {{ reportUnit.hist_unit_name }} ({{ reportUnit.hist_unit_code }})</span>
    </div>
    <br>
    <div>
      <span class="bigLeft">Number of Enemy Aircraft</span>
      <span class="bigCenterLettersE">(E)</span>
      <span class="bigContentRight"> {{ report_info.enemy_ac_number }} </span>
    </div>
    <br>
    <div>
      <span class="bigLeft">Type of Enemy Aircraft</span>
      <span class="bigCenterLettersF">(F)</span>
      <span class="bigContentRight"> {{ report_info.enemy_ac_type }} </span>
    </div>
    <br>
    <div>
      <span class="bigLeft">Time Attack was Delivered</span>
      <span class="bigCenterLettersG">(G)</span>
      <span class="bigContentRight"> {{ report_info.time_attack_delivered }} </span>
    </div>
    <br>
    <div>
      <span class="bigLeft">Place Attack was Delivered</span>
      <span class="bigCenterLettersH">(H)</span>
      <span class="bigContentRight"> {{ report_info.place_attack_delivered }} </span>
    </div>
    <br>
    <div>
      <span class="bigLeft">Height of Enemy</span>
      <span class="bigCenterLettersJ">(J)</span>
      <span class="bigContentRight"> {{ report_info.enemy_height }} </span>
    </div>
    <br>
    <div>
      <span class="bigLeft">Enemy Casualties</span>
      <span class="bigCenterLettersK">(K)</span>
      <span class="bigContentRight"> {{ report_info.enemy_casualty }} </span>
    </div>
    <br>
    <div>
      <span class="bigLeft">Our Casualties</span>
      <span class="bigCenterAircraft">Aircraft</span>
      <span class="bigCenterLettersL">(L)</span>
      <span class="bigContentRight"> {{ report_info.our_casualty_ac }} </span>
    </div>
    <br>
    <div>
      <span class="bigCenterPersonnel">Personnel</span>
      <span class="bigCenterLettersM">(M)</span>
      <span class="bigContentRight"> {{ report_info.our_casualty_personnel }} </span>
    </div>
    <br>
    <div>
      <span class="bigLeft">GENERAL REPORT</span>
      <span class="bigCenterLettersR">(R)</span>
    </div>
    <div class="synopsisText">
      <TextWithImage class="white-space-pre-line" v-bind:original_text="decodeHTML(report_info.synopsis)"></TextWithImage>
      <!--<p class="white-space-pre-line">{{ decodeHTML(report_info.synopsis) }}</p>-->
    </div>
    <div class="bigRight">
      <ReportApprovalComp></ReportApprovalComp>
    </div>
    <div>
      <span class="bigSignatureLeft">
        {{ decodeHTML(report_info.abreviation) }}
        {{ decodeHTML(report_info.first_name) }}
        {{ decodeHTML(report_info.last_name) }}
      </span>
    </div>
    <div>
      <span class="bigLeft">
        {{ sectionStatus[report_details.section] }} /
        {{ sectionPosStatus[report_details.section_pos] }}
      </span>
      <span class="bigContentCenter">
        R.A.F. {{ decodeHTML(report_info.base) }}
      </span>
    </div>
    <div>
      <span class="bigLeft">
        {{ decodeHTML(report_info.abreviation) }}
        {{ decodeHTML(report_info.first_name) }}
        '{{ report_info.callsign }}'
        {{ decodeHTML(report_info.last_name) }}
      </span>
    </div>
    <div>
      <span class="bigLeft">{{ reportAsset.name }}</span>
    </div>
    <div>
      <span class="bigLeft">{{ decodeHTML(report_info.markings) }}</span>
    </div>
    <br>
    <br>
  </div>
</template>

<script>
  import stringConv from "../../resource/stringConverter"
  import statConv from "../../resource/statusConverter"
  import TextWithImage from "../basic_comp/TextWithImages"
  import ClaimRAF from "./ClaimRAF"
  import ClaimGround from "./ClaimGround"
  import Comment from "./Comment"
  import ReportApprovalComp from "./ReportApprovalComp"
  import { mapState, mapGetters } from "vuex"

  export default {
    name: "ReportRAF",
    components: {
      ClaimRAF,
      ClaimGround,
      Comment,
      ReportApprovalComp,
      TextWithImage
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

  .bigRight {
    float: right;
    font-size: large;
    margin-right: 8%;
  }

  .bigLeft {
    font-size: large;
    margin-left: 8%;
  }

  .bigCenterLettersA {
    font-size: large;
    margin-left: 48%;
  }

  .bigCenterLettersB {
    font-size: large;
    margin-left: 69.1%;
  }

  .bigCenterLettersC {
    font-size: large;
    margin-left: 57.3%;
  }

  .bigCenterLettersD {
    font-size: large;
    margin-left: 48.5%;
  }

  .bigCenterLettersE {
    font-size: large;
    margin-left: 41.8%;
  }

  .bigCenterLettersF {
    font-size: large;
    margin-left: 43.8%;
  }

  .bigCenterLettersG {
    font-size: large;
    margin-left: 41.5%;
  }

  .bigCenterLettersH {
    font-size: large;
    margin-left: 40.8%;
  }

  .bigCenterLettersJ {
    font-size: large;
    margin-left: 49.1%;
  }

  .bigCenterLettersK {
    font-size: large;
    margin-left: 48.2%;
  }

  .bigCenterLettersL {
    font-size: large;
    margin-left: 23.5%;
  }

  .bigCenterAircraft {
    font-size: large;
    margin-left: 20%;
  }

  .bigCenterLettersM {
    font-size: large;
    margin-left: 22.8%;
  }

  .bigCenterLettersR {
    font-size: large;
    margin-left: 50%;
  }

  .bigCenterPersonnel {
    font-size: large;
    margin-left: 39.3%;
  }

  .synopsisText {
    text-align: left;
    font-size: large;
    margin-left: 8%;
    margin-right: 8%;
  }

  .biggerCenter {
    font-size: x-large;
    text-decoration: underline;
    margin-left: 40%;
  }

  .bigContentRight {
    font-size: large;
    position: relative;
    margin-left: 2%;
  }

  .bigContentLeft {
    font-size: large;
    position: relative;
    margin-left: 1%;
  }

  .bigContentCenter {
    font-size: large;
    position: relative;
    margin-left: 19%;
  }

</style>
