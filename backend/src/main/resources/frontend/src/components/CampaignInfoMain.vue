<template>
  <div class="CampaignInfoMain">
    <p>Here you find info about a particular campaign.</p>
    <p>
      ID:{{ campaign.id }} -- 
      <template v-if="campaign.primary">
        Primary campaign
      </template>
      <template v-else>
        Side campaign
      </template> --
      Status: {{ campaign.campaign_status }}
    </p>
    <p>
      {{ campaign.name }} -- Platform: {{ campaign.platform }} -- Time: {{ campaign.time }}
    </p>
    <router-view name="subcontent"></router-view>
  </div>
</template>

<script>
import Campaign from './../resource/campaigns'

export default {
  name: 'CampaignInfoMain',
  created () {
    this.getCampaign()
  },
  data () {
    return {
      campaign: {}
    }
  },
  methods: {
    getCampaign () {
      Campaign.get(this.$route.params.campaign_id).then((data) => {
        this.campaign = data
      }, (err) => {
        console.log(err)
      })
    }
  }
}


</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style>

</style>
