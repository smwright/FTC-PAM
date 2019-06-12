<template>
  <div>
    <hr>
    <table>
      <tr>
        <td>{{ assetById(asset_id).name }}</td>
        <td>{{ amount }}</td>
        <td>
          <ClaimApprovalComp
            v-bind="{claim_id: this.claim_id, claim_type:'ground'}"
          ></ClaimApprovalComp>
        </td>
      </tr>
      <tr>
        <td colspan="3">{{ decodeHTML(description) }}</td>
      </tr>
    </table>
  </div>
</template>

<script>
import stringConv from "../../resource/stringConverter"
import ClaimApprovalComp from "./ClaimApprovalComp"
import { mapGetters } from "vuex"

export default {
  name: "ClaimGround",
  mixins: [
    stringConv
  ],
  components: {
    ClaimApprovalComp
  },
  props: {
    claim_id: {
      type: Number,
      default: null,
    },
    description: {
      type: [String, Number],
      default: null
    },
    asset_id: {
      type: Number,
      default: null
    },
    amount: {
      type: Number,
      default: null
    },
    accepted: {
      type: Number,
      default: 0
    }
  },
  computed: {
    ...mapGetters("missionStore", [
      "assetById",
    ])
  }
}
</script>

<style scoped>

td{
  padding: 2px 5px;
}

</style>
