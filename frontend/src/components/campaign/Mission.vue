<template>
  <div class="CampaignInfoMissions">
    <DivLinkButton
      v-for="(mission) in campaign_missions"
      v-bind:key="mission.id"
      v-bind="{routeName: 'MissionInfo', routeParams: {mission_id: mission.id}}"
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

    this.$store.commit('missionStore/clearMissions');
    this.$store.dispatch('missionStore/loadMissions', {caller: this.$options.name, campaign_id: this.campaign_id})
      .catch(error => {
        console.log(error.message);
      });

  },
  data () {
    return {
      // campaign_missions: null,
      campaign_id: this.$route.params.campaign_id,
    }
  },
  computed: {

    ...mapState("missionStore", {
      campaign_missions: state => state.missions
    })
  }
}


</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style>

</style>
