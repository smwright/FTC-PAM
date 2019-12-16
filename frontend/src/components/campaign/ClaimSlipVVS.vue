<template>
  <div class="polyglottTypewriter">
    <div>
      <hr>
      <span>Aerial Claims:</span>
      <ClaimVVS
        v-for="aerial_claim in aerial_claims"
        v-bind:key="aerial_claim.claim_id"
        v-bind="aerial_claim"
      ></ClaimVVS>
    </div>
    <div>
      <hr>
      <span>Ground Claims:</span>
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
  import ClaimVVS from "./ClaimVVS"
  import ClaimGround from "./ClaimGround"
  import Comment from "./Comment"
  import { mapState, mapGetters } from "vuex"

  export default {
    name: "ClaimSlipVVS",
    components: {
      ClaimVVS,
      ClaimGround,
      Comment
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

</style>
