<template>
  <div>
    <hr>
    <table>
      <tr>
        <td>Time:</td>
        <td>Place:</td>
        <td>Aircraft:</td>
        <td>Markings:</td>
        <td></td>
      </tr>
      <tr>
        <td>{{ claim_time }}</td>
        <td>{{ place }}</td>
        <td>{{ asset_name }}</td>
        <td>{{ opponent }}</td>
        <td v-if="accepted == 1">Approved</td>
        <td v-else-if="accepted == -1">Rejected</td>
        <td v-else></td>
      </tr>
      <tr>
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
        <td>{{ witness_callsign }}</td>
        <td v-if="confirmed">Confirmed</td>
        <td v-else></td>
      </tr>

    </table>
    <br>
  </div>
</template>

<script>
import stringConv from "../../resource/stringConverter"
import statConv from "../../resource/statusConverter"

export default {
  name: "ClaimLW",
  mixins: [
    statConv,
    stringConv
  ],
  props: {
    asset_name: {
      type: String,
      default: null
    },
    claim_time: {
      type: String,
      default: null
    },
    place: {
      type: String,
      default: null
    },
    opponent: {
      type: String,
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
    witness_callsign: {
      type: String,
      default: null
    },
    confirmed: {
      type: Number,
      default: 0
    },
    accepted: {
      type: Number,
      default: 0
    }
  }
}
</script>

<style scoped>

</style>
