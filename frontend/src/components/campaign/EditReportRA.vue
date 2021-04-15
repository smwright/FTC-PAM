<template>
  <div>
    <br>
    <br>
    <br>
    <div class="big">
      <span style="float: left"> {{ decodeHTML(report_info.last_name) }}, {{ decodeHTML(report_info.rank_name) }}
        <br>
        <select title="Here you must fill in the position in which you flew in the Sezione." v-model="report_sezione_pos">
          <option
            v-for="(sezione_pos, index) in sezionePosStatus"
            v-bind:value="index"
          >
            {{sezione_pos}}
          </option>
        </select>
        <select title="Here you must fill in which Sezione you flew in." v-model="report_sezione">
          <option
            v-for="(sezione, index) in sezioneStatus"
            v-bind:value="index"
          >
            {{sezione}}
          </option>
        </select>,
        <select title="Here you must fill in your unit." v-model="report_unit">
          <option
            v-for="d_unit in unitsByFaction(4)"
            v-bind:value="d_unit.depl_unit_id"
          >
            {{ d_unit.hist_unit_name }}
          </option>
        </select>
        <br>
        <select title="Here you must fill in your aircraft." v-model="report_aircraft">
          <option :value="null" disabled>Select aircraft</option>
          <option
            v-for="aircraft in assetByFactionControllable(4, 1)"
            v-bind:value="aircraft.id"
          >
            {{ aircraft.name }}
          </option>
        </select>
        /
        <input
          title="Here you must fill in the markings of your aircraft."
          placeholder="Markings"
          v-model="report_markings"
        >
      </span>
      <span style="float: right">
        <input
          title="Here you must fill in the base which you took off from."
          placeholder="Airfield"
          v-model="report_aerodrome"
        >
        , il {{ decodeHTML(report_info.mission_hist_date) }}
      </span>
    </div>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <div class="biggerCenter">
      <span style="text-decoration: underline">A seguire il rapporto sull'azione</span>
    </div>
    <br>
    <br>
    <div class="bigLWText">
      <span>Sortita di {{ decodeHTML(report_info.abreviation) }} {{ decodeHTML(report_info.last_name) }} scritta il {{ decodeHTML(report_info.mission_hist_date) }}.</span>
    </div>
    <div class="bigLWText">
      <textarea
        title="Here you can fill in a short synopsis for your sortie. If you are claiming any victories in the section below,
         this field is mandatory. You may insert screenshots with the [img]img-url[/img] tags."
        placeholder="Synopsis (optional)"
        v-model="report_synopsis"
        class="textarea-style"
      ></textarea>
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
  import EditClaimRA from "./EditClaimRA"
  import EditClaimGround from "./EditClaimGround"
  import Comment from "./Comment"
  import { mapState, mapGetters } from "vuex"

  export default {
    name: "EditReportRA",
    components: {
      EditClaimRA,
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

      report_sezione: {
        get () {
          var sezione = this.report_details.sezione;
          return sezione === undefined ? 4 : sezione;
        },
        set (value) {
          this.$store.commit('missionStore/updateReportValue',
            {
              array_name: "report_details",
              update_column_name: "sezione",
              update_column_value: value
            });
        }
      },

      report_sezione_pos: {
        get () {
          var sezione_pos = this.report_details.sezione_pos;
          return sezione_pos === undefined ? 4 : sezione_pos;
        },
        set (value) {
          this.$store.commit('missionStore/updateReportValue',
            {
              array_name: "report_details",
              update_column_name: "sezione_pos",
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
            enemy_status: 0,
            shared: 0
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
