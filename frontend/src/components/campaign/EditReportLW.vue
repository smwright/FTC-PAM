<template>
  <div>
    <div>
      <span>Name:</span>
      <span>{{ decodeHTML(first_name) }} '{{ callsign }}' {{ decodeHTML(last_name) }}</span>
    </div>

    <div>
      <span>Rank:</span>
      <span>{{ decodeHTML(rank_name) }}</span>
    </div>

    <div>
      <span>Squadron:</span>
      <span>
        <select v-model="report_unit">
          <option
            v-for="d_unit in unitsByFaction(1)"
            v-bind:value="d_unit.depl_unit_id"
          >
            {{ d_unit.depl_unit_id}} - {{ d_unit.hist_unit_name }}
          </option>
        </select>
      </span>
    </div>

    <div>
      <span>Swarm:</span>
      <span>
         <select v-model="report_swarm">
          <option
            v-for="(swarm, index) in swarmStatus"
            v-bind:value="index"
          >
            {{swarm}}
          </option>
        </select>
      </span>

      <span>Swarm Pos.:</span>
      <span>
         <select v-model="report_swarm_pos">
          <option
            v-for="(swarm_pos, index) in swarmPosStatus"
            v-bind:value="index"
          >
            {{swarm_pos}}
          </option>
        </select>
      </span>
    </div>

    <div>
      <span>Type:</span>
      <span>
        <select v-model="report_aircraft">
          <option
            v-for="aircraft in assetByFactionControllable(1, 1)"
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
      <span>Aerodrome:</span>
      <span>
        <input v-model="report_aerodrome">
      </span>
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

    <div>
      <button v-on:click="addAerialClaim">Add aerial claim</button>
    </div>

    <div>
      <hr>
      Claims:
      <EditClaimLW
        v-for="aerial_claim in aerial_claims"
        v-bind:key="aerial_claim.claim_id"
        v-bind:claim_id="aerial_claim.claim_id"
      ></EditClaimLW>
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
      <span>Synopsis:</span><br>
      <textarea v-model="report_synopsis" class="textarea-style"></textarea>
    </div>
  </div>
</template>

<script>
  import statConv from "../../resource/statusConverter"
  import stringConv from "../../resource/stringConverter"
  import EditClaimLW from "./EditClaimLW"
  import EditClaimGround from "./EditClaimGround"
  import Comment from "./Comment"
  import { mapState, mapGetters } from "vuex"

  export default {
    name: "EditReportLW",
    components: {
      EditClaimLW,
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

      report_swarm: {
        get () {
          var swarm = this.report_details.swarm;
          return swarm === undefined ? 4 : swarm;
        },
        set (value) {
          this.$store.commit('missionStore/updateReportValue',
            {
              array_name: "report_details",
              update_column_name: "swarm",
              update_column_value: value
            });
        }
      },

      report_swarm_pos: {
        get () {
          var swarm_pos = this.report_details.swarm_pos;
          return swarm_pos === undefined ? 4 : swarm_pos;
        },
        set (value) {
          this.$store.commit('missionStore/updateReportValue',
            {
              array_name: "report_details",
              update_column_name: "swarm_pos",
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
            opponent: null,
            fate_of_crew: 0,
            type_of_destruction: 0,
            type_of_impact: 0,
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
