<template>
  <div class="CampaignList">
    <p>Here you find a list of all ACG campaigns. The list contains future, current
    and past campaigns. There's only one primary campaign at any time. The number
    of side campaigns at any time is not limited.</p>
    <div class="link-list" v-for="(campaign) in campaigns" v-on:click="routeToCampaign(campaign.id)">
      <div class="multi-line-link-button full-width">
        <div>
          <div class="inline">
            <span class="link-list-heading">{{ campaign.name}}</span>
          </div>
          <div class="inline float-right">
            <span v-if="campaign.primary">Primary campaign</span>
            <span v-else>Side campaign</span>
            <span>{{ campaignStatus(campaign.campaign_status) }}</span>
          </div>
        </div>
        <div>
          <span>Platform: {{ platform(campaign.platform) }}</span>
          <span>Time: {{ campaign.time }}</span>
        </div>
        <div>
          <span>Number of participating units: {{ campaign.units }}</span>
          <span>Missions completed: {{ campaign.missions }}</span>
          <span>Sorties flown: {{ campaign.sorties }}</span>
        </div>
        <div>
          <span>Average participants per mission: {{ campaign.avg_attendance }}</span>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import Mockcom from './../resource/index'
import {platform, campaignStatus} from './../resource/statusConverter'

export default {
  name: 'CampaignList',
  mounted () {
      // axios.get("pam/campaigns")
      //   .then(response => {
      //     this.campaigns = response.data._embedded.campaigns;
      //   })
      //   .catch(err => {
      //     console.log("call: "+call+" error: "+err)
      //   })
    Mockcom.getByName('campaigns')
      .then(response => {
        this.campaigns = response;
      })
      .catch(function (error) {
        console.log(error.message);
      })
    },
  data () {
    return {
      campaigns: null,
      platform: platform,
      campaignStatus: campaignStatus
    }
  },
  methods: {

    routeToCampaign: function (campaignID) {
      this.$router.push({name: 'Campaign', params: {campaign_id: campaignID}})
      //DEBUG
      console.log("CampaignList: Pushing to -> {name: 'Campaign', params: {campaign_id: "+campaignID+"}}")
    }
  }
}


</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>


</style>
