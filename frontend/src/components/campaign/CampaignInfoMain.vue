<template>
  <div class="CampaignInfoMain">
    <p>Here you find info about a particular campaign.</p>
    <CampaignInfoBaseComp v-bind="campaign"></CampaignInfoBaseComp>
    <router-view name="subcontent"></router-view>
  </div>
</template>

<script>
import CampaignInfoBaseComp from "./CampaignInfoBaseComp";

export default {
  name: 'CampaignInfoMain',
  components: {CampaignInfoBaseComp},
  mounted () {
    this.requestViewData(this.$options.name, {view:"campaign_list", id:this.$route.params.campaign_id})
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
