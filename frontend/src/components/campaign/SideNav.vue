<template >
  <div>
    <div v-if="campaign" class="container text-align-justify">
      Get an overview of the units or missions of {{ campaign.name }}.
    </div>

    <DivLinkButton class="heading" v-bind="{routeName: 'CampaignUnits', routeParams:{campaign_id: campaign_id}}">
      Units
    </DivLinkButton>
    <DivLinkButton class="heading" v-bind="{routeName: 'Missions', routeParams:{campaign_id: campaign_id}}">
      Missions
    </DivLinkButton>
    <DivLinkButton class="heading" v-bind="{routeName: 'RecommendedReportsCampaign', routeParams:{campaign_id: campaign_id}}">
      Recommended reports
    </DivLinkButton>

    <router-view name="sideview_units"></router-view>
  </div>
</template>

<script>
  import { mapState, mapGetters } from "vuex"
  import DivLinkButton from "../basic_comp/DivLinkButton"

  export default {
    name: 'SideNav',
    components: {
      DivLinkButton
    },
    created () {

    },
    data () {
      return {
        campaign_id: this.$route.params.campaign_id
      }
    },
    computed: {

      ...mapState("missionStore", {

        campaign: state => state.campaign[0],
      }),
    },
    methods: {

    }
  }

</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style>

</style>
