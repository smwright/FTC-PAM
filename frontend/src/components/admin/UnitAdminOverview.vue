<template>
  <div class="container">
    <h2>Unit overview</h2>

    <table>

      <tr>
        <th colspan="2">Currently:</th>
        <th></th>
        <th colspan="2">Campaign:</th>
        <th colspan="6">
          <select v-model="campaign_to_show">
            <option
              v-for="campaign in campaigns"
              v-if="campaign.id > 0"
              v-bind:value="campaign.id"
            >{{campaign.name}}</option>
          </select></th>
      </tr>

      <tr>
        <td colspan="12">
          <hr>
        </td>
      </tr>

      <tr>
        <th colspan="4"></th>
        <th colspan="4">Active members:</th>
        <th></th>
        <th colspan="4">Attending members:</th>
      </tr>

      <tr>
        <td colspan="12">
          <hr>
        </td>
      </tr>

      <tr>
        <th></th>
        <th>Active:</th>
        <th>On leave:</th>
        <th></th>
        <th>min</th>
        <th>max</th>
        <th>avg</th>
        <th>std</th>
        <th></th>
        <th>min</th>
        <th>max</th>
        <th>avg</th>
        <th>std</th>
      </tr>

      <tr>
        <td class="heading">ACG</td>
        <td>{{ activeTotal() }}</td>
        <td>{{ onLeaveTotal() }}</td>
        <td width="20px"></td>
        <td>{{ getTotalData.min_active }}</td>
        <td>{{ getTotalData.max_active }}</td>
        <td>{{ getTotalData.avg_active }}</td>
        <td>{{ getTotalData.std_active }}</td>
        <td width="40px"></td>
        <td>{{ getTotalData.min_attending }}</td>
        <td>{{ getTotalData.max_attending }}</td>
        <td>{{ getTotalData.avg_attending }}</td>
        <td>{{ getTotalData.std_attending }}</td>
      </tr>

      <tr>
        <td colspan="10">
          <hr>
        </td>
      </tr>

      <tr
        v-for="unit in getUnitData"
        v-bind:key="unit.id"
      >
        <td class="heading">{{ unit.name }}</td>
        <td>{{ unit.currently_active }}</td>
        <td>{{ unit.currently_on_leave }}</td>
        <td width="20px"></td>
        <td>{{ unit.min_active }}</td>
        <td>{{ unit.max_active }}</td>
        <td>{{ unit.avg_active }}</td>
        <td>{{ unit.std_active }}</td>
        <td width="40px"></td>
        <td>{{ unit.min_attending }}</td>
        <td>{{ unit.max_attending }}</td>
        <td>{{ unit.avg_attending }}</td>
        <td>{{ unit.std_attending }}</td>
      </tr>
    </table>

  </div>
</template>

<script>
import { mapState, mapGetters } from "vuex"
import {max, min, mean, std, round} from "mathjs"

