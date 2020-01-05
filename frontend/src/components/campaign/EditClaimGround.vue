<template>
  <div>
    <table>
      <tr>
        <td class="width-20">
          <select v-model="claim_asset">
            <option
              v-for="target in groundTargets"
              v-bind:value="target.id"
            >
              {{ target.name }}
            </option>
          </select>
        </td>
        <td class="width-10">
          <button v-bind:disabled="claim_amount === 1" v-on:click="claim_amount--"> < </button>
          {{ claim_amount }}
          <button v-on:click="claim_amount++"> > </button>
        </td>
        <td><button style="float: right;" v-on:click="deleteClaim">X</button></td>
      </tr>
      <tr>
        <td class="width-90">
          <textarea v-model="claim_description" class="textarea-style"></textarea>
        </td>
      </tr>
    </table>
  </div>
</template>

<script>
  import stringConv from "../../resource/stringConverter"
  import { mapGetters } from "vuex"

  export default {
    name: "EditClaimGround",
    mixins: [
      stringConv
    ],
    props: {
      claim_id: {
        type: Number,
        default: null,
      }
    },
    computed: {

      claim_asset: {
        get() {
          var claim = this.$store.getters['missionStore/groundClaimById'](this.claim_id );
          return (claim !== undefined) ? claim.asset_id : null;
        },
        set(value) {
          this.$store.commit('missionStore/updateClaimValue',
            {
              array_name: "ground_claims",
              id_column_name: "claim_id",
              id_column_value: this.claim_id,
              update_column_name: "asset_id",
              update_column_value: value
            });
        }
      },

      claim_amount: {
        get() {
          var claim = this.$store.getters['missionStore/groundClaimById'](this.claim_id);
          return (claim !== undefined) ? claim.amount : null;
        },
        set(value) {
          this.$store.commit('missionStore/updateClaimValue',
            {
              array_name: "ground_claims",
              id_column_name: "claim_id",
              id_column_value: this.claim_id,
              update_column_name: "amount",
              update_column_value: value
            });
        }
      },

      claim_description: {
        get() {
          var claim = this.$store.getters['missionStore/groundClaimById'](this.claim_id );
          return (claim !== undefined) ? claim.description : null;
        },
        set(value) {
          this.$store.commit('missionStore/updateClaimValue',
            {
              array_name: "ground_claims",
              id_column_name: "claim_id",
              id_column_value: this.claim_id,
              update_column_name: "description",
              update_column_value: value
            });
        }
      },

      ...mapGetters("missionStore", [
        "assetById",
        "groundTargets"
      ])
    },

    methods: {

      deleteClaim: function () {

        this.$store.commit('missionStore/deleteGroundClaim', {id: this.claim_id});
      }
    }
  }
</script>

<style scoped>

td{
  padding: 2px 5px;
}

.textarea-style{
  width: 98%;
  height: 5em;
}

</style>
