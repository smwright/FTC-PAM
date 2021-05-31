<template>
  <div>
    <div class="container">
      <p class="text-align-justify">The historical campaign is ACGs main event. Participation is mandatory and exclusive to ACG members.
        Non members interested in joining are welcome to join in and try it out though. On this page you’ll find a list of
        past-, current- and future campaigns. The list will give you the name of the campaign, which simulator it was flown
        on, what time it was or is flown (usually Sunday’s 1900 local british time), and it’s current status (In preparation,
        ongoing or finished). There’s also some statistics like average number of participants per mission, how many missions
        were flown etc.. .
      </p>
      <p class="text-align-justify">
        Click on any campaign to access information about the unit setup of the campaign, mission briefings and after action
        reports.
      </p>

    </div>
    <template>
      <h3>Ongoing campaigns</h3>
      <DivLinkButton
        v-for="campaign in campaigns"
        v-if="campaign.campaign_status <= 1"
        v-bind:key="campaign.id"
        v-bind="{routeName: 'Missions', routeParams: {campaign_id: campaign.id}}">
        <CampaignInfoBaseComp v-bind="campaign"></CampaignInfoBaseComp>
      </DivLinkButton>
    </template>
    <template>
      <h3>Finished and future campaigns</h3>
      <DivLinkButton
        v-for="campaign in campaigns"
        v-if="campaign.campaign_status > 1"
        v-bind:key="campaign.id"
        v-bind="{routeName: 'Missions', routeParams: {campaign_id: campaign.id}}">
        <CampaignInfoBaseComp v-bind="campaign"></CampaignInfoBaseComp>
      </DivLinkButton>
    </template>
  </div>
</template>

<script>
import CampaignInfoBaseComp from "./CampaignInfoBaseComp";
import DivLinkButton from "../basic_comp/DivLinkButton";

export default {
  name: 'CampaignList',
  components: {
    CampaignInfoBaseComp,
    DivLinkButton
  },
  mounted () {

    this.$dbCon.requestViewData(this.$options.name,
      {view: "campaign_list"})
      .then(response => {
        this.campaigns = response;
        // return this.$dbCon.requestViewData(this.$options.name,
        //   {view: "campaign_list", campaign_status: 1})
      })
      // .then(response => {
      //   this.ongoing_campaigns = response;
      // })
      .catch(error => {
        console.log(error.message);
      });
  },
  data () {
    return {
      // ongoing_campaigns: null,
      campaigns: null,
    }
  },
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>
