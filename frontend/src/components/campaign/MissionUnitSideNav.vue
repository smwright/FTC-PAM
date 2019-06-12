<template>
  <div>
    <BriefingSideNav></BriefingSideNav>
    <div class="side-nav-heading heading">Mission synopsis and reports</div>
    <div class="mission-unit-container" v-for="child in campaign_units">
      <MissionUnitsSideNavBaseComp v-bind="child"></MissionUnitsSideNavBaseComp>
    </div>
  </div>
</template>

<script>
import MissionUnitsSideNavBaseComp from "./MissionUnitSideNavBaseComp";
import BriefingSideNav from "./BriefingSideNav"

export default {
  name: "MissionUnitSideNav",
  components: {
    MissionUnitsSideNavBaseComp,
    BriefingSideNav
  },
  data () {
    return {
      campaign_units: null,
    }
  },
  mounted () {

    this.loadUnits(this.$route.params.campaign_id);
  },
  methods: {
    loadUnits: function (campaign_id) {
      this.$dbCon.requestViewData(this.$options.name, {view: "campaign_info_unit", campaign_id: campaign_id})
        .then(response => {
          this.campaign_units = this.$dbCon.nestData(response);
        })
        .catch(error => {
          console.log(error.message);
        });
    }
  }
}
</script>

<style scoped>

.mission-unit-container{
  padding: 10px 2px;
}

</style>
