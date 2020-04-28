<template>

  <div>

    <template
      v-for="(roster_d) in roster_data"
    >
      <div v-if="roster_d.title !== undefined" class="heading">{{ roster_d.title }}</div>
      <DivLinkButton
        v-for="member in roster_d.roster"
        class="clearfix"
        v-bind:class="{ 'typed-on-paper-link': active_button }"
        v-bind:key="member.member_id"
        v-bind:active="false"
        v-bind="{routeName: route_name, routeParams: {member_id: member.member_id}}"
      >
        <!--v-bind:active="active_button"-->

        <div class="clearfix">

          <div class="inline-block float-left width-80">

            <div class="heading padding-2-10">
              <span v-if="roster_d.faction !== 0">
              {{ rankAbbreviation(member.rank_value, unitFaction) }}
              </span>
              <span>
              {{member.callsign}}
              </span>
            </div>

            <div class="padding-2-10">
              <slot name="info1"></slot>
            </div>

          </div>
          <div class="clearfix">

            <UniformRankComp
            class="inline-block float-left container uniform-comp min-height-100px"
            v-bind:class="{ sepia: sepia_images }"
            v-bind:rank_real_value="member.rank_value"
            v-bind:rank_lookup="rank_lookup"
            v-bind:faction="roster_d.faction"
            ></UniformRankComp>

            <div class="inline-block padding-10 info-comp min-height-100px">
              <slot name="info2">
                <div v-if=" 'events' in member">
                <template v-for="event in sortByDate(member.events)">
                <div>
                {{ eventText(event) }}
                </div>
                </template>
                </div>
                <div v-else>
                <p>Joined ACG on {{ member.status_date_in }}.
                In {{ acgName(member.acg_unit_id) }} since {{ member.transfer_date_in }}.</p>
                </div>
              </slot>
            </div>

            <div
              class="inline-block float-right"
            >

              <slot
                name="roster_image"
                v-bind:member="{ member }"
              >
                <template v-if="hasImage(member)">
                  <div class="container image-comp">
                    <img
                      class="roster-image"
                      v-bind:class="{ sepia: sepia_images }"
                      :src="member.image">
                  </div>
                </template>
              </slot>

            </div>

          </div>



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
    store_module: {
      type: [String],
      default: "unitInfo"
    },
    sepia_images: {
      type: Boolean,
      default: true
    },
    route_name: {
      type: String,
      default: "MemberGeneral"
    },
    active_button: {
      type: Boolean,
      default: true
    }
  },
  computed: {

    roster_data: function() {

      if(this.campaign_id == 0) {

        let roster_array = [];
        if(this.active_roster.length > 0) roster_array.push(
          {title: "Active members:", roster: this.active_roster, faction: 0}
        );
        if(this.rr_roster.length > 0) roster_array.push(
          {title: "Members on leave:", roster: this.rr_roster, faction: 0}
        );
        return roster_array;

      } else {
        return [{type: undefined, roster: this.campaign_roster, faction: this.unitFaction}];
      }
    },

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
              image: roster_info[i].image,
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


    rank_lookup: function () {

      return this.$store.state[this.store_module].rank_lookup;
    },

  },
  methods: {

    findByKey: function (table, keyName, keyValue) {

      // let storePath = this.store_module+"filterByKey"
      return this.$store.getters[this.store_module+"/findByKey"](table, keyName, keyValue);

    },

    filterByKey: function (table, keyName, keyValue) {

      // let storePath = this.store_module+"filterByKey"
      return this.$store.getters[this.store_module+"/filterByKey"](table, keyName, keyValue);

    },

    filterByKeys: function (table, filterInput) {

      // let storePath = this.store_module+"filterByKey"
      return this.$store.getters[this.store_module+"/filterByKeys"](table, filterInput);

    },

    filterByString: function (table, keyName, searchValue) {

      // let storePath = this.store_module+"filterByKey"
      return this.$store.getters[this.store_module+"/filterByString"](table, keyName, searchValue);

    },

    sortByDate: function(arr) {

      return arr.sort(function(a,b) {
        let d1 = Date.parse(a.date_in);
        let d2 = Date.parse(b.date_in);
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
      if(rank_obj) {

        return rank_obj.abreviation;
      } else {

        console.log("ERRPR "+rank_value+" "+faction);
      }
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

    hasImage: function (member) {

      return ('image' in member && member.image !== null);
    }

  }
}
</script>

<style scoped>

.sepia {
  filter: sepia(.75);
}

.uniform-comp {
  /*width: 380px;*/
  min-height: 168px;
}

.image-comp {
  width: 425px;
  min-height: 168px;
}

.info-comp {
  width: calc(90% - 380px - 24px - 425px - 24px - 24px);
  min-height: 168px;
}

.min-height-100px {
  min-height: 100px;
}

</style>
