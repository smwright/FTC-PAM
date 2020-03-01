<template>
  <div v-if="fatelist.length > 0">
    <div class="heading">Pilot status:</div>

    <p>
      This list gives an overview over the fate of all pilots of {{ this.unit.hist_unit_name }} that took part in this
      mission.
    </p>

    <HideableDiv
      v-bind:changing-button="true"
    >
      <template slot="buttonVisible">
        <button>Hide description</button>
      </template>
      <template slot="buttonHidden">
        <button>Want to know more?...</button>
      </template>
      <p>
        A pilot that chrashlands or parachutes into enemy territory will try to walk home to friendly lines on the shortest
        distance. He will walk a distance of appr. 5 km per hour. About every 12 minutes a check is performed that determines
        if the pilot died or was captures.
      </p>
      <p>
        The probability to make it to friendly lines is appr. 50/50 for a distance of 30 km. Injury and cold weather decrease
        the chances. Capture is determined on how close the pilot is to enemy troups. The closer enemy troups, the higher
        the chances for capture. A distance of 2 km to enemy troups will resulst in a 50/50 chance. Night hours increase
        the chances for escape.
      </p>
      <!--<p>-->
        <!--VVS troops that escape enemy territory have an additional risk of being send to the Gulag being suspected a german spy.-->
      <!--</p>-->
      <p>
        Although the fate of the pilots are calculated instantaneously, the results will be displayed with a real life delay.
        A pilot still trying to escape will show "Alive and walking". For example: Should a pilot need to walk 5 hours to
        reach friendly lines, his status will show "Alive and walking" for those 5 hours. Unless he dies or is captured
        along the way.
      </p>
    </HideableDiv>

    <div class="container-transparent">
      <table>
        <tr>
          <th>Member:</th>
          <th>Flew as:</th>
          <th>Flight Number:</th>
          <th>Status:</th>
        </tr>
        <tr v-for="fate in fatelist">
          <td>{{ fate.username }}</td>
          <td>{{ fate.servername }}</td>
          <td>{{ fate.FlightNumber }}</td>
          <td>{{ fate.ch_status }}</td>
        </tr>
      </table>
    </div>

    <HideableDiv
      v-if="phantoms.length > 0"
      v-bind:changing-button="true"
    >
      <template slot="buttonVisible">
        <button>Hide phantoms</button>
      </template>
      <template slot="buttonHidden">
        <button>Show phantoms</button>
      </template>
      <p>
        Pilots that could not be identified through their username or BoX-id.
      </p>
      <div class="container-transparent">
        <table>
          <tr>
            <th>Phantom name:</th>
            <th>Flight Number:</th>
            <th>Status:</th>
          </tr>
          <tr v-for="phantom in phantoms">
            <td>{{ phantom.servername }}</td>
            <td>{{ phantom.FlightNumber }}</td>
            <td>{{ phantom.ch_status }}</td>
          </tr>
        </table>
      </div>
    </HideableDiv>

  </div>
</template>

<script>
import {mapState, mapGetters} from "vuex"
import HideableDiv from "../basic_comp/HideableDiv"

export default {
  name: "SynopPilotFate",
  components: {
    HideableDiv
  },
  computed: {

    unit: function () {

      return this.filterByKey("campaign_units", "depl_unit_id", this.$route.params.depl_unit_id)[0];
    },

    fatelist: function () {

      return this.subTreeItems("pilot_fates", this.unit.lft, this.unit.rgt, true);
    },

    phantoms: function () {

      return this.filterByKey("pilot_fates", "username", null);
    },

    ...mapGetters("missionStore", [
      "filterByKey",
      "subTreeItems"
    ])
  }
}
</script>

<style scoped>

</style>
