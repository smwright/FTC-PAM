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
    <br>
    <br>
    <div class="rTable">
      <div class="rTableRow">
        <div class="rTableCellTop">Sector Serial No.</div>
        <div class="rTableCellTop"></div>
        <div class="rTableCellTop">(A)</div>
        <div class="rTableCellTop">J.1</div>
      </div>
      <div class="rTableRow">
        <div class="rTableCellTop">Serial Number of Order Detailing Flight or Squadron to Patrol</div>
        <div class="rTableCellTop"></div>
        <div class="rTableCellTop"></div>
        <div class="rTableCellTop"></div>
      </div>
      <div class="rTableRow">
        <div class="rTableCellTop"></div>
        <div class="rTableCellTop"></div>
        <div class="rTableCellTop">(B)</div>
        <div class="rTableCellTop">NIL</div>
      </div>
      <div class="rTableRow">
        <div class="rTableCellTop">Date</div>
        <div class="rTableCellTop"></div>
        <div class="rTableCellTop">(C)</div>
        <div class="rTableCellTop"> {{ decodeHTML(report_info.mission_hist_date) }} </div>
      </div>
      <div class="rTableRow">
        <div class="rTableCellTop">Flight, Squadron</div>
        <div class="rTableCellCenter"></div>
        <div class="rTableCellLetter">(D)</div>
        <div class="rTableCellRight">
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
              v-bind:value="d_unit.depl_unit_id">
              {{ d_unit.depl_unit_id}} - {{ d_unit.hist_unit_name }}
            </option>
          </select>
          ({{ reportUnit.hist_unit_code }})
        </div>
      </div>
      <div class="rTableRow">
        <div class="rTableCellLeft">Number of Enemy Aircraft</div>
        <div class="rTableCellCenter"></div>
        <div class="rTableCellLetter">(E)</div>
        <div class="rTableCellRight">
          <select v-model="report_number_enemy_ac">
          <option
            v-for="(number_enemy_ac, index) in numberEnemyACStatus"
            v-bind:value="index">
            {{number_enemy_ac}}
          </option>
        </select>
        </div>
      </div>
      <div class="rTableRow">
        <div class="rTableCellLeft">Type of Enemy Aircraft</div>
        <div class="rTableCellCenter"></div>
        <div class="rTableCellLetter">(F)</div>
        <div class="rTableCellRight">
          <input v-model="report_type_enemy_ac">
        </div>
      </div>
      <div class="rTableRow">
        <div class="rTableCellLeft">Time Attack was Delivered</div>
        <div class="rTableCellCenter"></div>
        <div class="rTableCellLetter">(G)</div>
        <div class="rTableCellRight">
          <input v-model="report_time_attack_delivered">
        </div>
      </div>
      <div class="rTableRow">
        <div class="rTableCellLeft">Place Attack was Delivered</div>
        <div class="rTableCellCenter"></div>
        <div class="rTableCellLetter">(H)</div>
        <div class="rTableCellRight">
          <input v-model="report_place_attack_delivered">
        </div>
      </div>
      <div class="rTableRow">
        <div class="rTableCellLeft">Height of Enemy</div>
        <div class="rTableCellCenter"></div>
        <div class="rTableCellLetter">(J)</div>
        <div class="rTableCellRight">
          <input v-model="report_enemy_height">
        </div>
      </div>
      <div class="rTableRow">
        <div class="rTableCellLeft">Enemy Casualties</div>
        <div class="rTableCellCenter"></div>
        <div class="rTableCellLetter">(K)</div>
        <div class="rTableCellRight">
          <input v-model="report_enemy_casualty">
        </div>
      </div>
      <div class="rTableRow">
        <div class="rTableCellLeft">Our Casualties</div>
        <div class="rTableCellCenter">Aircraft</div>
        <div class="rTableCellLetter">(L)</div>
        <div class="rTableCellRight">
          <input v-model="report_our_casualty_ac">
        </div>
      </div>
      <div class="rTableRow">
        <div class="rTableCellLeft"></div>
        <div class="rTableCellCenter">Personnel</div>
        <div class="rTableCellLetter">(M)</div>
        <div class="rTableCellRight">
          <input v-model="report_our_casualty_personnel">
        </div>
      </div>
      <div class="rTableRow">
        <div class="rTableCellLeft">GENERAL REPORT</div>
        <div class="rTableCellCenter"></div>
        <div class="rTableCellLetter">(R)</div>
        <div class="rTableCellRight"></div>
      </div>
    </div>
    <br>
    <div>
      <textarea style="
      margin-left: 8%;
      height: 20em;
      width: 83%" v-model="report_synopsis" class="textarea-style"></textarea>
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
    <br>
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


    report_number_enemy_ac: {
      get () {
        var number_enemy_ac = this.report_details.number_enemy_ac;
        return number_enemy_ac === undefined ? 9 : number_enemy_ac;
      },
      set (value) {
        this.$store.commit('missionStore/updateReportValue',
          {
            array_name: "report_details",
            update_column_name: "number_enemy_ac",
            update_column_value: value
          });
      }
    },


    report_type_enemy_ac: {
      get () {
        return this.report_details.type_enemy_ac;
      },
      set (value) {
        this.$store.commit('missionStore/updateReportValue',
          {
            array_name: "report_details",
            update_column_name: "type_enemy_ac",
            update_column_value: value
          });
      }
    },

    report_time_attack_delivered: {
      get () {
        return this.report_details.time_attack_delivered;
      },
      set (value) {
        this.$store.commit('missionStore/updateReportValue',
          {
            array_name: "report_details",
            update_column_name: "time_attack_delivered",
            update_column_value: value
          });
      }
    },

    report_place_attack_delivered: {
      get () {
        return this.report_details.place_attack_delivered;
      },
      set (value) {
        this.$store.commit('missionStore/updateReportValue',
          {
            array_name: "report_details",
            update_column_name: "place_attack_delivered",
            update_column_value: value
          });
      }
    },

    report_enemy_height: {
      get () {
        return this.report_details.enemy_height;
      },
      set (value) {
        this.$store.commit('missionStore/updateReportValue',
          {
            array_name: "report_details",
            update_column_name: "enemy_height",
            update_column_value: value
          });
      }
    },

    report_enemy_casualty: {
      get () {
        return this.report_details.enemy_casualty;
      },
      set (value) {
        this.$store.commit('missionStore/updateReportValue',
          {
            array_name: "report_details",
            update_column_name: "enemy_casualty",
            update_column_value: value
          });
      }
    },

    report_our_casualty_ac: {
      get () {
        return this.report_details.our_casualty_ac;
      },
      set (value) {
        this.$store.commit('missionStore/updateReportValue',
          {
            array_name: "report_details",
            update_column_name: "our_casualty_ac",
            update_column_value: value
          });
      }
    },

    report_our_casualty_personnel: {
      get () {
        return this.report_details.our_casualty_personnel;
      },
      set (value) {
        this.$store.commit('missionStore/updateReportValue',
          {
            array_name: "report_details",
            update_column_name: "our_casualty_personnel",
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

  .rTable {
    display: table;
    margin-left: 8%;
    margin-right: 2%;
    width: 90%;
  }
  .rTableRow {
    display: table-row;
  }
  .rTableCellLeft {
    display: table-cell;
    font-size: large;
    padding-top: 0.5%;
    width: 55%;
    padding-bottom: 0.5%;
    /* border: 1px solid #999999;*/
  }

  .rTableCellLetter {
    display: table-cell;
    font-size: large;
    padding-top: 0.48%;
    padding-bottom: 0.48%;
    width: 3%;
    /*border: 1px solid #999999;*/
  }

  .rTableCellRight {
    display: table-cell;
    font-size: large;
    padding-top: 0.48%;
    padding-bottom: 0.48%;
    width: 27%;
    /*border: 1px solid #999999;*/
  }

  .rTableCellTop {
    display: table-cell;
    font-size: large;
    padding-top: 0.8%;
    padding-bottom: 0.8%;
    /*border: 1px solid #999999;*/
  }

  .rTableCellCenter {
    display: table-cell;
    font-size: large;
    padding-top: 0.48%;
    padding-bottom: 0.48%;
    width: 15%;
    /*border: 1px solid #999999;*/
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

  .biggerCenter {
    font-size: x-large;
    text-decoration: underline;
    margin-left: 40%;
  }

  .synopsisText {
    text-align: left;
    font-size: large;
    margin-left: 8%;
  }
</style>
