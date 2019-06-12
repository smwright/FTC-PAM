<template>
  <div>
    <div>
      <span>Squadron:</span>
      <span>{{ unit_name }}</span>
    </div>

    <div>
      <span>Squadron code:</span>
      <span>{{ unit_code }}</span>
    </div>

    <div>
      <span>Flight/Section/Pos:</span>
      <span>
        {{ flightStatus[report_details.flight] }} /
        {{ sectionStatus[report_details.section] }} /
        {{ sectionPosStatus[report_details.section_pos] }}
      </span>
    </div>

    <div>
      <span>Name:</span>
      <span> {{ abreviation }} {{ decodeHTML(first_name) }} '{{ callsign }}' {{ decodeHTML(last_name) }}</span>
    </div>

    <div>
      <span>Base:</span>
      <span>{{ base }}</span>
    </div>

    <div>
      <span>Type:</span>
      <span>{{ asset_name }}</span>
    </div>

    <div>
      <span>Markings:</span>
      <span>{{ markings }}</span>
    </div>

    <div>
      <span>Serial Nr.:</span>
      <span>{{ report_details.serial_no }}</span>
    </div>

    <div>
      <span>Synopsis:</span><br>
      <p class="white-space-pre-line">{{ decodeHTML(synopsis) }}</p>
    </div>

    <div>
      <hr>
      Claims:
      <ClaimRAF
        v-for="aerial_claim in aerial_claims"
        v-bind:key="aerial_claim.claim_id"
        v-bind="aerial_claim"
      ></ClaimRAF>
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
      <span>{{ pilotStatus[pilot_status] }}</span>
    </div>

    <div>
      <span>Aircraft status:</span>
      <span>{{ assetStatus[asset_status] }}</span>
      <hr>
    </div>

    <ReportApprovalComp></ReportApprovalComp>
    <Comment></Comment>
  </div>
</template>

<script>
import stringConv from "../../resource/stringConverter"
import statConv from "../../resource/statusConverter"
import ClaimRAF from "./ClaimRAF"
import Comment from "./Comment"
import ReportApprovalComp from "./ReportApprovalComp"
import { mapState } from "vuex"

export default {
  name: "ReportRAF",
  components: {
    ClaimRAF,
    Comment,
    ReportApprovalComp
  },
  mixins: [
    stringConv,
    statConv
  ],
  props: {
    unit_name: {
      type: String,
      default: null
    },
    unit_code: {
      type: String,
      default: null
    },
    abreviation: {
      type: String,
      default: null
    },
    first_name: {
      type: String,
      default: null
    },
    last_name: {
      type: String,
      default: null
    },
    callsign: {
      type: String,
      default: null
    },
    depl_unit_id: {
      type: Number,
      default: null
    },
    base: {
      type: String,
      default: null
    },
    asset_name: {
      type: String,
      default: null
    },
    markings: {
      type: [String, Number],
      default: null
    },
    synopsis: {
      type: String,
      default: null
    },
    pilot_status: {
      type: Number,
      default: null
    },
    asset_status: {
      type: Number,
      default: null
    },
    accepted: {
      type: Number,
      default: false
    },
    examiner_callsign: {
      type: String,
      default: null
    }
  },
  mounted () {

  },
  data () {
    return {
    }
  },
  computed: {

    ...mapState("missionStore", {
      report_details: state => state.report_details,
      aerial_claims: state => state.aerial_claims,
      ground_claims: state => state.ground_claims
    }),
  }
}
</script>

<style scoped>

</style>
