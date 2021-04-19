<template>
  <div class="CampaignInfoMissions">
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
