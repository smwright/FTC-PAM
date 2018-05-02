<template>
  <div class="CampaignList">
    <p>Here you find a list of all ACG campaigns. The list contains future, current 
    and past campaigns. There's only one primary campaign at any time. The number
    of side campaigns at any time is not limited.</p>
    <div class="link" v-for="(campaign, index) in campaigns" v-on:click="routeToCampaign(campaign.id)">
        <div>
          ID:{{ campaign.id }} -- 
          <template v-if="campaign.primary">
            Primary campaign
          </template>
          <template v-else>
            Side campaign
          </template> --
          Status: {{ campaign.campaign_status }}
        </div>
        <div>
          {{ campaign.name }} --
        </div> 
        <div>
          Platform: {{ campaign.platform }} --
          Time: {{ campaign.time }}
        </div>
    </div>
  </div>
</template>

<script>
import Campaigns from './../resource/campaigns'

export default {
  name: 'CampaignList',
  created: function () {
    this.getCampaigns()
  },
  data () {
    return {
      campaigns: []
    }
  },
  methods: {
    getCampaigns: function () {
      Campaigns.getAll().then((data) => {
        this.campaigns = data;
      }, (err) => {
        console.log(err)
      })
    },
    
    routeToCampaign: function (campaignID) {
      this.$router.push({name: 'Campaign', params: {campaign_id: campaignID}})
      //DEBUG
      console.log("CampaignList: Pushing to -> {name: 'Campaign', params: {campaign_id: "+campaignID+"}}")
    }
  }
}


</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style>

</style>
