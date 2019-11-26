<template>
  <div>
    <BriefingSideNav></BriefingSideNav>
    <div class="side-nav-heading heading">Mission synopsis and reports</div>
    <div class="mission-unit-container" v-for="child in nestedData('campaign_units')">
      <MissionUnitsSideNavBaseComp v-bind="child"></MissionUnitsSideNavBaseComp>
    </div>
  </div>
</template>

<script>
import MissionUnitsSideNavBaseComp from "./MissionUnitSideNavBaseComp";
import BriefingSideNav from "./BriefingSideNav"
import { mapGetters} from "vuex"

export default {
  name: "MissionUnitSideNav",
  components: {
    MissionUnitsSideNavBaseComp,
    BriefingSideNav
  },
  mounted () {

    this.updateMissionID(this.$route.params.mission_id);

  },
  beforeRouteUpdate (to, from, next) {
    // called when the route that renders this component has changed,
    // but this component is reused in the new route.
    // For example, for a route with dynamic params `/foo/:id`, when we
    // navigate between `/foo/1` and `/foo/2`, the same `Foo` component instance
    // will be reused, and this hook will be called when that happens.
    // has access to `this` component instance.
    this.updateMissionID(this.$route.params.mission_id);
    next();
  },
  computed: {

    ...mapGetters("missionStore", [
      "nestedData",
      "filterByKey"
    ])
  },
  methods: {

    updateMissionID: function (m_id) {

      if(this.filterByKey("campaign_units", "campaign_id", this.$route.params.campaign_id).length === 0){
        this.$store.dispatch('missionStore/loadStoreData',
          {
            caller: this.$options.name,
            call_object: {
              view: "campaign_info_unit",
              campaign_id: this.$route.params.campaign_id
            },
            data_array_name: "campaign_units"
          }
        ).catch(error => {
          console.log(error.message);
        });
      }

      if(this.filterByKey("reports", "mission_id", this.$route.params.mission_id).length === 0){
        console.log("loading reports");
        this.$store.dispatch('missionStore/loadStoreData',
          {
            caller: this.$options.name,
            call_object: {
              view: "mission_report_nav_list",
              mission_id: this.$route.params.mission_id
            },
            data_array_name: "reports"
          }
        ).catch(error => {
          console.log(error.message);
        });
      }
    }

  }
}
</script>

<style scoped>

.mission-unit-container{
  padding: 10px 2px;
}

</style>
