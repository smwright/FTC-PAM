<template>
  <div class="CampaignInfoMissions">
    <div v-if="campaign" class="container">
      <p class="text-align-justify">
        The list below shows all missions of {{ campaign.name }}. Each entry shows the real life date of the mission, it’s
        name, and the historical date. It also shows the mission status: briefing, debriefing and closed.
      </p>
      <ul>
        <li><b>Briefing:</b> Briefings can only be seen by the associated faction. AARs can not be created or edited.</li>
        <li><b>Debriefing:</b> Briefings can only be seen by the associated faction. AARs can be created or edited.</li>
        <li><b>Closed:</b> After debriefing period has ended (usually one week after the mission has ended). Breifings can
          be seen by all factions. AARs can not be created or edited.</li>
      </ul>
      <p class="text-align-justify">
        Click on any mission to gain access to the briefings (with the limitations mentioned above) and to the AAR's of
        this mission. Members have to select a mission to gain access to after action report submission and edit
        functionality.
      </p>
    </div>
    <DivLinkButton
      v-if="campaign[0] !== undefined"
      v-for="(mission) in campaign_missions"
      v-bind:key="mission.id"
      v-bind="{routeName: 'MissionSynop', routeParams: {mission_id: mission.id, depl_unit_id: campaign[0].root_unit_id}}"
    >
      <MissionHeader v-bind="mission"></MissionHeader>
    </DivLinkButton>
  </div>
</template>

<script>
import MissionHeader from "./MissionHeader";
import DivLinkButton from "../basic_comp/DivLinkButton";
import { mapState } from "vuex"

export default {
  name: 'Mission',
  components: {
    MissionHeader,
    DivLinkButton
  },
  mounted () {

    this.$store.dispatch('missionStore/loadStoreData',
      {
        caller: this.$options.name,
        call_object: {
          view: "campaign_mission_info",
          campaign_id: this.campaign_id
        },
        data_array_name: "missions"
      }
    ).catch(error => {
      console.log(error.message);
    });
  },
  data () {
    return {
      campaign_id: this.$route.params.campaign_id,
    }
  },
  computed: {

    ...mapState("missionStore", {
      campaign_missions: state => state.missions,
      campaign: state => state.campaign
    })
  }
}


</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style>

</style>
