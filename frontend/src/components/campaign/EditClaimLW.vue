<template>
  <div>
    <hr>
    <div>
      <button v-on:click="deleteClaim">X</button>
    </div>
    <table>
      <tr>
        <td>Time:</td>
        <td>Place:</td>
        <td>Aircraft:</td>
        <td>Markings:</td>
        <td></td>
      </tr>
      <tr>
        <td><input v-model="claim_time"></td>
        <td><input v-model="place"></td>
        <td>
          <select v-model="claim_aircraft">
            <option
              v-for="aircraft in assetByFaction(-1)"
              v-bind:value="aircraft.id"
            >
              {{ aircraft.name }}
            </option>
          </select>
        </td>
        <td><input v-model="opponent"></td>
      </tr>
      <tr>
        <td>Type of destruction:</td>
        <td>Type of impact on the ground:</td>
        <td>Fate of crew:</td>
        <td>Witness:</td>
      </tr>
      <tr>
        <!--<td>{{ claimLWTypeOfDestruction[type_of_destruction] }}</td>-->
        <td>
          <select v-model="type_of_destruction">
            <option
              v-for="(name, index) in claimLWTypeOfDestruction"
              v-bind:value="index"
            >
              {{ name }}
            </option>
          </select>
        </td>
        <!--<td>{{ claimLWTypeOfImpact[type_of_impact] }}</td>-->
        <td>
          <select v-model="type_of_impact">
            <option
              v-for="(name, index) in claimLWTypeOfImpact"
              v-bind:value="index"
            >
              {{ name }}
            </option>
          </select>
        </td>
        <!--<td>{{ claimLWFateOfCrew[fate_of_crew] }}</td>-->
        <td>
          <select v-model="fate_of_crew">
            <option
              v-for="(name, index) in claimLWFateOfCrew"
              v-bind:value="index"
            >
              {{ name }}
            </option>
          </select>
        </td>
        <td>
          <vSelect
            v-model="witness_id"
            v-bind:options="activeMembers"
            label="callsign"
            :reduce="callsign => callsign.member_id"
          ></vSelect>
        </td>
      </tr>

    </table>
    <br>
  </div>
</template>

<script>
import statConv from "../../resource/statusConverter"
import vSelect from 'vue-select'
import 'vue-select/dist/vue-select.css';
import { mapGetters } from "vuex"

  export default {
    name: "EditClaimLW",
    mixins: [
      statConv
    ],
    components: {
      vSelect
    },
    props: {
      claim_id: {
        type: Number,
        default: null
      }
    },
    computed: {

      claim_time: {
        get() {
          var claim = this.$store.getters['missionStore/aerialClaimById'](this.claim_id );
          return (claim !== undefined) ? claim.claim_time : "";
        },
        set(value) {
          this.$store.commit('missionStore/updateClaimValue',
            {
              array_name: "aerial_claims",
              id_column_name: "claim_id",
              id_column_value: this.claim_id,
              update_column_name: "claim_time",
              update_column_value: value
            });
        }
      },

      place: {
        get() {
          var claim = this.$store.getters['missionStore/aerialClaimById'](this.claim_id );
          return (claim !== undefined) ? claim.place : "";
        },
        set(value) {
          this.$store.commit('missionStore/updateClaimValue',
            {
              array_name: "aerial_claims",
              id_column_name: "claim_id",
              id_column_value: this.claim_id,
              update_column_name: "place",
              update_column_value: value
            });
        }
      },

      opponent: {
        get() {
          var claim = this.$store.getters['missionStore/aerialClaimById'](this.claim_id );
          return (claim !== undefined) ? claim.opponent : "";
        },
        set(value) {
          this.$store.commit('missionStore/updateClaimValue',
            {
              array_name: "aerial_claims",
              id_column_name: "claim_id",
              id_column_value: this.claim_id,
              update_column_name: "opponent",
              update_column_value: value
            });
        }
      },

      claim_aircraft: {
        get() {
          var claim = this.$store.getters['missionStore/aerialClaimById'](this.claim_id );
          return (claim !== undefined) ? claim.asset_id : null;
        },
        set(value) {
          this.$store.commit('missionStore/updateClaimValue',
            {
              array_name: "aerial_claims",
              id_column_name: "claim_id",
              id_column_value: this.claim_id,
              update_column_name: "asset_id",
              update_column_value: value
            });
        }
      },

      type_of_destruction: {
        get() {
          var claim = this.$store.getters['missionStore/aerialClaimById'](this.claim_id );
          return (claim !== undefined) ? claim.type_of_destruction : 0;
        },
        set(value) {
          this.$store.commit('missionStore/updateClaimValue',
            {
              array_name: "aerial_claims",
              id_column_name: "claim_id",
              id_column_value: this.claim_id,
              update_column_name: "type_of_destruction",
              update_column_value: value
            });
        }
      },

      type_of_impact: {
        get() {
          var claim = this.$store.getters['missionStore/aerialClaimById'](this.claim_id );
          return (claim !== undefined) ? claim.type_of_impact : 0;
        },
        set(value) {
          this.$store.commit('missionStore/updateClaimValue',
            {
              array_name: "aerial_claims",
              id_column_name: "claim_id",
              id_column_value: this.claim_id,
              update_column_name: "type_of_impact",
              update_column_value: value
            });
        }
      },

      fate_of_crew: {
        get() {
          var claim = this.$store.getters['missionStore/aerialClaimById'](this.claim_id );
          return (claim !== undefined) ? claim.fate_of_crew : 0;
        },
        set(value) {
          this.$store.commit('missionStore/updateClaimValue',
            {
              array_name: "aerial_claims",
              id_column_name: "claim_id",
              id_column_value: this.claim_id,
              update_column_name: "fate_of_crew",
              update_column_value: value
            });
        }
      },

      witness_id: {
        get() {
          var claim = this.$store.getters['missionStore/aerialClaimById'](this.claim_id );
          return (claim !== undefined) ? claim.witness_id : 0;
        },
        set(value) {
          this.$store.commit('missionStore/updateClaimValue',
            {
              array_name: "aerial_claims",
              id_column_name: "claim_id",
              id_column_value: this.claim_id,
              update_column_name: "witness_id",
              update_column_value: value
            });
        }
      },

      ...mapGetters("missionStore", [
        "assetByFaction",
        "activeMembers"
      ])
    },
    methods: {

      deleteClaim: function () {

        this.$store.commit('missionStore/deleteAerialClaim', {id: this.claim_id});
      }
    }
  }
</script>

<style scoped>

td{
  padding: 2px 5px;
}

</style>
