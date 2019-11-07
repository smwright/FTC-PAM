<template>
    <div>
      <h1>Sorties overview:</h1>
      <table>
        <tr>
          <td>Sorties:</td>
          <td>{{ sortiePilotAssetStats(character_id).sorties }}</td>
        </tr>
      </table>
      <div class="clearfix">
        <div class="inline-table float-left">
          <table>
            <tr><td>Pilot status</td></tr>
            <tr><td colspan="2"><hr></td></tr>
            <tr v-if="sortiePilotAssetStats(character_id).pilot_ok > 0">
              <td>OK:</td>
              <td>{{ sortiePilotAssetStats(character_id).pilot_ok }}</td>
            </tr>
            <tr v-if="sortiePilotAssetStats(character_id).pilot_wounded > 0">
              <td>Wounded:</td>
              <td>{{ sortiePilotAssetStats(character_id).pilot_wounded }}</td>
            </tr>
            <tr v-if="sortiePilotAssetStats(character_id).pilot_pow > 0">
              <td>POW:</td>
              <td>{{ sortiePilotAssetStats(character_id).pilot_pow }}</td>
            </tr>
            <tr v-if="sortiePilotAssetStats(character_id).pilot_kia > 0">
              <td>KIA:</td>
              <td>{{ sortiePilotAssetStats(character_id).pilot_kia }}</td>
            </tr>
          </table>
        </div>
        <div class="inline-table float-left">
          <table>
            <tr><td>Aircraft status</td></tr>
            <tr><td colspan="2"><hr></td></tr>
            <tr v-if="sortiePilotAssetStats(character_id).asset_ok > 0">
              <td>OK:</td>
              <td>{{ sortiePilotAssetStats(character_id).asset_ok }}</td>
            </tr>
            <tr v-if="sortiePilotAssetStats(character_id).asset_damaged > 0">
              <td>Damaged:</td>
              <td>{{ sortiePilotAssetStats(character_id).asset_damaged }}</td>
            </tr>
            <tr v-if="sortiePilotAssetStats(character_id).asset_lost > 0">
              <td>Lost:</td>
              <td>{{ sortiePilotAssetStats(character_id).asset_lost }}</td>
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
  props: {
    character_id: {
      type: [Number, String],
      default: null
    }
  },
  computed: {

    ...mapGetters("memberInfo", [
      "sortiePilotAssetStats",
    ])

  },
}
</script>

<style scoped>

</style>
