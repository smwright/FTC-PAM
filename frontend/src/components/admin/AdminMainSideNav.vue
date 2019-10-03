<template>
  <div>

    <!--       -->
    <!--MEMBERS-->
    <!--       -->
    <HideableDiv>
      <template slot="buttonHidden">
        <div class="div-button heading">Members</div>
      </template>
      <MemberAdminSideNav></MemberAdminSideNav>
    </HideableDiv>

    <!--         -->
    <!--CAMPAIGNS-->
    <!--         -->
    <HideableDiv>
      <template slot="buttonHidden">
        <div class="div-button heading">Campaigns</div>
      </template>
      <DivLinkButton
        class="campaign-buttons"
        v-for="campaign in campaigns"
        v-bind:key="campaign.id"
        v-bind="{routeName: 'AdminCampaign', routeParams: {campaign_id: campaign.id}}"
      >
        {{ campaign.name }}
      </DivLinkButton>
    </HideableDiv>

    <!--       -->
    <!--HISTORICAL UNITS-->
    <!--       -->
    <DivLinkButton v-bind="{routeName: 'AdminHistUnit'}">
      <div class="heading">Historical Units</div>
    </DivLinkButton>

    <!--       -->
    <!--ASSETS-->
    <!--       -->
    <DivLinkButton v-bind="{routeName: 'Asset'}">
      <div class="heading">Assets</div>
    </DivLinkButton>
  </div>
</template>

<script>
import { mapState } from "vuex"
import DivLinkButton from "../basic_comp/DivLinkButton"
import HideableDiv from "../basic_comp/HideableDiv"
import MemberAdminSideNav from "./MemberAdminSideNav"

export default {
  name: "AdminMainSideNav",
  components: {
    DivLinkButton,
    HideableDiv,
    MemberAdminSideNav
  },
    mounted () {
    //Loads campaigns if there's only the NEW CAMPAIGN is in campaign store
    if (this.$store.state.campaignAdmin.campaigns.length == 1){
      this.$store.dispatch('campaignAdmin/loadCampaigns', {caller: this.$options.name});
    }

  },
  computed: {
    ...mapState('campaignAdmin', {
      campaigns: state => state.campaigns
    }),

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
