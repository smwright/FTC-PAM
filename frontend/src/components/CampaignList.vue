<template>
  <div class="CampaignList">
    <p>Here you find a list of all ACG campaigns. The list contains future, current
    and past campaigns. There's only one primary campaign at any time. The number
    of side campaigns at any time is not limited.</p>
    <div class="link-list" v-for="(campaign) in campaigns" v-on:click="routeToCampaign(campaign.id)">
      <div class="multi-line-link-button full-width">
        <CampaignInfoBaseComp v-bind="campaign"></CampaignInfoBaseComp>
      </div>
    </div>
  </div>
</template>

<script>
import * as dbCon from './../resource/dbConnector'
import CampaignInfoBaseComp from "./CampaignInfoBaseComp";

export default {
  name: 'CampaignList',
  components: {CampaignInfoBaseComp},
  mounted () {

    dbCon.requestViewData({view: "campaign_list"})
      .then(response => {
        this.campaigns = response;
      })
      .catch(error => {
        console.log(error.message);
      });
  },
  data () {
    return {
      campaigns: {},
    }
  },
  methods: {

    routeToCampaign: function (campaignID) {
      this.$router.push({name: 'Campaign', params: {campaign_id: campaignID}});
      //DEBUG
      console.log("CampaignList: Pushing to -> {name: 'Campaign', params: {campaign_id: "+campaignID+"}}")
    }
  }
}


</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>


</style>
