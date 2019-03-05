<template>
  <div>
    <div>
      <span>Name:</span>
      <span>{{ first_name }} '{{ callsign }}' {{ last_name }}</span>
    </div>

    <div>
      <span>Rank:</span>
      <span>{{ decodeHTML(rank_name) }}</span>
    </div>

    <div>
      <span>Squadron:</span>
      <span>{{ unit_name }}</span>
    </div>

    <div>
      <span>Swarm:</span>
      <span>{{ swarmStatus[report_details.swarm] }}</span>

      <span>Swarm Pos.:</span>
      <span>{{ swarmPosStatus[report_details.swarm_pos] }}</span>
    </div>

    <div>
      <span>Type:</span>
      <span>{{ asset_name }}</span>
    </div>

    <div>
      <span>Markings:</span>
      <span>{{ decodeHTML(markings) }}</span>
    </div>

    <div>
      <span>Aerodrome:</span>
      <span>{{ base }}</span>
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

    <div>
      <hr>
      Claims:
      <ClaimLW
        v-for="aerial_claim in aerial_claims"
        v-bind:key="aerial_claim.claim_id"
        v-bind="aerial_claim"
      ></ClaimLW>
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
      <span>Synopsis:</span><br>
      <p class="white-space-pre-line">{{ decodeHTML(synopsis) }}</p>
    </div>

    <Comment></Comment>
  </div>
</template>

<script>
import statConv from "../../resource/statusConverter"
import stringConv from "../../resource/stringConverter"
import ClaimLW from "./ClaimLW"
import ClaimGround from "./ClaimGround"
import Comment from "./Comment"

export default {
  name: "ReportLW",
  components: {
    ClaimLW,
    ClaimGround,
    Comment
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
    rank_name: {
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
      type: String,
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

    this.$dbCon.requestViewData(this.$options.name, {view:"report_lw", report_id:this.$route.params.report_id})
      .then(response => {
        this.report_details = response[0];
      })
      .catch(error => {
        console.log(error.message);
      });
    this.$dbCon.requestViewData(this.$options.name, {view:"claim_lw_info", report_id:this.$route.params.report_id})
      .then(response => {
        this.aerial_claims = response;
      })
      .catch(error => {
        console.log(error.message);
      });
    this.$dbCon.requestViewData(this.$options.name, {view:"claim_ground_info", report_id:this.$route.params.report_id})
      .then(response => {
        this.ground_claims = response;
      })
      .catch(error => {
        console.log(error.message);
      });
  },
  data () {
    return {
      report_details: {},
      aerial_claims: {},
      ground_claims: {}
    }
  },
}
</script>

<style scoped>

</style>
