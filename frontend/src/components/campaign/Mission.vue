<template>
  <div class="CampaignInfoMissions">
    <p>Here you find a list of all missions of the campaign {{campaign_id}}.</p>
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

export default {
  name: 'Mission',
  components: {
    MissionHeader,
    DivLinkButton
  },
  mounted () {

    this.requestViewData(this.$options.name, {view:"campaign_mission_info", campaign_id:this.$route.params.campaign_id})
      .then(response => {
        this.campaign_missions = this.nestData(response);
      })
      .catch(error => {
        console.log(error.message);
      });
  },
  data () {
    return {
      campaign_missions: null,
      campaign_id: this.$route.params.campaign_id,
    }
  },
}


</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style>

</style>
