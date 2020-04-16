<template>

  <div>
    <!-- CURRENT ROSTER -->
    <template v-if="this.campaign_id == 0">

      <div class="heading">Active members:</div>
      <DivLinkButton
        v-for="member in active_roster"
        class="typed-on-paper-link clearfix"
        v-bind:key="member.member_id"
        v-bind="{routeName: 'MemberGeneral', routeParams: {member_id: member.member_id}}"
      >
        <UniformRankComp
          class="inline-block float-left width-10 sepia"
          v-bind:rank_real_value="member.rank_value"
          v-bind:rank_lookup="rank_lookup"
        >
        </UniformRankComp>
        <div
          class="inline-block float-left padding-10"
        >
          <div class="heading">
            <span>
              {{member.callsign}}
            </span>
          </div>
          <div>
            <p>Joined ACG on {{ member.status_date_in }}.
              In {{ acgName(member.acg_unit_id) }} since {{ member.transfer_date_in }}.</p>
          </div>
        </div>
      </DivLinkButton>

      <div class="heading">Members on leave:</div>
      <DivLinkButton
        v-for="member in rr_roster"
        class="typed-on-paper-link clearfix"
        v-bind:key="member.member_id"
        v-bind="{routeName: 'MemberGeneral', routeParams: {member_id: member.member_id}}"
      >
        <UniformRankComp
          class="inline-block float-left width-10 sepia"
          v-bind:rank_real_value="member.rank_value"
          v-bind:rank_lookup="rank_lookup"
        >
        </UniformRankComp>
        <div
          class="inline-block float-left padding-10"
        >
          <div class="heading">
            <span>
              {{member.callsign}}
            </span>
          </div>
          <div>
            <p>Joined ACG on {{ member.status_date_in }}.
              In {{ acgName(member.acg_unit_id) }} since {{ member.transfer_date_in }}.</p>
          </div>
        </div>
      </DivLinkButton>

    </template>
    <!-- CAMPAIGN SPECIFIC ROSTER -->
    <template v-else>

      <DivLinkButton
        v-for="member in campaign_roster"
        class="typed-on-paper-link clearfix"
        v-bind:key="member.member_id"
        v-bind="{routeName: 'MemberGeneral', routeParams: {member_id: member.member_id}}"
      >
        <UniformRankComp
          class="inline-block float-left width-10 sepia"
          v-bind:rank_real_value="member.rank_value"
          v-bind:faction="unitFaction"
          v-bind:rank_lookup="rank_lookup"
        >
        </UniformRankComp>
        <div
          class="inline-block float-left padding-10"
        >
          <div class="heading">
            <span>
              {{ rankAbbreviation(member.rank_value, unitFaction) }}
            </span>
            <span>
              {{member.callsign}}
            </span>
          </div>
          <template v-for="event in sortByDate(member.events)">
            <div>
              {{ eventText(event) }}
            </div>
          </template>

        </div>
      </DivLinkButton>

    </template>
  </div>

</template>

<script>
import { mapState, mapGetters } from "vuex"
import DivLinkButton from "../basic_comp/DivLinkButton"
import UniformRankComp from "../acg_member/UniformRankComp"

export default {
  name: "UnitRoster",
  components: {
    DivLinkButton,
    UniformRankComp
  },
  props: {

    unit_id: {
      type: [Number, String],
      default: 0
    },
    campaign_id: {
      type: [Number, String],
      default: 0
    },
  },
  computed: {

    active_roster: function() {

      let roster_info = this.filterByKey("member_info_current", "member_status", 0);

      roster_info.sort(function(a,b){
        return b.rank_value - a.rank_value;
      })
      return roster_info;
    },

    rr_roster: function() {

      let roster_info = this.filterByKey("member_info_current", "member_status", 2);

      roster_info.sort(function(a,b){
        return b.rank_value - a.rank_value;
      })
      return roster_info;
    },

    campaign_roster: function() {

      let return_arr = [];
      let index;
      let roster_info = this.filterByKeys("member_info",
        {
          campaign_id: this.campaign_id,
          acg_unit_id: this.unit_id
        }
      );

      // Transfers: Who's in the unit during campaign
      for(let i=0; i<roster_info.length; i++){

        index = return_arr.findIndex(item => item.member_id === roster_info[i].member_id);

        if(index === -1){

          // Member not in list yet, check if member during campaign and prepare return array entry
          index = return_arr.push(
            {
              member_id: roster_info[i].member_id,
              callsign: roster_info[i].callsign,
              rank_value: roster_info[i].rank_value,
              events: []
            }
          );

          if(roster_info[i].event_in_during_campaign || roster_info[i].event_out_during_campaign){
            return_arr[index - 1].events.push(roster_info[i])
          }

        } else {

          if(roster_info[i].event_in_during_campaign || roster_info[i].event_out_during_campaign){
            return_arr[index].events.push(roster_info[i])
          }

        }

      }

      return_arr.sort(function(a,b){
        return b.rank_value - a.rank_value;
      })
      return return_arr;
    },

    unitFaction: function() {

      let unit_Array = this.filterByKeys("campaign_units",
        {
          acg_unit_id: this.unit_id,
          campaign_id: this.campaign_id

        }
      );
      if(unit_Array.length > 0){
        return unit_Array[0].faction;
      } else {
        return "";
      }
    },

    ...mapState("unitInfo", {
      rank_lookup: state => state.rank_lookup
    }),

    ...mapGetters("unitInfo", [
      "findByKey",
      "filterByKey",
      "filterByKeys",
      "filterByString"
    ])
  },
  methods: {

    sortByDate: function(arr) {

      return arr.sort(function(a,b) {
        let d1 = Date.parse(a.event_date_in);
        let d2 = Date.parse(b.event_date_in);
        return d1 - d2;
      })
    },

    acgName: function(id) {

      let unit_Array = this.filterByKey("campaign_units", "acg_unit_id", id);
      if(unit_Array.length > 0){
        return unit_Array[0].acg_unit_name;
      } else {
        return "";
      }
    },

    rankAbbreviation: function(rank_value, faction) {


      let rank_obj = this.rank_lookup.find(
        function(item) {
          return item.real_value == rank_value
            && item.faction == faction;
        }
      )

      return rank_obj.abreviation;
    },

    eventText: function(event) {

      let str;
      if(event.event_type == "transfer"){

        if(event.event_in_during_campaign){

          str = "Transferred into "+this.acgName(event.event_value)+" on "+event.date_in+".";
        } else if(event.event_out_during_campaign){

          str = "Left "+this.acgName(event.event_value)+" on "+event.date_out+".";
        }

      } else if(event.event_type == "status"){

        if(event.event_in_during_campaign){

          if(event.event_value == 0){
            str = "Active from "+event.date_in+".";
          } else if(event.event_value == 1){
            str = "Dismissed on "+event.date_in+".";
          } else if(event.event_value == 2){
            str = "On leave from "+event.date_in+".";
          } else if(event.event_value == 3){
            str = "";
          }
        }


      }
      return str;
    },

  }
}
</script>

<style scoped>

.sepia {
  filter: sepia(.75);
}

</style>
