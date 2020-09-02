<template>
  <div v-if="fatelist.length > 0">
    <div class="heading">Pilot status:</div>

    <p>
      This list gives an overview over the fate of all pilots of {{ this.unit.hist_unit_name }} that took part in this
      mission.
    </p>

    <PilotFateDescription></PilotFateDescription>

    <div class="container-transparent">
      <table>
        <tr>
          <th>Member:</th>
          <th>Flew as:</th>
          <th>Flight Number:</th>
          <th>Status:</th>
          <th>Map:</th>
        </tr>
        <TRLinkButton
          v-for="fate in fatelist"
          v-bind:key="fate.username+'_'+fate.MissionStartTime+'_'+fate.FlightNumber"
          class="typed-on-paper-link"
          v-bind="{routeName: 'FateMap',
          routeParams: {
            member_id: fate.member_id,
            flight_number: fate.FlightNumber
          }
        }"
        >
          <td>{{ fate.username }}</td>
          <td>{{ fate.servername }}</td>
          <td>{{ fate.FlightNumber }}</td>
          <td>{{ fate.ch_status }}</td>
          <td>
            <template v-if="fate.path_points != null && fate.last_point != null">
              Map available
            </template>
          </td>
        </TRLinkButton>
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
import LinkButton from "../basic_comp/LinkButton"
import PilotFateDescription from "./PilotFateDescription"
import TRLinkButton from "../basic_comp/TRLinkButton"

export default {
  name: "SynopPilotFate",
  components: {
    HideableDiv,
    LinkButton,
    PilotFateDescription,
    TRLinkButton
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

    has_map_data: function () {

      return this.fate_data.length > 0 && this.fate_data[0].path_points != null
        && this.fate_data[0].last_point != null;
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
