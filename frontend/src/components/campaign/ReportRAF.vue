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
    <div class="rTable">
      <div class="rTableRow">
        <div class="rTableCellLeft">Sector Serial No.</div>
        <div class="rTableCellCenter"></div>
        <div class="rTableCellLetter">(A)</div>
        <div class="rTableCellRight">J.1</div>
      </div>
      <div class="rTableRow">
        <div class="rTableCellLeft">Serial Number of Order Detailing Flight or Squadron to Patrol</div>
        <div class="rTableCellCenter"></div>
        <div class="rTableCellLetter"></div>
        <div class="rTableCellRight"></div>
      </div>
      <div class="rTableRow">
        <div class="rTableCellLeft"></div>
        <div class="rTableCellCenter"></div>
        <div class="rTableCellLetter">(B)</div>
        <div class="rTableCellRight">NIL</div>
      </div>
      <div class="rTableRow">
        <div class="rTableCellLeft">Date</div>
        <div class="rTableCellCenter"></div>
        <div class="rTableCellLetter">(C)</div>
        <div class="rTableCellRight"> {{ decodeHTML(report_info.mission_hist_date) }} </div>
      </div>
      <div class="rTableRow">
        <div class="rTableCellLeft">Flight, Squadron</div>
        <div class="rTableCellCenter"></div>
        <div class="rTableCellLetter">(D)</div>
        <div class="rTableCellRight"> {{ flightStatus[report_details.flight] }}, {{ reportUnit.hist_unit_name }} ({{ reportUnit.hist_unit_code }}) </div>
      </div>
      <div class="rTableRow">
        <div class="rTableCellLeft">Number of Enemy Aircraft</div>
        <div class="rTableCellCenter"></div>
        <div class="rTableCellLetter">(E)</div>
        <div class="rTableCellRight"> {{ numberEnemyACStatus[report_details.number_enemy_ac] }} </div>
      </div>
      <div class="rTableRow">
        <div class="rTableCellLeft">Type of Enemy Aircraft</div>
        <div class="rTableCellCenter"></div>
        <div class="rTableCellLetter">(F)</div>
        <div class="rTableCellRight"> {{ report_details.type_enemy_ac }} </div>
      </div>
      <div class="rTableRow">
        <div class="rTableCellLeft">Time Attack was Delivered</div>
        <div class="rTableCellCenter"></div>
        <div class="rTableCellLetter">(G)</div>
        <div class="rTableCellRight"> {{ report_details.time_attack_delivered }} </div>
      </div>
      <div class="rTableRow">
        <div class="rTableCellLeft">Place Attack was Delivered</div>
        <div class="rTableCellCenter"></div>
        <div class="rTableCellLetter">(H)</div>
        <div class="rTableCellRight"> {{ report_details.place_attack_delivered }} </div>
      </div>
      <div class="rTableRow">
        <div class="rTableCellLeft">Height of Enemy</div>
        <div class="rTableCellCenter"></div>
        <div class="rTableCellLetter">(J)</div>
        <div class="rTableCellRight"> {{ report_details.enemy_height }} </div>
      </div>
      <div class="rTableRow">
        <div class="rTableCellLeft">Enemy Casualties</div>
        <div class="rTableCellCenter"></div>
        <div class="rTableCellLetter">(K)</div>
        <div class="rTableCellRight"> {{ report_details.enemy_casualty }} </div>
      </div>
      <div class="rTableRow">
        <div class="rTableCellLeft">Our Casualties</div>
        <div class="rTableCellCenter">Aircraft</div>
        <div class="rTableCellLetter">(L)</div>
        <div class="rTableCellRight"> {{ report_details.our_casualty_ac }} </div>
      </div>
      <div class="rTableRow">
        <div class="rTableCellLeft"></div>
        <div class="rTableCellCenter">Personnel</div>
        <div class="rTableCellLetter">(M)</div>
        <div class="rTableCellRight"> {{ report_details.our_casualty_personnel }} </div>
      </div>
      <div class="rTableRow">
        <div class="rTableCellLeft">GENERAL REPORT</div>
        <div class="rTableCellCenter"></div>
        <div class="rTableCellLetter">(R)</div>
        <div class="rTableCellRight"></div>
      </div>
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

  .rTable {
    display: table;
    margin-left: 8%;
    margin-right: 2%;
    width: 90%;
  }
  .rTableRow {
    display: table-row;
  }
  .rTableCellLeft {
    display: table-cell;
    font-size: large;
    padding-top: 0.8%;
    width: 55%;
    padding-bottom: 0.8%;
    /* border: 1px solid #999999;*/
   }

   .rTableCellLetter {
     display: table-cell;
     font-size: large;
     padding-top: 0.8%;
     padding-bottom: 0.8%;
     width: 3%;
     /*border: 1px solid #999999;*/
   }

   .rTableCellRight {
     display: table-cell;
     font-size: large;
     padding-top: 0.8%;
     padding-bottom: 0.8%;
     width: 27%;
     /*border: 1px solid #999999;*/
}

  .rTableCellCenter {
    display: table-cell;
    font-size: large;
    padding-top: 0.8%;
    padding-bottom: 0.8%;
    width: 15%;
  /*border: 1px solid #999999;*/
}

.bigRight {
float: right;
font-size: large;
margin-right: 8%;
}

.bigLeft {
font-size: large;
margin-left: 8%;
}

.biggerCenter {
font-size: x-large;
text-decoration: underline;
margin-left: 40%;
}

.synopsisText {
  text-align: left;
  font-size: large;
  margin-left: 8%;
  margin-right: 8%;
}

</style>
