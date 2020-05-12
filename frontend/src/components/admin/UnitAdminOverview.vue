<template>
  <div class="container">
    <h2>Unit overview</h2>

    <table>
      <tr>
        <th></th>
        <th>Active:</th>
        <th>On leave:</th>
      </tr>

      <tr>
        <td class="heading">ACG</td>
        <td>{{ activeTotal() }}</td>
        <td>{{ onLeaveTotal() }}</td>
      </tr>

      <tr>
        <td colspan="3">
          <hr>
        </td>
      </tr>

      <tr
        v-for="unit in acg_units"
        v-bind:key="unit.id"
      >
        <td class="heading">{{ unit.name }}</td>
        <td>{{ activeMembers(unit.id) }}</td>
        <td>{{ onLeaveMembers(unit.id) }}</td>
      </tr>
    </table>

  </div>
</template>

<script>
import { mapState, mapGetters } from "vuex"

export default {
  name: "UnitAdminOverview",
  mounted () {

  },
  computed: {

    // ...mapState('memberAdmin', {
    //
    // }),

    ...mapState('memberAdmin', {
      acg_units: state => state.acg_units
    }),

    ...mapGetters("memberAdmin", [
      "membersByUnitId",
    ])

  },
  methods: {

    activeMembers: function (unit_id) {

      let searchString = "";
      let showActive = true;
      let showOnLeave = false;
      let showDismissed = false;
      let showPassedAway = true;
       return this.membersByUnitId(unit_id,showActive,showOnLeave,showDismissed,showPassedAway,searchString).length;
    },

    onLeaveMembers: function (unit_id) {

      let searchString = "";
      let showActive = false;
      let showOnLeave = true;
      let showDismissed = false;
      let showPassedAway = false;
      return this.membersByUnitId(unit_id,showActive,showOnLeave,showDismissed,showPassedAway,searchString).length;
    },

    activeTotal: function () {

      let units = this.acg_units;
      let count = 0;
      for(let i=0; i<units.length; i++){
        count += this.activeMembers(units[i].id);
      }
      return count;
    },

    onLeaveTotal: function () {

      let units = this.acg_units;
      let count = 0;
      for(let i=0; i<units.length; i++){
        count += this.onLeaveMembers(units[i].id);
      }
      return count;
    }
  }
}
</script>

<style scoped>

</style>
