<template>
  <div>
    <hr>
    <table>
      <tr class="header-row">
        <td>Time:</td>
        <td>Place:</td>
        <td>Aircraft:</td>
        <td>Markings:</td>
        <td></td>
      </tr>
      <tr>
        <td>{{ claim_time }}</td>
        <td>{{ place }}</td>
        <td>{{ assetById(asset_id).name }}</td>
        <td>{{ opponent }}</td>
        <td>
          <ClaimApprovalComp
            v-bind="{claim_id: this.claim_id, claim_type:'aerial'}"
          ></ClaimApprovalComp>
        </td>
      </tr>
      <tr class="header-row">
        <td>Type of destruction:</td>
        <td>Type of impact on the ground:</td>
        <td>Fate of crew:</td>
        <td>Witness:</td>
        <td>Confirmed:</td>
      </tr>
      <tr>
        <td>{{ claimLWTypeOfDestruction[type_of_destruction] }}</td>
        <td>{{ claimLWTypeOfImpact[type_of_impact] }}</td>
        <td>{{ claimLWFateOfCrew[fate_of_crew] }}</td>
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
  name: "ClaimLW",
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
    claim_time: {
      type: [Number, String],
      default: null
    },
    asset_id: {
      type: Number,
      default: null
    },
    place: {
      type: String,
      default: null
    },
    opponent: {
      type: [Number, String],
      default: null
    },
    type_of_destruction: {
      type: Number,
      default: null
    },
    type_of_impact: {
      type: Number,
      default: 0
    },
    fate_of_crew: {
      type: Number,
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

td{
  padding: 2px 5px;
}

.header-row td{
  font-weight: bold;
}

</style>
