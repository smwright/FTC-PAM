<template>
  <div>
    <table>
      <tr>
        <td>{{ asset_name }}</td>
        <td>{{ claimRAFenemyStatus[enemy_status] }}</td>
        <td v-if="shared">Shared</td>
        <td v-else></td>
        <td v-if="accepted == 1">Approved</td>
        <td v-else-if="accepted == -1">Rejected</td>
        <td v-else></td>
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

export default {
  name: "ClaimRAF",
  mixins: [
    statConv,
    stringConv
  ],
  props: {
    asset_name: {
      type: String,
      default: null
    },
    enemy_status: {
      type: Number,
      default: null
    },
    shared: {
      type: Number,
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
td {
  width: 150px;
  border: blue 1px solid;
}
</style>
