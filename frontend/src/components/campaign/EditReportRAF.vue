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
            v-for="d_unit in unitsByFaction(2)"
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
      <span>Flight:</span>
      <span>
         <select v-model="report_flight">
          <option
            v-for="(flight, index) in flightStatus"
            v-bind:value="index"
          >
            {{flight}}
          </option>
        </select>
      </span>

      <span>Section:</span>
      <span>
         <select v-model="report_section">
          <option
            v-for="(section, index) in sectionStatus"
            v-bind:value="index"
          >
            {{section}}
          </option>
        </select>
      </span>

      <span>Pos:</span>
      <span>
         <select v-model="report_section_pos">
          <option
            v-for="(section_pos, index) in sectionPosStatus"
            v-bind:value="index"
          >
            {{section_pos}}
          </option>
        </select>
      </span>
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
            v-for="aircraft in assetByFactionControllable(2, 1)"
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
      <span>Serial Nr.:</span>
      <span>
        <input v-model="report_serial_no">
      </span>
    </div>

    <div>
      <span>Synopsis (Optional): Images can be included by using [img]image-url[/img]</span><br>
      <textarea v-model="report_synopsis" class="textarea-style"></textarea>
    </div>

    <div>
      <button v-on:click="addAerialClaim">Add aerial claim</button>
    </div>

    <div>
      <hr>
      Claims:
      <EditClaimRAF
        v-for="aerial_claim in aerial_claims"
        v-bind:key="aerial_claim.claim_id"
        v-bind="aerial_claim"
      ></EditClaimRAF>
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
import EditClaimRAF from "./EditClaimRAF"
import EditClaimGround from "./EditClaimGround"
import { mapState, mapGetters } from "vuex"

export default {
  name: "EditReportRAF",
  components: {
    EditClaimRAF,
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

    report_flight: {
      get () {
        var flight = this.report_details.flight;
        return flight === undefined ? 2 : flight;
      },
      set (value) {
        this.$store.commit('missionStore/updateReportValue',
          {
            array_name: "report_details",
            update_column_name: "flight",
            update_column_value: value
          });
      }
    },

    report_section: {
      get () {
        var section = this.report_details.section;
        return section === undefined ? 8 : section;
      },
      set (value) {
        this.$store.commit('missionStore/updateReportValue',
          {
            array_name: "report_details",
            update_column_name: "section",
            update_column_value: value
          });
      }
    },

    report_section_pos: {
      get () {
        var section_pos = this.report_details.section_pos;
        return section_pos === undefined ? 5 : section_pos;
      },
      set (value) {
        this.$store.commit('missionStore/updateReportValue',
          {
            array_name: "report_details",
            update_column_name: "section_pos",
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

    report_serial_no: {
      get () {
        return this.report_info.serial_no;
      },
      set (value) {
        this.$store.commit('missionStore/updateReportValue',
          {
            array_name: "report_details",
            update_column_name: "serial_no",
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
  height: 10em;
}

</style>
