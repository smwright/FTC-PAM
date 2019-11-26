<template>
  <div class="CampaignInfoMain">
    <div class="container">
      <CampaignInfoBaseComp v-bind="campaign"></CampaignInfoBaseComp>
    </div>
    <router-view name="subcontent"></router-view>
  </div>
</template>

<script>
import { mapState, mapGetters } from "vuex"
import CampaignInfoBaseComp from "./CampaignInfoBaseComp";

export default {
  name: 'CampaignInfoMain',
  components: {CampaignInfoBaseComp},
  mounted () {

    this.$store.dispatch('missionStore/loadStoreData',
      {
        caller: this.$options.name,
        call_object: {
          view: "campaign_list",
          id: this.$route.params.campaign_id
        },
        data_array_name: "campaign"
      }
    ).catch(error => {
      console.log(error.message);
    });
  },
  computed: {

    ...mapState("missionStore", {

      campaign: state => state.campaign,
    }),
  },
}


</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style>

</style>
