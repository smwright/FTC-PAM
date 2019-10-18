<template>
    <div>
      <h1>Sorties overview:</h1>
      <table>
        <tr>
          <td>Sorties:</td>
          <td>{{ sortiePilotAssetStats(null).sorties }}</td>
        </tr>
      </table>
      <div class="clearfix">
        <div class="inline-table float-left">
          <table>
            <tr><td>Pilot status</td></tr>
            <tr><td colspan="2"><hr></td></tr>
            <tr v-if="sortiePilotAssetStats(null).pilot_ok > 0">
              <td>OK:</td>
              <td>{{ sortiePilotAssetStats(null).pilot_ok }}</td>
            </tr>
            <tr v-if="sortiePilotAssetStats(null).pilot_wounded > 0">
              <td>Wounded:</td>
              <td>{{ sortiePilotAssetStats(null).pilot_wounded }}</td>
            </tr>
            <tr v-if="sortiePilotAssetStats(null).pilot_pow > 0">
              <td>POW:</td>
              <td>{{ sortiePilotAssetStats(null).pilot_pow }}</td>
            </tr>
            <tr v-if="sortiePilotAssetStats(null).pilot_kia > 0">
              <td>KIA:</td>
              <td>{{ sortiePilotAssetStats(null).pilot_kia }}</td>
            </tr>
          </table>
        </div>
        <div class="inline-table float-left">
          <table>
            <tr><td>Aircraft status</td></tr>
            <tr><td colspan="2"><hr></td></tr>
            <tr v-if="sortiePilotAssetStats(null).asset_ok > 0">
              <td>OK:</td>
              <td>{{ sortiePilotAssetStats(null).asset_ok }}</td>
            </tr>
            <tr v-if="sortiePilotAssetStats(null).asset_damaged > 0">
              <td>Damaged:</td>
              <td>{{ sortiePilotAssetStats(null).asset_damaged }}</td>
            </tr>
            <tr v-if="sortiePilotAssetStats(null).asset_lost > 0">
              <td>Lost:</td>
              <td>{{ sortiePilotAssetStats(null).asset_lost }}</td>
            </tr>
          </table>
        </div>
      </div>
    </div>
</template>

<script>
import { mapGetters } from "vuex"

export default {
  name: "SortiePilotAssetStatsComp",
  computed: {

    ...mapGetters("memberInfo", [
      "sortiePilotAssetStats",
    ])

  },
}
</script>

<style scoped>

</style>
