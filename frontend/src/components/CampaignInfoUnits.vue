<template>
  <div class="CampaignInfoMissions">
    <p>Here you find a list of all units of the campaign {{campaign_id}}.</p>
    <div>
      <CampaignInfoUnitsBaseComp v-bind="campaign_units[0]"></CampaignInfoUnitsBaseComp>
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

    dbCon.requestViewData({view:"campaign_info_unit", campaign_id:this.$route.params.campaign_id})
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
      campaign_units: {}
    }
  }
}


</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style>

</style>