export default {
  name: "UnitAdminOverview",
  mounted () {

    console.log("mounted");
    this.loadData();
  },
  data() {

    return {

      campaign_to_show: 0
    }
  },
  computed: {

        // ...mapState('memberAdmin', {
    //
    // }),
    getUnitData: function () {

      let result_array = [];
      let acgu = this.acg_units;
      for(let i=0; i< acgu.length; i++){
        let unit_obj = { id: acgu[i].id, name: acgu[i].name};
        unit_obj.currently_active = this.activeMembers(acgu[i].id);
        unit_obj.currently_on_leave = this.onLeaveMembers(acgu[i].id);

        let acm_array = this.campaignUnitActiveMembers(acgu[i].id, this.campaign_to_show);
        let atm_array = this.campaignUnitAttendingMembers(acgu[i].id, this.campaign_to_show);


        if(acm_array.length > 0){

          unit_obj.min_active = min(acm_array.map(a => a.active_members));
          unit_obj.max_active = max(acm_array.map(a => a.active_members));
          unit_obj.avg_active = round(mean(acm_array.map(a => a.active_members)),1);
          unit_obj.std_active = round(std(acm_array.map(a => a.active_members)),1);

        }

        if(atm_array.length > 0){

          unit_obj.min_attending = min(atm_array.map(a => a.attending_members));
          unit_obj.max_attending = max(atm_array.map(a => a.attending_members));
          unit_obj.avg_attending = round(mean(atm_array.map(a => a.attending_members)),1);
          unit_obj.std_attending = round(std(atm_array.map(a => a.attending_members)),1);

        }


        result_array.push(unit_obj);
      }
      return result_array;

    },

    getTotalData: function () {

      let unit_obj = { id: 0 };

      let acm_array = this.campaignUnitActiveMembers(0, this.campaign_to_show);
      let atm_array = this.campaignUnitAttendingMembers(0, this.campaign_to_show);


      if(acm_array.length > 0){

        unit_obj.min_active = min(acm_array.map(a => a.active_members));
        unit_obj.max_active = max(acm_array.map(a => a.active_members));
        unit_obj.avg_active = round(mean(acm_array.map(a => a.active_members)),1);
        unit_obj.std_active = round(std(acm_array.map(a => a.active_members)),1);

      }

      if(atm_array.length > 0){

        unit_obj.min_attending = min(atm_array.map(a => a.attending_members));
        unit_obj.max_attending = max(atm_array.map(a => a.attending_members));
        unit_obj.avg_attending = round(mean(atm_array.map(a => a.attending_members)),1);
        unit_obj.std_attending = round(std(atm_array.map(a => a.attending_members)),1);

      }

      return unit_obj;
    },

    ...mapState('memberAdmin', {
      acg_units: state => state.acg_units
    }),

    ...mapState('campaignAdmin', {
      campaigns: state => state.campaigns
    }),

    ...mapState('unitAdmin', {
      mission_unit_active_members: state => state.mission_unit_active_members,
      mission_unit_attending_members_count: state => state.mission_unit_attending_members_count
    }),

    ...mapGetters("memberAdmin", [
      "membersByUnitId",
    ]),

    ...mapGetters("unitAdmin", [
      "filterByKeys",
    ]),


  },
  methods: {

    loadData: function() {

      console.log("loading");
      if(this.mission_unit_active_members.length == 0){

        this.$store.dispatch('unitAdmin/loadStoreData',
          {
            caller: this.$options.name,
            call_object: {
              view: "mission_unit_active_members"
            },
            data_array_name: "mission_unit_active_members"
          });
      }

      if(this.mission_unit_attending_members_count.length == 0){

        this.$store.dispatch('unitAdmin/loadStoreData',
          {
            caller: this.$options.name,
            call_object: {
              view: "mission_unit_attending_members_count"
            },
            data_array_name: "mission_unit_attending_members_count"
          });
      }
    },

    activeMembers: function (unit_id) {

      let searchString = "";
      let showActive = true;
      let showOnLeave = false;
      let showDismissed = false;
      let showPassedAway = true;
       return this.membersByUnitId(unit_id,showActive,showOnLeave,showDismissed,showPassedAway,searchString).length;
    },

    onLeaveMembers: function (unit_id) {

      let searchString = "";
      let showActive = false;
      let showOnLeave = true;
      let showDismissed = false;
      let showPassedAway = false;
      return this.membersByUnitId(unit_id,showActive,showOnLeave,showDismissed,showPassedAway,searchString).length;
    },

    activeTotal: function () {

      let units = this.acg_units;
      let count = 0;
      for(let i=0; i<units.length; i++){
        count += this.activeMembers(units[i].id);
      }
      return count;
    },

    onLeaveTotal: function () {

      let units = this.acg_units;
      let count = 0;
      for(let i=0; i<units.length; i++){
        count += this.onLeaveMembers(units[i].id);
      }
      return count;
    },

    campaignUnitActiveMembers: function (unit_id, campaign_id) {

      return this.filterByKeys(
        "mission_unit_active_members",
        {
          acg_unit_id: unit_id,
          campaign_id: campaign_id
        }
      )
    },

    campaignUnitAttendingMembers: function (unit_id, campaign_id) {

      return this.filterByKeys(
        "mission_unit_attending_members_count",
        {
          acg_unit_id: unit_id,
          campaign_id: campaign_id
        }
      )
    },


  }
}
</script>

<style scoped>

</style>
