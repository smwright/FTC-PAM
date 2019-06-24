<template>
  <div>
    <BriefingSideNav></BriefingSideNav>
    <div class="side-nav-heading heading">Mission synopsis and reports</div>
    <div class="mission-unit-container" v-for="child in unitsTree">
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
  data () {
    return {
      // campaign_units: null,
    }
  },
  mounted () {

    this.loadUnits();
  },
  computed: {

    ...mapGetters("missionStore", [
      "unitsTree",
    ])
  },
  methods: {
    loadUnits: function () {
      this.$store.commit('missionStore/clearReports');
      this.$store.dispatch('missionStore/loadUnits',
        {
          caller: this.$options.name,
          campaign_id: this.$route.params.campaign_id
        }
      ).catch(error => {
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
