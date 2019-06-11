<template>
  <span>
    <template v-if="isWitness">
      <button
        v-if="aerialClaimById(this.claim_id).confirmed === 0"
        v-on:click="confirmClaim(1)"
      >Confirm claim</button>
      <button
        v-if="aerialClaimById(this.claim_id).confirmed === 1"
        v-on:click="confirmClaim(0)"
      >Revoke claim confirmation</button>
    </template>
    <template v-else>
      <template v-if="aerialClaimById(this.claim_id).confirmed == 1">Confirmed</template>
      <template v-else></template>
    </template>
  </span>
</template>

<script>

import { mapGetters } from "vuex"

export default {
  name: "ClaimConfirmationComp",
  props: {
    claim_id: {
      type: Number,
      default: null
    },
    claim_detail_id: {
      type: Number,
      default: null
    },
  },
  mounted () {

    this.checkWitness();
  },
  data () {
    return {

      isWitness: false
    }
  },
  computed: {

    ...mapGetters("missionStore", [
      "aerialClaimById",
      "groundClaimById"
    ])
  },
  methods: {

    checkWitness: async function () {

      this.isWitness = await this.$auth.getUserId(this.$options.name)
        === this.aerialClaimById(this.claim_id).witness_id;
    },

    confirmClaim: async function (confirm) {

      this.$store.dispatch('missionStore/confirmClaim',
        {
          caller: this.$options.name,
          id: this.claim_detail_id,
          confirmed: confirm,
        });
    }
  }
}
</script>

<style scoped>

</style>
