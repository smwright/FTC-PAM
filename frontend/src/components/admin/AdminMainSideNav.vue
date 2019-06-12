<template>
  <div>

    <!--<DivLinkButton>-->
      <!--<div class="heading">Members</div>-->
    <!--</DivLinkButton>-->
    <HideableDiv>
      <template slot="buttonHidden">
        <div class="div-button heading">Campaigns</div>
      </template>
      <!--<DivLinkButton v-bind="{routeName: 'AdminCampaign', routeParams: {campaign_id: 0} }">-->
        <!--New campaign-->
      <!--</DivLinkButton>-->
      <!--<br>-->
      <DivLinkButton
        class="campaign-buttons"
        v-for="campaign in campaigns"
        v-bind:key="campaign.id"
        v-bind="{routeName: 'AdminCampaign', routeParams: {campaign_id: campaign.id}}"
      >
        {{ campaign.name }}
      </DivLinkButton>
    </HideableDiv>

    <DivLinkButton v-bind="{routeName: 'AdminHistUnit'}">
      <div class="heading">Historical Units</div>
    </DivLinkButton>

    <DivLinkButton v-bind="{routeName: 'Asset'}">
      <div class="heading">Assets</div>
    </DivLinkButton>
  </div>
</template>

<script>
import { mapState } from "vuex"
import DivLinkButton from "../basic_comp/DivLinkButton"
import HideableDiv from "../basic_comp/HideableDiv"

export default {
  name: "AdminMainSideNav",
  components: {
    DivLinkButton,
    HideableDiv
  },
    mounted () {
    if (this.$store.state.campaignAdmin.campaigns.length == 1){
      this.$store.dispatch('campaignAdmin/loadCampaigns', {caller: this.$options.name});
    }

  },
  computed: {
    ...mapState('campaignAdmin', {
      campaigns: state => state.campaigns
    })
  },

}
</script>

<style scoped>

.campaign-buttons{
  font-size: 1em;
  margin: 2px 0px 0px 15px;
  width: calc(100% - 15px - 26px);
}

</style>
