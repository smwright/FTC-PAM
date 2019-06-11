<template>
  <div>
    <hr>
    <table>
      <tr>
        <td>Time:</td>
        <td>Place:</td>
        <td>Aircraft:</td>
        <td>
          <ClaimApprovalComp
            v-bind="{claim_id: this.claim_id, claim_type:'aerial'}"
          ></ClaimApprovalComp>
        </td>

      </tr>
      <tr>
        <td>{{ claim_time }}</td>
        <td>{{ place }}</td>
        <td>{{ assetById(asset_id).name }}</td>
        <td></td>
      </tr>
      <tr>
        <td>Group claim:</td>
        <td>Witness:</td>
        <td>Confirmed:</td>
        <td></td>
      </tr>
      <tr>
        <td v-if="group_claim">X</td>
        <td v-else></td>
        <td v-if="witness_id !== null">{{ memberById(witness_id).callsign }}</td>
        <td v-else></td>
        <td>
          <ClaimConfirmationComp
            v-bind="{claim_id: this.claim_id, claim_detail_id: this.claim_detail_id}"
          ></ClaimConfirmationComp>
        </td>
      </tr>

    </table>
    <br>
  </div>
</template>

<script>
  import stringConv from "../../resource/stringConverter"
  import statConv from "../../resource/statusConverter"
  import ClaimApprovalComp from "./ClaimApprovalComp"
  import ClaimConfirmationComp from "./ClaimConfirmationComp"
  import { mapGetters } from "vuex"

  export default {
    name: "ClaimVVS",
    mixins: [
      statConv,
      stringConv
    ],
    components: {
      ClaimApprovalComp,
      ClaimConfirmationComp
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
      asset_id: {
        type: Number,
        default: null
      },
      claim_time: {
        type: [String, Number],
        default: null
      },
      place: {
        type: String,
        default: null
      },
      group_claim: {
        type: [String, Number],
        default: 0
      },
      witness_id: {
        type: Number,
        default: 0
      },
      confirmed: {
        type: Number,
        default: 0
      },
      accepted: {
        type: Number,
        default: 0
      }
    },
    computed: {
      ...mapGetters("missionStore", [
        "assetById",
        "memberById"
      ])
    }
  }
</script>

<style scoped>

</style>

