<template>
  <div class="polyglottTypewriter">
    <div>
      <hr>
      <span>Aerial Claims:</span>
      <EditClaimVVS
        v-for="aerial_claim in aerial_claims"
        v-bind:key="aerial_claim.claim_id"
        v-bind="aerial_claim"
      ></EditClaimVVS>
    </div>
    <div>
      <button v-on:click="addAerialClaim">Add aerial claim</button>
    </div>
    <div>
      <hr>
      <span>Ground Claims:</span>
      <EditClaimGround
        v-for="ground_claim in ground_claims"
        v-bind:key="ground_claim.claim_id"
        v-bind="ground_claim"
      ></EditClaimGround>
    </div>
    <div>
      <button v-on:click="addGroundClaim">Add ground claim</button>
    </div>
    <div>
      <hr>
      <span>Pilot status:</span>
      <span>
        <select v-model="report_pilot_status">
          <option
            v-for="(pilot_status, index) in pilotStatus"
            v-bind:value="index"
          >
            {{pilot_status}}
          </option>
        </select>
      </span>
    </div>

    <div>
      <span>Aircraft status:</span>
      <span>
        <select v-model="report_asset_status">
          <option
            v-for="(asset_status, index) in assetStatus"
            v-bind:value="index"
          >
            {{asset_status}}
          </option>
        </select>
      </span>
      <hr>
    </div>

  </div>

</template>

<script>
  import stringConv from "../../resource/stringConverter"
  import statConv from "../../resource/statusConverter"
  import EditClaimVVS from "./EditClaimVVS"
  import EditClaimGround from "./EditClaimGround"
  import Comment from "./Comment"
  import { mapState, mapGetters } from "vuex"

  export default {
    name: "EditClaimSlipVVS",
    components: {
      EditClaimVVS,
      EditClaimGround,
      Comment
    },
    mixins: [
      stringConv,
      statConv
    ],

    props: {
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
    },
    computed: {

      report_pilot_status: {
        get () {
          var pilot_status = this.report_info.pilot_status;
          return pilot_status === undefined ? 0 : pilot_status;
        },
        set (value) {
          this.$store.commit('missionStore/updateReportValue',
            {
              array_name: "report",
              update_column_name: "pilot_status",
              update_column_value: value
            });
        }
      },

      report_asset_status: {
        get () {
          var asset_status = this.report_info.asset_status;
          return asset_status === undefined ? 0 : asset_status;
        },
        set (value) {
          this.$store.commit('missionStore/updateReportValue',
            {
              array_name: "report",
              update_column_name: "asset_status",
              update_column_value: value
            });
        }
      },


      ...mapState("missionStore", {
        report_info: state => state.report,
        report_details: state => state.report_details,
        aerial_claims: state => state.aerial_claims,
        ground_claims: state => state.ground_claims
      }),

      ...mapGetters("missionStore", [
        "reportUnit",
        "unitsByFaction",
        "assetByFactionControllable"
      ])
    },
    methods: {

      addAerialClaim: function () {

        this.$store.commit('missionStore/addAerialClaim',
          {
            report_id: this.report_info.report_id,
            asset_id: null,
            claim_time: null,
            place: null,
            group_claim: 0,
            confirmed: 0,
            witness_id: null,
            description: null
          });
      },

      addGroundClaim: function () {

        this.$store.commit('missionStore/addGroundClaim',
          {
            report_id: this.report_info.report_id,
            asset_id: null,
            amount: 1,
            description: null
          });
      }
    }
  }
</script>

<style scoped>

</style>
