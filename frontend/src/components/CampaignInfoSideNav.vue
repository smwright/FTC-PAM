<template v-if="campaign">
  <div>
    <router-link :to="{ name: 'Units', params: { campaign_id: campaign_id }}">Units</router-link>
    <router-link :to="{ name: 'Missions', params: { campaign_id: campaign_id }}">Missions</router-link>
  </div>
</template>

<script>
import Campaign from './../resource/campaigns'

export default {
  name: 'CampaignInfoSideNav',
  created () {

  },
  data () {
    return {
      campaign_id: this.$route.params.campaign_id
    }
  },
  methods: {

  }
}


</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style>

</style>
