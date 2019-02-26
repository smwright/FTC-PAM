<template>
  <div>
    <p>Here you find a list of all ACG campaigns. The list contains future, current
    and past campaigns. There's only one primary campaign at any time. The number
    of side campaigns at any time is not limited.</p>
    <DivLinkButton
      v-for="campaign in campaigns"
      v-bind:key="campaign.id"
      v-bind="{routeName: 'Campaign', routeParams: {campaign_id: campaign.id}}">
      <CampaignInfoBaseComp v-bind="campaign"></CampaignInfoBaseComp>
    </DivLinkButton>
  </div>
</template>

<script>
import CampaignInfoBaseComp from "./CampaignInfoBaseComp";
import DivLinkButton from "../basic_comp/DivLinkButton";

export default {
  name: 'CampaignList',
  components: {
    CampaignInfoBaseComp,
    DivLinkButton
  },
  mounted () {

    this.requestViewData(this.$options.name, {view: "campaign_list"})
      .then(response => {
        this.campaigns = response;
      })
      .catch(error => {
        console.log(error.message);
      });
  },
  data () {
    return {
      campaigns: null,
    }
  },
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>
