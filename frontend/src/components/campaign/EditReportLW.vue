<template>
  <div>
    <br>
    <br>
    <br>
    <div class="big">
      <span style="float: left"> {{ decodeHTML(report_info.last_name) }}, {{ decodeHTML(report_info.rank_name) }}
        <br>
        <select title="Here you must fill in the position in which you flew in the Swarm." v-model="report_swarm_pos">
          <option
            v-for="(swarm_pos, index) in swarmPosStatus"
            v-bind:value="index"
          >
            {{swarm_pos}}
          </option>
        </select>
        <select title="Here you must fill in which Swarm you flew in." v-model="report_swarm">
          <option
            v-for="(swarm, index) in swarmStatus"
            v-bind:value="index"
          >
            {{swarm}}
          </option>
        </select>,
        <select title="Here you must fill in your unit." v-model="report_unit">
          <option
            v-for="d_unit in unitsByFaction(1)"
            v-bind:value="d_unit.depl_unit_id"
          >
            {{ d_unit.depl_unit_id}} - {{ d_unit.hist_unit_name }}
          </option>
        </select>
        <br>
        <select title="Here you must fill in your aircraft." v-model="report_aircraft">
          <option
            v-for="aircraft in assetByFactionControllable(1, 1)"
            v-bind:value="aircraft.id"
          >
            {{ aircraft.name }}
          </option>
        </select>
        /
        <input title="Here you must fill in the markings of your aircraft." v-model="report_markings">
      </span>
      <span style="float: right"> <input title="Here you must fill in the base which you took off from." v-model="report_aerodrome"> am {{ decodeHTML(report_info.mission_hist_date) }} </span>
    </div>
    <br>
    <br>
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
      <span>Zum Feindflug des {{ decodeHTML(report_info.abreviation) }} {{ decodeHTML(report_info.last_name) }}, verfasst im Felde am {{ decodeHTML(report_info.mission_hist_date) }}. Wenn hier nichts folgt, ist nichts zu berichten.</span>
    </div>
    <div class="bigLWText">
      <textarea title="Here you can fill in a short synopsis for your sortie. If you are claiming any victories in the section below, this field is mandatory. You may insert screenshots with the [img]img-url[/img] tags." v-model="report_synopsis" class="textarea-style"></textarea>
    </div>
    <div>
      <span style="margin-left: 15%" class="bigSignature">
        {{ decodeHTML(report_info.abreviation) }}
        {{ decodeHTML(report_info.first_name) }}
        {{ decodeHTML(report_info.last_name) }}
      </span>
    </div>
    <div>
      <span class="bigLeft">
        {{ decodeHTML(report_info.first_name) }}
        '{{ report_info.callsign }}'
        {{ decodeHTML(report_info.last_name) }},
        {{ decodeHTML(report_info.rank_name) }}
      </span>
    </div>
    <br>
    <br>
    <br>
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
  height: 20em;
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
