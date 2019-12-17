<template>
  <div class="polyglottTypewriter">
    <div class="biggerCenter">
      <span>ОТЧЕТ О БОЕВОМ ВЫЛЕТЕ.</span>
    </div>
    <br>
    <div style="margin-left: 8%;margin-right: 8%">
      <span>Ниже следует отчет подписавшегося внизу пилота который выполнял боевое задание {{ decodeHTML(report_info.mission_hist_date) }} защищая Советский Союз. Если ниже сообщение отсутствует, то сообщать не о чем.</span>
      <textarea title="This is where you type a synopsis of how the mission went from your perspective. This field is optional in ACG. Images can be included by using [img]image-url[/img]" v-model="report_synopsis" class="textarea-style"></textarea>
    </div>
    <br>
    <div>
      <span style="margin-left: 8%" class="bigSignature">
        {{ decodeHTML(report_info.rank_name) }}
        {{ decodeHTML(report_info.first_name) }}
        {{ decodeHTML(report_info.last_name) }}
      </span>
    </div>
    <div style="margin-left: 8%;margin-right: 8%">
      <span> {{ decodeHTML(report_info.rank_name) }}
        {{ decodeHTML(report_info.first_name) }} '{{ report_info.callsign }}' {{ decodeHTML(report_info.last_name) }}
      </span>
    </div>
    <div style="margin-left: 8%;margin-right: 8%">
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
      <span>
        <input v-model="report_markings">
      </span>
    </div>
    <div style="margin-left: 8%;margin-right: 8%">
      <span>
        <select v-model="report_unit">
          <option
            v-for="d_unit in unitsByFaction(3)"
            v-bind:value="d_unit.depl_unit_id"
          >
            {{ d_unit.depl_unit_id}} - {{ d_unit.hist_unit_name }}
          </option>
        </select>
      </span>,
      <span>{{ reportUnit.hist_unit_code }}</span>
    </div>

    <div style="margin-left: 8%;margin-right: 8%">
      <span>
        <input v-model="report_aerodrome">
        , {{ decodeHTML(report_info.mission_hist_date) }}
      </span>
    </div>


  </div>
</template>

<script>
  import stringConv from "../../resource/stringConverter"
  import statConv from "../../resource/statusConverter"
  import { mapState, mapGetters } from "vuex"

  export default {
    name: "EditReportVVS",
    components: {

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
  height: 15em;
  font-family: "TrueTypewriter PolyglOTT";
}


.biggerCenter {
  font-size: x-large;
  text-align: center
}

.bigRight {
  float: right;
  font-size: large;
  margin-right: 8%;
}



</style>

