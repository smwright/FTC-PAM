<template>
  <div class="CampaignInfoMissions">
    <p>Here you find a list of all units of the campaign {{campaign_id}}.</p>
    <div v-for="child in campaign_units">
      <CampaignInfoUnitsBaseComp v-bind="child"></CampaignInfoUnitsBaseComp>
    </div>
  </div>
</template>

<script>
import * as dbCon from './../resource/dbConnector';
import CampaignInfoUnitsBaseComp from "./CampaignInfoUnitsBaseComp";

export default {
  name: 'CampaignInfoMissions',
  components: {CampaignInfoUnitsBaseComp},
  mounted () {

    dbCon.requestViewData(this.$options.name, {view:"campaign_info_unit", campaign_id:this.$route.params.campaign_id})
      .then(response => {
        this.campaign_units = dbCon.nestData(response);
        console.log(JSON.stringify(this.campaign_units));
      })
      .catch(error => {
        console.log(error.message);
      });
  },
  data () {
    return {
      campaign_id: this.$route.params.campaign_id,
      campaign_units: null
    }
  }
}


</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style>

</style>
