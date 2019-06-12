<template>
  <div>
    <div>
      <span>Squadron:</span>
      <span>{{ reportUnit.hist_unit_name }}</span>
    </div>

    <div>
      <span>Squadron:</span>
      <span>
        <select v-model="report_unit">
          <option
            v-for="d_unit in unitsByFaction(3)"
            v-bind:value="d_unit.depl_unit_id"
          >
            {{ d_unit.depl_unit_id}} - {{ d_unit.hist_unit_name }}
          </option>
        </select>
      </span>
    </div>

    <div>
      <span>Squadron code:</span>
      <span>{{ reportUnit.hist_unit_code }}</span>
    </div>

    <div>
      <span>Name:</span>
      <span> {{ decodeHTML(report_info.rank_name) }}
        {{ decodeHTML(report_info.first_name) }} '{{ report_info.callsign }}' {{ decodeHTML(report_info.last_name) }}</span>
    </div>

    <div>
      <span>Base:</span>
      <span>
        <input v-model="report_aerodrome">
      </span>
    </div>

    <div>
      <span>Type:</span>
      <span>
        <select v-model="report_aircraft">
          <option
            v-for="aircraft in assetByFactionControllable(3, 1)"
            v-bind:value="aircraft.id"
          >
            {{ aircraft.name }}
          </option>
        </select>
      </span>
    </div>

    <div>
      <span>Markings:</span>
      <span>
        <input v-model="report_markings">
      </span>
    </div>

    <div>
      <span>Synopsis:</span><br>
      <textarea v-model="report_synopsis" class="textarea-style"></textarea>
    </div>

    <div>
      <button v-on:click="addAerialClaim">Add aerial claim</button>
    </div>

    <div>
      <hr>
      Claims:
      <EditClaimVVS
        v-for="aerial_claim in aerial_claims"
        v-bind:key="aerial_claim.claim_id"
        v-bind="aerial_claim"
      ></EditClaimVVS>
    </div>

    <div>
      <button v-on:click="addGroundClaim">Add ground claim</button>
    </div>

    <div>
      <hr>
      Ground Claims:
      <EditClaimGround
        v-for="ground_claim in ground_claims"
        v-bind:key="ground_claim.claim_id"
        v-bind="ground_claim"
      ></EditClaimGround>
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
  import EditClaimVVS from "./EditClaimVVS"
  import EditClaimGround from "./EditClaimGround"
  import Comment from "./Comment"
  import { mapState, mapGetters } from "vuex"

  export default {
    name: "EditReportVVS",
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
    mounted () {

    },
    data () {
      return {
      }
    },
    computed: {

      report_unit: {
        get () {
          return this.report_info.depl_unit_id;
        },
        set (value) {
          this.$store.commit('missionStore/updateReportValue',
            {
              array_name: "report",
              update_column_name: "depl_unit_id",
              update_column_value: value
            });
        }
      },

      report_aerodrome: {
        get () {
          return this.report_info.base;
        },
        set (value) {
          this.$store.commit('missionStore/updateReportValue',
            {
              array_name: "report",
              update_column_name: "base",
              update_column_value: value
            });
        }
      },

      report_aircraft: {
        get () {
          return this.report_info.asset_id;
        },
        set (value) {
          this.$store.commit('missionStore/updateReportValue',
            {
              array_name: "report",
              update_column_name: "asset_id",
              update_column_value: value
            });
        }
      },

      report_markings: {
        get () {
          return this.report_info.markings;
        },
        set (value) {
          this.$store.commit('missionStore/updateReportValue',
            {
              array_name: "report",
              update_column_name: "markings",
              update_column_value: value
            });
        }
      },

      report_synopsis: {
        get () {
          return this.report_info.synopsis;
        },
        set (value) {
          this.$store.commit('missionStore/updateReportValue',
            {
              array_name: "report",
              update_column_name: "synopsis",
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
            witness_id: null
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

div {
  margin: 5px 0;
}

.textarea-style{
  width: 98%;
  height: 10em;
}

</style>

