<template>
  <div>

    <!--<div class="side-nav-heading heading">Unit & member administration</div>-->
    <!--         -->
    <!--ACG-UNITS-->
    <!--         -->
    <!--<HideableDiv>-->
      <!--<template slot="buttonHidden">-->
        <!--<div class="div-button heading">ACG Units</div>-->
      <!--</template>-->
      <!--<UnitAdminSideNav></UnitAdminSideNav>-->
    <!--</HideableDiv>-->

    <!--       -->
    <!--MEMBERS-->
    <!--       -->
    <HideableDiv>
      <template slot="buttonHidden">
        <div class="div-button heading">ACG units & members</div>
      </template>
      <MemberAdminSideNav></MemberAdminSideNav>
    </HideableDiv>

    <!--<div class="side-nav-heading heading">Campaign setup</div>-->
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

    <!--<DivLinkButton v-bind="{routeName: 'AdminHistUnit'}">-->
      <!--<div class="heading">Historical Units</div>-->
    <!--</DivLinkButton>-->
    <HideableDiv>
      <template slot="buttonHidden">
        <div class="div-button heading">Historical units</div>
      </template>

      <HistUnitSideNav
        routeName="AdminHistUnit"
      >
      </HistUnitSideNav>

    </HideableDiv>


    <!--<div class="side-nav-heading heading">Utilities</div>-->
    <!--       -->
    <!--ASSETS-->
    <!--       -->
    <DivLinkButton v-bind="{routeName: 'Asset'}">
      <div class="heading">Assets</div>
    </DivLinkButton>


    <!--       -->
    <!--ROSTER ASSETS-->
    <!--       -->
    <DivLinkButton v-bind="{routeName: 'RosterAsset'}">
      <div class="heading">Roster assets</div>
    </DivLinkButton>


  </div>
</template>

<script>
  import { mapState } from "vuex"
  import DivLinkButton from "../basic_comp/DivLinkButton"
  import HideableDiv from "../basic_comp/HideableDiv"
  import MemberAdminSideNav from "./MemberAdminSideNav"
  import UnitAdminSideNav from "./UnitAdminSideNav"
  import HistUnitSideNav from "../acg_unit/HistUnitSideNav"

  export default {
    name: "AdminMainSideNav",
    components: {
      DivLinkButton,
      HideableDiv,
      MemberAdminSideNav,
      UnitAdminSideNav,
      HistUnitSideNav
    },
    mounted () {
      //Loads campaigns if there's only the NEW CAMPAIGN is in campaign store
      if (this.$store.state.campaignAdmin.campaigns.length == 1){
        this.$store.dispatch('campaignAdmin/loadCampaigns', {caller: this.$options.name});
      }


      this.$store.dispatch('unitAdmin/loadStoreData',
        {
          caller: this.$options.name,
          call_object: {
            view: "hist_unit_info",
          },
          data_array_name: "hist_units"
        }
      ).catch(error => {
        console.log(error.message);
      });

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
