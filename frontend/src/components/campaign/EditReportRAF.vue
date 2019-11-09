<template>
  <div>
    <div>
      <br>
      <span class="bigLeft">SECRET.</span>
      <span class="bigRight">FORM "F"</span>
    </div>
    <br>
    <br>
    <br>
    <div>
      <span class="biggerCenter">COMBAT REPORT.</span>
    </div>
    <br>
    <br>
    <br>
    <div>
      <span class="bigLeft">Sector Serial No.</span>
      <span class="bigCenterLettersA">(A)</span>
      <span class="bigContentRight"> J.1 </span>
    </div>

    <div>
      <span class="bigLeft">Serial Number of Order Detailing Flight or Squadron to Patrol</span>
      <span class="bigCenterLettersB">(B)</span>
      <span class="bigContentRight"> NIL </span>
    </div>

    <div>
      <span class="bigLeft">Date</span>
      <span class="bigCenterLettersC">(C)</span>
      <span class="bigContentRight">{{ decodeHTML(report_info.mission_hist_date) }} </span>
    </div>

    <div>
      <span class="bigLeft">Flight, Squadron</span>
      <span class="bigCenterLettersD">(D)</span>
      <span class="bigContentRight">
         <select v-model="report_flight">
          <option
            v-for="(flight, index) in flightStatus"
            v-bind:value="index"
          >
            {{flight}}
          </option>
        </select>,
        <select v-model="report_unit">
          <option
            v-for="d_unit in unitsByFaction(2)"
            v-bind:value="d_unit.depl_unit_id"
          >
            {{ d_unit.depl_unit_id}} - {{ d_unit.hist_unit_name }}
          </option>
        </select>
        ({{ reportUnit.hist_unit_code }})
      </span>
    </div>
    <div>
      <span class="bigLeft">Number of Enemy Aircraft</span>
      <span class="bigCenterLettersE">(E)</span>
    </div>
    <div>
      <span class="bigLeft">Type of Enemy Aircraft</span>
      <span class="bigCenterLettersF">(F)</span>
    </div>
    <div>
      <span class="bigLeft">Time Attack was Delivered</span>
      <span class="bigCenterLettersG">(G)</span>
    </div>
    <div>
      <span class="bigLeft">Place Attack was Delivered</span>
      <span class="bigCenterLettersH">(H)</span>
    </div>
    <div>
      <span class="bigLeft">Height of Enemy</span>
      <span class="bigCenterLettersJ">(J)</span>
    </div>
    <br>
    <div>
      <span class="bigLeft">Enemy Casualties</span>
      <span class="bigCenterLettersK">(K)</span>
    </div>
    <div>
      <span class="bigLeft">Our Casualties</span>
      <span class="bigCenterAircraft">Aircraft</span>
      <span class="bigCenterLettersL">(L)</span>
    </div>
    <div>
      <span class="bigCenterPersonnel">Personnel</span>
      <span class="bigCenterLettersM">(M)</span>
    </div>
    <div>
      <span class="bigLeft">GENERAL REPORT</span>
      <span class="bigCenterLettersR">(R)</span>
      <br>
      <br>
      <textarea v-model="report_synopsis" class="textarea-style"></textarea>
    </div>
    <br>
    <div class="bigRight">
      <span>Approved by:</span>
    </div>
    <div class="bigLeft">
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

    <div class="bigLeft">
      <span> {{ decodeHTML(report_info.abreviation) }}
        {{ decodeHTML(report_info.first_name) }} '{{ report_info.callsign }}' {{ decodeHTML(report_info.last_name) }}</span>
    </div>

    <div class="bigLeft">
      <span>Base:</span>
      <span>
        <input v-model="report_aerodrome">
      </span>
    </div>

    <div class="bigLeft">
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

    <div class="bigLeft">
      <span>Markings:</span>
      <span>
        <input v-model="report_markings">
      </span>
    </div>

    <div>
      <span class="bigLeft">Serial Nr.:</span>
      <span>
        <input v-model="report_serial_no">
      </span>
    </div>
    <br>
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
        return this.report_details.serial_no;
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


.bigRight {
  float: right;
  font-size: large;
  margin-right: 8%;
}

.bigLeft {
  font-size: large;
  margin-left: 8%;
}

.bigCenterLettersA {
  font-size: large;
  margin-left: 48%;
}

.bigCenterLettersB {
  font-size: large;
  margin-left: 70%;
}

.bigCenterLettersC {
  font-size: large;
  margin-left: 58%;
}

.bigCenterLettersD {
  font-size: large;
  margin-left: 48.3%;
}

.bigCenterLettersE {
  font-size: large;
  margin-left: 40.7%;
}

.bigCenterLettersF {
  font-size: large;
  margin-left: 43.5%;
}

.bigCenterLettersG {
  font-size: large;
  margin-left: 40.7%;
}

.bigCenterLettersH {
  font-size: large;
  margin-left: 40.3%;
}

.bigCenterLettersJ {
  font-size: large;
  margin-left: 48.7%;
}

.bigCenterLettersK {
  font-size: large;
  margin-left: 47.9%;
}

.bigCenterLettersL {
  font-size: large;
  margin-left: 23.8%;
}

.bigCenterAircraft {
  font-size: large;
  margin-left: 20%;
}

.bigCenterLettersM {
  font-size: large;
  margin-left: 22%;
}

.bigCenterLettersR {
  font-size: large;
  margin-left: 46.8%;
}

.bigCenterPersonnel {
  font-size: large;
  margin-left: 40%;
}

.synopsisText {
  text-align: left;
  font-size: large;
  margin-left: 8%;
  margin-right: 8%;
}

.biggerCenter {
  font-size: x-large;
  text-decoration: underline;
  margin-left: 40%;
}

.bigContentRight {
  font-size: large;
  position: absolute;
  margin-left: 2%;
}

.bigContentLeft {
  font-size: large;
  position: absolute;
  margin-left: 1%;
}

.bigContentCenter{
  font-size: large;
  position: absolute;
  margin-left: 15%;
}


</style>
