<template>
  <div>
    <div style="float: right">
      <button v-on:click="deleteClaim">X</button>
    </div>
    <table>
      <tr>
        <td>Time:</td>
        <td>Place:</td>
        <td>Aircraft:</td>
      </tr>
      <tr>
        <td><input v-model="claim_time"></td>
        <td><input v-model="place"></td>
        <td>
          <select v-model="claim_aircraft">
            <option
              v-for="aircraft in assetByFactionClaimable(-3, 1)"
              v-bind:value="aircraft.id"
            >
              {{ aircraft.name }}
            </option>
          </select>
        </td>
      </tr>
      <tr>
        <td>Group claim:</td>
        <td>Witness:</td>
        <td></td>
      </tr>
      <tr>
        <td><input type="checkbox" id="group_claim" v-model="group_claim" true-value="1" false-value="0"></td>
        <td>
          <vSelect
            v-model="witness_id"
            v-bind:options="activeMembers"
            label="callsign"
            :reduce="callsign => callsign.member_id"
          ></vSelect>
        </td>
        <td></td>
      </tr>
      <tr>
        <td colspan="3">
          <textarea v-model="claim_description" class="textarea-style"></textarea>
        </td>
      </tr>
    </table>
    <br>
  </div>
</template>

<script>
  import stringConv from "../../resource/stringConverter"
  import statConv from "../../resource/statusConverter"
  import vSelect from 'vue-select'
  import 'vue-select/dist/vue-select.css';
  import { mapGetters } from "vuex"

  export default {
    name: "ClaimVVS",
    mixins: [
      statConv,
      stringConv
    ],
    components: {
      vSelect
    },
    props: {
      claim_id: {
        type: Number,
        default: null
      },
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

      group_claim: {
        get() {
          var claim = this.$store.getters['missionStore/aerialClaimById'](this.claim_id );
          return (claim !== undefined) ? claim.group_claim : 0;
        },
        set(value) {
          this.$store.commit('missionStore/updateClaimValue',
            {
              array_name: "aerial_claims",
              id_column_name: "claim_id",
              id_column_value: this.claim_id,
              update_column_name: "group_claim",
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

      claim_description: {
        get() {
          let claim = this.$store.getters['missionStore/aerialClaimById'](this.claim_id );
          return (claim !== undefined) ? claim.description : null;
        },
        set(value) {
          this.$store.commit('missionStore/updateClaimValue',
            {
              array_name: "aerial_claims",
              id_column_name: "claim_id",
              id_column_value: this.claim_id,
              update_column_name: "description",
              update_column_value: value
            });
        }
      },

      ...mapGetters("missionStore", [
        "assetByFactionClaimable",
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

