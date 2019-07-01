<template>
  <div class="CampaignInfoMain">
    <div class="container">
      <CampaignInfoBaseComp v-bind="campaign"></CampaignInfoBaseComp>
    </div>
    <router-view name="subcontent"></router-view>
  </div>
</template>

<script>
import CampaignInfoBaseComp from "./CampaignInfoBaseComp";

export default {
  name: 'CampaignInfoMain',
  components: {CampaignInfoBaseComp},
  mounted () {
    this.$dbCon.requestViewData(this.$options.name, {view:"campaign_list", id:this.$route.params.campaign_id})
      .then(response => {
        this.campaign = response[0];
      })
      .catch(error => {
        console.log(error.message);
      });
  },
  data () {
    return {
      campaign: null
    }
  }
}


</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style>

</style>
