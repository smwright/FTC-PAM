<template>
  <span>
    <template v-if="isAdmin">
      <button
        v-if="claimAcceptStatus === -1"
        v-on:click="acceptRejectClaim(0)"
      >Revoke claim rejection</button>
      <button
        v-if="claimAcceptStatus === 0"
        v-on:click="acceptRejectClaim(-1)"
      >Reject claim</button>
      <button
        v-if="claimAcceptStatus === 0"
        v-on:click="acceptRejectClaim(1)"
      >Accept claim</button>
      <button
        v-if="claimAcceptStatus === 1"
        v-on:click="acceptRejectClaim(0)"
      >Revoke claim acceptance</button>
    </template>
    <template v-else>
      <template v-if="claimAcceptStatus == 1">Approved</template>
      <template v-else-if="claimAcceptStatus == -1">Rejected</template>
      <template v-else></template>
    </template>
  </span>
</template>

<script>

import { mapGetters } from "vuex"

export default {
  name: "ClaimApprovalComp",
  props: {
    claim_id: {
      type: Number,
      default: null
    },
    claim_type: {
      type: String,
      default: 'aerial'
    }
  },
  mounted ()  {

    this.checkAdmin();
  },
  data () {
    return {

      isAdmin: false
    }
  },
  computed: {

    claimAcceptStatus: function () {

      if(this.claim_type === 'aerial'){

        return this.aerialClaimById(this.claim_id).accepted
      } else if(this.claim_type === 'ground'){

        return this.groundClaimById(this.claim_id).accepted
      }
    },

    ...mapGetters("missionStore", [
      "aerialClaimById",
      "groundClaimById"
    ])
  },
  methods: {

    checkAdmin: async function () {

      this.isAdmin = await this.$auth.isAdmin(this.$options.name);
    },

    acceptRejectClaim: async function (accept) {

      if(this.claim_type === 'aerial'){

        var claim_table = "aerial_claims"
      } else if(this.claim_type === 'ground'){

        var claim_table = "ground_claims"
      }

      this.$store.dispatch('missionStore/acceptRejectClaim',
        {
          caller: this.$options.name,
          id: this.claim_id,
          accepted: accept,
          member_id: await this.$auth.getUserId(),
          claim_table: claim_table
        });
    }
  }
}
</script>

<style scoped>

</style>
