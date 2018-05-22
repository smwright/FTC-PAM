<template>
  <div class="CampaignInfoMissions">
    <p>Here you find a list of all units of the campaign {{campaign_id}}.</p>
  </div>
</template>

<script>

export default {
  name: 'CampaignInfoMissions',
  created () {
    this.getUnits()
  },
  data () {
    return {
      campaign_id: this.$route.params.campaign_id
    }
  },
  methods: {
    getUnits () {
      
    }
  }
}


</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style>

</style>
