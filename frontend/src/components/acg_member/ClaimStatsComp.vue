<template>
  <div>
    <h1>Victories overview:</h1>
    <div class="clearfix">

      <div class="inline-table float-left" v-if="claimStats(null, 'raf') !== undefined">
        <table>
          <tr><td>RAF victories:</td></tr>
          <tr><td colspan="2"><hr></td></tr>
          <tr v-if="claimStats(null, 'raf').destroyed > 0">
            <td>Destroyed:</td>
            <td>{{ claimStats(null, 'raf').destroyed }}</td>
          </tr>
          <tr v-if="claimStats(null, 'raf').probables > 0">
            <td>Probable:</td>
            <td>{{ claimStats(null, 'raf').probables }}</td>
          </tr>
          <tr v-if="claimStats(null, 'raf').damaged > 0">
            <td>Damaged:</td>
            <td>{{ claimStats(null, 'raf').damaged }}</td>
          </tr>
        </table>
      </div>

      <div class="inline-table float-left" v-if="claimStats(null, 'lw') !== undefined">
        <table>
          <tr><td>LW victories:</td></tr>
          <tr><td colspan="2"><hr></td></tr>
          <tr v-if="claimStats(null, 'lw').conf > 0">
            <td>Confirmed:</td>
            <td>{{ claimStats(null, 'lw').conf }}</td>
          </tr>
          <tr v-if="claimStats(null, 'lw').unconf > 0">
            <td>Unconfirmed:</td>
            <td>{{ claimStats(null, 'lw').unconf }}</td>
          </tr>
        </table>
      </div>

      <div class="inline-table float-left"
           v-if="claimStats(null, 'vvs_pers') !== undefined || claimStats(null, 'vvs_group') !== undefined">
        <table>
          <tr><td>VVS victories:</td></tr>
          <tr><td colspan="2"><hr></td></tr>
          <template v-if="claimStats(null, 'vvs_pers') !== undefined">
            <tr><td colspan="2">Personal:</td></tr>
            <tr v-if="claimStats(null, 'vvs_pers').conf > 0">
              <td>&nbsp Confirmed:</td>
              <td>{{ claimStats(null, 'vvs_pers').conf }}</td>
            </tr>
            <tr v-if="claimStats(null, 'vvs_pers').unconf > 0">
              <td>&nbsp Unconfirmed:</td>
              <td>{{ claimStats(null, 'vvs_pers').unconf }}</td>
            </tr>
          </template>
          <template v-if="claimStats(null, 'vvs_group') !== undefined">
            <tr><td colspan="2">Group:</td></tr>
            <tr v-if="claimStats(null, 'vvs_group').conf > 0">
              <td>&nbsp Confirmed:</td>
              <td>{{ claimStats(null, 'vvs_group').conf }}</td>
            </tr>
            <tr v-if="claimStats(null, 'vvs_group').unconf > 0">
              <td>&nbsp Unconfirmed:</td>
              <td>{{ claimStats(null, 'vvs_group').unconf }}</td>
            </tr>
          </template>
        </table>
     </div>

      <div class="inline-table float-left" v-if="claimStats(null, 'ground') !== undefined">
        <table>
          <tr><td>Ground victories:</td></tr>
          <tr><td colspan="2"><hr></td></tr>
          <tr v-for="(amount, object) in claimStats(null, 'ground')">
            <td>{{ object }}:</td>
            <td>{{ amount }}</td>
          </tr>
        </table>
      </div>
    </div>

  </div>
</template>

<script>
import { mapGetters } from "vuex"

export default {
  name: "ClaimStatsComp",
  computed: {

    ...mapGetters("memberInfo", [
      "claimStats",
    ])
  }
}
</script>

<style scoped>

</style>
