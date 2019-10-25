<template>
  <div>
    <table>
      <tr>
        <td>{{ asset_name }}</td>
        <td>{{ claimRAFenemyStatus[enemy_status] }}</td>
        <td v-if="shared">Shared</td>
        <td v-else></td>
        <td>
          <ClaimApprovalComp
            v-bind="{claim_id: this.claim_id, claim_type:'aerial'}"
          ></ClaimApprovalComp>
        </td>
      </tr>
      <tr>
        <td colspan="4">{{ decodeHTML(description) }}</td>
      </tr>
    </table>
  </div>
</template>

<script>
import stringConv from "../../resource/stringConverter"
import statConv from "../../resource/statusConverter"
import ClaimApprovalComp from "./ClaimApprovalComp"

export default {
  name: "ClaimRAF",
  mixins: [
    statConv,
    stringConv
  ],
  components: {
    ClaimApprovalComp
  },
  props: {
    claim_id: {
      type: Number,
      default: null
    },
    claim_detail_id: {
      type: Number,
      default: null
    },
    asset_name: {
      type: String,
      default: null
    },
    enemy_status: {
      type: Number,
      default: null
    },
    shared: {
      type: [String, Number],
      default: 0
    },
    accepted: {
      type: Number,
      default: 0
    },
    description: {
      type: String,
      default: null
    }
  }

}
</script>

<style scoped>

</style>
