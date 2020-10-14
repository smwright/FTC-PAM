<template>
  <div>
    <!--<div class="padding-10">-->
      <!--{{JSON.stringify(recommendation_list)}}-->
    <!--</div>-->
    <div v-for="rec in this.recommendation_list">

      <DivLinkButton
        v-bind:key="rec.report_id+'_'+rec.member_id"
        v-bind="{routeName: 'Report',
            routeParams: {
              report_id: rec.report_id,
              mission_id: rec.mission_id,
              campaign_id: rec.campaign_id
            }
          }"
      >
        <img class="unitEmblem" v-bind:src="rec.hist_unit_image"/>
        <span>
          AAR: {{ rec.report_id }}
          by {{ rec.abreviation }} {{ rec.first_name }} '{{ rec.callsign }}' {{ rec.last_name }}
          of {{ rec.hist_unit_name }}
        </span>
        <span v-if="showMissionName">
          for mission "{{ rec.mission_name }}" from {{ rec.mission_real_date }}
        </span>
        <span v-if="showCampaignName">
          of the campaign "{{ rec.campaign_name }}"
        </span>
        <span>
          (earned {{ rec.badgers }} Badgers).
        </span>
      </DivLinkButton>
    </div>
  </div>
</template>

<script>
import { mapState, mapGetters } from "vuex"
import DivLinkButton from "../basic_comp/DivLinkButton"
import LinkButton from "../basic_comp/LinkButton"

export default {
  name: "ReportRecommendations",
  components: {
    LinkButton,
    DivLinkButton
  },
  props: {
    showUnitEmblem: {
      type: Boolean,
      default: true
    },
    showMissionName: {
      type: Boolean,
      default: true
    },
    showCampaignName: {
      type: Boolean,
      default: true
    },
    recommendations: {
      type: Array,
      default: function () {
        return [];
      }
    }
  },
  computed: {

    recommendation_list: function () {

      let result = [];
      let report_ids = [...new Set(this.recommendations.map(report => report.report_id))];

      for(let j=0; j<report_ids.length; j++){
        let reports = this.recommendations.filter(
          function (item) {
            return item.report_id === report_ids[j];
          }
        );

        if(reports.length > 0) {
          reports[0].badgers = reports.length;
          result = result.concat(reports[0]);
        }
      }

      result.sort(function (a,b) {return b.badgers - a.badgers});
      return result;
    }
  }
}
</script>

<style scoped>

.unitEmblem {
  height: 30px;
  vertical-align: middle;
}

.linkButton {
  border: none;
}
</style>
