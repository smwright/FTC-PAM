<template>
  <div class="container">
    <div class="heading padding-10">Recommended reading:</div>
    <template v-if="has_campaign_id">
      <p class="padding-10">Below you find a list of recommended After Action Reports to read for the selected campaign. The recommendation
      is based on earned Badgers, given from members to members in appreciation of the reports writing.</p>
      <ReportRecommendationsComp
        v-if="recommendation_list.length > 0"
        v-bind:show-campaign-name="false"
        v-bind:recommendations="this.recommendation_list"
      ></ReportRecommendationsComp>
    </template>
    <template v-else>
      <p class="padding-10">Below you find a list of recommended After Action Reports to read. The recommendation
        is based on earned Badgers, given from members to members in appreciation of the reports writing.</p>
      <ReportRecommendationsComp
        v-if="recommendation_list.length > 0"
        v-bind:recommendations="this.recommendation_list"
      ></ReportRecommendationsComp>
    </template>
  </div>

</template>

<script>
import { mapState, mapGetters} from "vuex"
import ReportRecommendationsComp from "./ReportRecommendationsComp"

export default {
  name: "ReportRecommendations",
  components: {
    ReportRecommendationsComp
  },
  mounted () {

    this.updateCampaignID(this.$route.params.campaign_id);

  },
  beforeRouteUpdate (to, from, next) {
    // called when the route that renders this component has changed,
    // but this component is reused in the new route.
    // For example, for a route with dynamic params `/foo/:id`, when we
    // navigate between `/foo/1` and `/foo/2`, the same `Foo` component instance
    // will be reused, and this hook will be called when that happens.
    // has access to `this` component instance.
    this.updateCampaignID(this.$route.params.campaign_id);
    next();
  },
  computed: {

    has_campaign_id: function () {

      return "campaign_id" in this.$route.params;
    },

    recommendation_list: function () {

      let recommendations = [];
      if(this.has_campaign_id){
        recommendations = this.filterByKey("report_response", "campaign_id", this.$route.params.campaign_id);
      } else {
        recommendations = this.report_response;

      }
      return recommendations;
    },

    ...mapState("missionStore", {
      report_response: state => state.report_response,
    }),

    ...mapGetters("missionStore", [
      "filterByKey",
      "subTree"
    ])
  },
  methods: {

    updateCampaignID: function (c_id) {

      this.$store.dispatch('missionStore/loadStoreData',
        {
          caller: this.$options.name,
          call_object: {
            view: "report_response_info",
            campaign_id: c_id
          },
          data_array_name: "report_response"
        }
      ).catch(error => {
        console.log(error.message);
      });

    }
  }
}
</script>

<style scoped>

</style>
