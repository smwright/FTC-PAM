<template >
  <div>
    <DivLinkButton class="heading" v-bind="{routeName: 'CampaignUnits', routeParams:{campaign_id: campaign_id}}">
      Units
    </DivLinkButton>
    <DivLinkButton class="heading" v-bind="{routeName: 'Missions', routeParams:{campaign_id: campaign_id}}">
      Missions
    </DivLinkButton>


    <router-view name="sideview_units"></router-view>
  </div>
</template>

<script>

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
  methods: {

  }
}


</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style>

</style>
