<template>
  <div>
    <hr>
    <table>
      <tr>
        <td>{{ asset_name }}</td>
        <td>{{ amount }}</td>
        <td v-if="accepted == 1">Approved</td>
        <td v-else-if="accepted == -1">Rejected</td>
        <td v-else></td>
      </tr>
      <tr>
        <td colspan="3">{{ decodeHTML(description) }}</td>
      </tr>
    </table>
  </div>
</template>

<script>
import stringConv from "../../resource/stringConverter"

export default {
  name: "ClaimGround",
  mixins: [
    stringConv
  ],
  props: {
    description: {
      type: String,
      default: null
    },
    asset_name: {
      type: String,
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
  }
}
</script>

<style scoped>

</style>
