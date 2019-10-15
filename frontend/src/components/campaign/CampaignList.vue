<template>
  <div>
    <p class="container">Here you find a list of all ACG campaigns. The list contains future, current
    and past campaigns.</p>
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
