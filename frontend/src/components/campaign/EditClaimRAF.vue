<template>
  <div>
    <div style="float: right">
      <button v-on:click="deleteClaim">X</button>
    </div>
    <table>
      <tr>
        <td class="width-20">
          <select v-model="claim_aircraft">
            <option
              v-for="aircraft in assetByFaction(-2)"
              v-bind:value="aircraft.id"
            >
              {{ aircraft.name }}
            </option>
          </select>
        </td>
        <td class="width-20">
          <select v-model="enemy_status">
            <option
              v-for="(status, index) in claimRAFenemyStatus"
              v-bind:value="index"
            >
              {{ status }}
            </option>
          </select>
        </td>
        <td class="width-10">
          <span>shared:</span>
          <input type="checkbox" id="shared" v-model="shared" true-value=1 false-value=0>
        </td>
        <td></td>
      </tr>
      <tr>
        <td colspan="4">
          <textarea v-model="claim_description" class="textarea-style"></textarea>
        </td>
      </tr>
    </table>
  </div>

</template>

<script>
import stringConv from "../../resource/stringConverter"
import statConv from "../../resource/statusConverter"
import vSelect from 'vue-select'
import 'vue-select/dist/vue-select.css'
import { mapGetters } from "vuex"

  export default {
  name: "EditClaimRAF",
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

    enemy_status: {
      get() {
        var claim = this.$store.getters['missionStore/aerialClaimById'](this.claim_id );
        return (claim !== undefined) ? claim.enemy_status : 0;
      },
      set(value) {
        this.$store.commit('missionStore/updateClaimValue',
          {
            array_name: "aerial_claims",
            id_column_name: "claim_id",
            id_column_value: this.claim_id,
            update_column_name: "enemy_status",
            update_column_value: value
          });
      }
    },

    shared: {
      get() {
        var claim = this.$store.getters['missionStore/aerialClaimById'](this.claim_id );
        return (claim !== undefined) ? claim.shared : 0;
      },
      set(value) {
        this.$store.commit('missionStore/updateClaimValue',
          {
            array_name: "aerial_claims",
            id_column_name: "claim_id",
            id_column_value: this.claim_id,
            update_column_name: "shared",
            update_column_value: value
          });
      }
    },

    claim_description: {
      get() {
        var claim = this.$store.getters['missionStore/aerialClaimById'](this.claim_id );
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
      "assetByFaction"
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

.textarea-style{
  width: 98%;
  height: 5em;
}

</style>
