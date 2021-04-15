<template>
  <div class="inline-block">
    <template v-if="compact_style">
      <span v-if="claimStats(character_id, report_id, 'raf') !== undefined">
        <template v-for="(amount, object) in claimStats(character_id, report_id, 'raf')">
          <template v-if="amount > 0">
            <template v-if="object === 'Destroyed'">
              Dest: {{ amount }}
            </template>
            <template v-if="object === 'Probable'">
              Prb: {{ amount }}
            </template>
            <template v-if="object === 'Damaged'">
              Dmg: {{ amount }}
            </template>
          </template>
        </template>
      </span>
      <span v-if="claimStats(character_id, report_id, 'lw') !== undefined">
        <template v-for="(amount, object) in claimStats(character_id, report_id, 'lw')">
          <template v-if="amount > 0">
            <template v-if="object === 'Confirmed'">
              Con: {{ amount }}
            </template>
            <template v-if="object === 'Unconfirmed'">
              Ucon: {{ amount }}
            </template>
          </template>
        </template>
      </span>
      <span v-if="claimStats(character_id, report_id, 'vvs_pers') !== undefined">
        <template v-for="(amount, object) in claimStats(character_id, report_id, 'vvs_pers')">
          <template v-if="amount > 0">
            <template v-if="object === 'Confirmed'">
              Con: {{ amount }}
            </template>
            <template v-if="object === 'Unconfirmed'">
              Ucon: {{ amount }}
            </template>
          </template>
        </template>
      </span>
      <span v-if="claimStats(character_id, report_id, 'vvs_group') !== undefined">
        <template v-for="(amount, object) in claimStats(character_id, report_id, 'vvs_group')">
          <template v-if="amount > 0">
            <template v-if="object === 'Confirmed'">
              G/Con: {{ amount }}
            </template>
            <template v-if="object === 'Unconfirmed'">
              G/Ucon: {{ amount }}
            </template>
          </template>
        </template>
      </span>
      <span v-if="claimStats(character_id, report_id, 'ra') !== undefined">
        <template v-for="(amount, object) in claimStats(character_id, report_id, 'ra')">
          <template v-if="amount > 0">
            <template v-if="object === 'Destroyed'">
              Dest: {{ amount }}
            </template>
            <template v-if="object === 'Probable'">
              Prb: {{ amount }}
            </template>
            <template v-if="object === 'Damaged'">
              Dmg: {{ amount }}
            </template>
          </template>
        </template>
      </span>
      <span v-if="claimStats(character_id, report_id, 'ground_total') !== undefined">
        <template v-for="(amount, object) in claimStats(character_id, report_id, 'ground_total')">
          <template v-if="amount > 0">
            Gnd-V.: {{ amount }}
          </template>
        </template>
      </span>

    </template>
    <template v-else>
      <div class="clearfix">
        <h1>Victories overview:</h1>
        <div class="inline-table float-left" v-if="claimStats(character_id, report_id, 'raf') !== undefined">
          <table>
            <tr><td>RAF victories:</td></tr>
            <tr><td colspan="2"><hr></td></tr>
            <template v-for="(amount, object) in claimStats(character_id, report_id, 'raf')">
              <tr v-if="amount > 0">
                <td>{{ object }}:</td>
                <td>{{ amount }}</td>
              </tr>
            </template>
          </table>
        </div>

        <div class="inline-table float-left" v-if="claimStats(character_id, report_id, 'lw') !== undefined">
          <table>
            <tr><td>LW victories:</td></tr>
            <tr><td colspan="2"><hr></td></tr>
            <template v-for="(amount, object) in claimStats(character_id, report_id, 'lw')">
              <tr v-if="amount > 0">
                <td>{{ object }}:</td>
                <td>{{ amount }}</td>
              </tr>
            </template>
          </table>
        </div>

        <div class="inline-table float-left"
             v-if="claimStats(character_id, report_id, 'vvs_pers') !== undefined || claimStats(character_id, report_id, 'vvs_group') !== undefined">
          <table>
            <tr><td>VVS victories:</td></tr>
            <tr><td colspan="2"><hr></td></tr>
            <template v-if="claimStats(character_id, report_id, 'vvs_pers') !== undefined">
              <tr><td colspan="2">Personal:</td></tr>
              <template v-for="(amount, object) in claimStats(character_id, report_id, 'vvs_pers')">
                <tr v-if="amount > 0">
                  <td>&nbsp{{ object }}:</td>
                  <td>{{ amount }}</td>
                </tr>
              </template>
            </template>
            <template v-if="claimStats(character_id, report_id, 'vvs_group') !== undefined">
              <tr><td colspan="2">Group:</td></tr>
              <template v-for="(amount, object) in claimStats(character_id, report_id, 'vvs_group')">
                <tr v-if="amount > 0">
                  <td>&nbsp{{ object }}:</td>
                  <td>{{ amount }}</td>
                </tr>
              </template>
            </template>
          </table>
        </div>

        <div class="inline-table float-left" v-if="claimStats(character_id, report_id, 'ra') !== undefined">
          <table>
            <tr><td>RA victories:</td></tr>
            <tr><td colspan="2"><hr></td></tr>
            <template v-for="(amount, object) in claimStats(character_id, report_id, 'ra')">
              <tr v-if="amount > 0">
                <td>{{ object }}:</td>
                <td>{{ amount }}</td>
              </tr>
            </template>
          </table>
        </div>

        <div class="inline-table float-left" v-if="claimStats(character_id, report_id, 'ground') !== undefined">
          <table>
            <tr><td>Ground victories:</td></tr>
            <tr><td colspan="2"><hr></td></tr>
            <tr v-for="(amount, object) in claimStats(character_id, report_id, 'ground')">
              <td>{{ object }}:</td>
              <td>{{ amount }}</td>
            </tr>
          </table>
        </div>
      </div>
    </template>
  </div>
</template>

<script>
import { mapGetters } from "vuex"

export default {
  name: "ClaimStatsComp",
  props: {
    character_id: {
      type: [Number, String],
      default: null
    },
    report_id: {
      type: [Number, String],
      default: null
    },
    compact_style: {
      type: Boolean,
      default: false
    }
  },
  computed: {

    ...mapGetters("memberInfo", [
      "claimStats",
    ])
  }
}
</script>

<style scoped>

</style>
