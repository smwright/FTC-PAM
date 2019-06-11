<template>
  <div>
    <div>
      <button v-on:click="changeTab('general')">General</button>
      <button v-on:click="changeTab('missions')">Missions</button>
      <button v-on:click="changeTab('units')">Units</button>
      <button v-on:click="sendData">Save campaign</button>
      <button v-on:click="fetchData">Fetch campaign</button>
      <div>{{ dbStatus }}</div>
    </div>
    <div>
      <!-- GENERAL INFO -->
      <!------------------>
      <CampaignGeneral
        v-show="tabToShow === 'general'"
        v-bind:campaign_id="campaign_id"
      >
      </CampaignGeneral>

      <!-- GENERAL MISSIONS -->
      <!------------------>
      <div v-show="tabToShow === 'missions'">

        <button v-on:click="addMission">Add mission</button>

        <CampaignMission
         v-for="mission in missionsByCampaignId(this.campaign_id)"
         v-bind:key="mission.id"
         v-bind:mission_id="mission.id"
        >
        </CampaignMission>

      </div>

      <!-- GENERAL UNITS -->
      <!------------------>
      <div class="clearfix" v-show="tabToShow === 'units'">
        <div>
          <button v-on:click="addUnit">Add unit</button>
          <label>Clone units from </label>
          <select v-model="units_clone_id">
            <option
              v-for="(l_campaign) in $store.state.campaignAdmin.campaigns"
              v-if="l_campaign.id !== campaign_id"
              v-bind:value="l_campaign.id"
            >
              {{ l_campaign.name }}
            </option>
          </select>
          <button v-on:click="cloneUnits">Clone units</button>
        </div>

        <div class="inline-block float-left">
          <TreeWrapper ref="tree" v-bind:treedata="units">
            <template slot-scope="tree">
              <div v-on:click="setActiveNode(tree.data)">

                <div class="inline-block float-left">
                  <button v-if="tree.data.children && tree.data.children.length"
                          v-on:click="tree.store.toggleOpen(tree.data)" >
                    {{tree.data.open ? '-' : '+'}}
                  </button>
                </div>
                <div class="inline.block">
                  <div>
                    ID: {{ tree.data.id }}
                    h-ID: {{ tree.data.hist_unit_id}}
                    a-ID: {{ tree.data.acg_unit_id}}
                    c-ID: {{ tree.data.campaign_id}}

                  </div>
                  <div>
                    {{ depl_unit_header(acgUnitsById(tree.data.acg_unit_id), histUnitsById(tree.data.hist_unit_id)) }}
                  </div>
                  <div>
                    <label>ACG unit:</label>
                    <select v-model="tree.data.acg_unit_id">
                      <option v-bind:value="null"></option>
                      <option v-for="a_unit in acg_units" v-bind:value="a_unit.id">
                        {{ a_unit.name }}
                      </option>
                    </select>
                  </div>
                  <div>
                    <label>Historic unit:</label>
                    <select v-model="tree.data.hist_unit_id">
                      <option v-for="h_unit in hist_units" v-bind:value="h_unit.id">
                        {{ h_unit.name }}
                      </option>
                    </select>
                  </div>
                  <div>
                    <label>Asset:</label>
                    <select v-model="tree.data.asset_id">
                      <option v-bind:value="null"></option>
                      <option v-for="asset in controllable_assets" v-bind:value="asset.id">
                        {{ asset.name }}
                      </option>
                    </select>
                  </div>
                  <div class="float-right">
                    <button v-on:click="deleteUnit(tree.data)">Delete</button>
                  </div>
                </div>
              </div>
            </template>
          </TreeWrapper>
        </div>

        <div class="table">
          Description
          <div>
            {{ active_node }}
          </div>
          <div>
            <p>Current pilots in unit:</p>
            <ul>
              <li v-for="member in currentMembersById(active_node.acg_unit_id)">
                {{ member.callsign }}
              </li>
            </ul>
          </div>
          <div>

          </div>
        </div>


      </div>
    </div>
  </div>



</template>

<script>
import statConv from "../../resource/statusConverter"
import CampaignGeneral from "./CampaignGeneralComp"
import CampaignMission from "./CampaignMissionsComp"
import TreeWrapper from "../basic_comp/TreeWrapper"
import { mapState, mapGetters } from "vuex"

export default {
  name: "Campaign",
  mixins: [statConv],
  components: {
    CampaignGeneral,
    CampaignMission,
    TreeWrapper
  },
  mounted (){

    this.updateCampaignID(this.$route.params.campaign_id);
  },
  data () {
    return {

      campaign_id: 0,
      tabToShow: "general",
      units: null,
      units_for_delete: [],
      active_node: {
          id: null,
          acg_unit_id: null
        },
      dbStatus: "",
      units_clone_id: null

    }
  },
  computed: {

    ...mapState("campaignAdmin", {
      hist_units: state => state.hist_units,
      acg_units: state => state.acg_units,
      controllable_assets: state => state.controllable_assets
    }),

    ...mapGetters("campaignAdmin", [
      "histUnitsById",
      "acgUnitsById",
      "currentMembersById",
      "missionsByCampaignId"
    ])

  },

  beforeRouteUpdate (to, from, next) {
    // called when the route that renders this component has changed,
    // but this component is reused in the new route.
    // For example, for a route with dynamic params `/foo/:id`, when we
    // navigate between `/foo/1` and `/foo/2`, the same `Foo` component instance
    // will be reused, and this hook will be called when that happens.
    // has access to `this` component instance.

    var units = this.$refs.tree.getRawData();
    if(units !== undefined){

      this.$store.commit('campaignAdmin/setUnits',

        {id: this.campaign_id, value: units}
      );
    }


    this.updateCampaignID(to.params.campaign_id)
    next();
  },

  beforeRouteLeave (to, from, next) {

    var units = this.$refs.tree.getRawData();
    if(units !== undefined){
      this.$store.commit('campaignAdmin/setUnits',
        // {id: this.campaign_id, value: this.$dbCon.nestData(units)}
        {id: this.campaign_id, value: units}
      );
    }
    next();
  },

  methods: {

    changeTab: function (tab) {

      console.log("Change tab to: "+tab);
      this.tabToShow = tab;
    },

    updateCampaignID: async function (id) {

      this.campaign_id = Number(id);
      await this.$store.dispatch('campaignAdmin/loadACGUnits', { caller: this.$options.name});
      await this.$store.dispatch('campaignAdmin/loadHistUnits', { caller: this.$options.name});
      await this.$store.dispatch('campaignAdmin/loadControllableAssets', { caller: this.$options.name});
      await this.$store.dispatch('campaignAdmin/loadUnitMembers', { caller: this.$options.name})

      var units = this.$store.getters['campaignAdmin/unitsById'](this.campaign_id);
      if (units === undefined) {

        this.$dbCon.requestViewData(this.$options.name, {view: "depl_unit_info", campaign_id: this.campaign_id})
          .then(response => {
            this.units = this.$dbCon.nestData(response);
            this.$store.commit('campaignAdmin/setUnits',
              {id: this.campaign_id, value: this.$dbCon.nestData(response)}
            )
          })
          .catch(error => {
            console.log(error.message);
          });
      } else {

        this.units = units;
      }

      this.$store.dispatch('campaignAdmin/loadMissions', {caller: this.$options.name, campaign_id: this.campaign_id, force: false})
        .catch(error => {
          console.log(error.message);
        });
      this.$store.dispatch('campaignAdmin/loadMissionBriefings', {caller: this.$options.name, campaign_id: this.campaign_id, force: false})
        .catch(error => {
          console.log(error.message);
        });
    },

    fetchData: function () {

      this.$store.dispatch('campaignAdmin/loadCampaign', {caller: this.$options.name, campaign_id: this.campaign_id})
        .catch(error => {
          console.log(error.message);
        });

      this.$dbCon.requestViewData(this.$options.name, {view: "depl_unit_info", campaign_id: this.campaign_id})
        .then(response => {

          this.units = this.$dbCon.nestData(response);
          this.$store.commit('campaignAdmin/setUnits',
            {id: this.campaign_id, value: this.$dbCon.nestData(response)}
          )
        })
        .catch(error => {
          console.log(error.message);
        });

      this.$store.dispatch('campaignAdmin/loadMissions', {caller: this.$options.name, campaign_id: this.campaign_id, force:true})
        .catch(error => {
          console.log(error.message);
        });

      this.$store.dispatch('campaignAdmin/loadMissionBriefings', {caller: this.$options.name, campaign_id: this.campaign_id, force:true})
        .catch(error => {
          console.log(error.message);
        });
    },

    depl_unit_header: function (acg_unit, hist_unit) {

      var h_text = (hist_unit !== undefined) ? hist_unit.name : " N/A";
      var a_text = (acg_unit !== undefined) ? " ("+ acg_unit.name + ")" : " N/A";
      return h_text + a_text;

    },

    addUnit: function () {

      var flatData = this.$dbCon.flatData(this.$refs.tree.getRawData());
      var min_id = flatData.reduce((min, unit) => Math.min(min, unit.id, 0), state.unit.id);
      var node =
        {
          acg_unit_id: null,
          asset_id: null,
          campaign_id: this.campaign_id,
          hist_unit_id: min_id - 1,
          report_type: null
        };
      this.$refs.tree.addNode(node);
    },

    deleteUnit: function (node) {

      if(!confirm("Do you want to delete ?")) {
        return;
      }

      if(node.id > 0){
        this.units_for_delete.push({id: node.id})
      }

      this.$refs.tree.deleteNode(node);

    },

    setActiveNode: function (node) {

      this.active_node.id = node.id;
      this.active_node.acg_unit_id = node.acg_unit_id;
    },

    cloneUnits: function () {

      if(this.units_clone_id !== null) {

        var unit_id = -1;
        var campaign_id = this.campaign_id;
        var units = this.$store.getters['campaignAdmin/unitsById'](this.units_clone_id);
        if (units === undefined) {

          this.$dbCon.requestViewData(this.$options.name, {view: "depl_unit_info", campaign_id: this.units_clone_id})
            .then(response => {
              var flatData = response;
              flatData.forEach(function (unit) {
                unit.id = unit_id--;
                unit.campaign_id = campaign_id;
              });
              this.units = this.$dbCon.nestData(flatData);
              this.$store.commit('campaignAdmin/setUnits',
                {id: this.campaign_id, value: this.$dbCon.nestData(flatData)}
              )
            })
            .catch(error => {
              console.log(error.message);
            });
        } else {

          var flatData = this.$dbCon.flatData(units);
          flatData.forEach(function (unit) {
            unit.id = unit_id--;
            unit.campaign_id = campaign_id;
          });
          this.units = this.$dbCon.nestData(flatData);
          this.$store.commit('campaignAdmin/setUnits',
            {id: this.campaign_id, value: this.$dbCon.nestData(flatData)}
          )
        }


      }
    },

    addMission: function () {

      var now = new Date();
      var year = now.getFullYear();
      var month = now.getMonth() + 1;
      var day = now.getDate();
      this.$store.commit('campaignAdmin/addMission',
        {
          name: 'New Mission',
          campaign_id: this.campaign_id,
          real_date: year+"-"+month+"-"+day,
          hist_date: "1939-09-01 00:00",
          mission_status: 0
        });
    },

    sendData: async function () {

      // method for storing the campaign data in the backend and updating the vuex-stores

      this.dbStatus = "";
      // ------------------------------------------------------------------------
      // Calling vuex-store action to send the basic campaign data to the backend
      // ------------------------------------------------------------------------
      this.$store.dispatch('campaignAdmin/sendCampaign',
        {
          caller: this.$options.name,
          campaign_id: this.campaign_id
        }
      ).then(response => {

        // Displaying status received from backend in status message.
        this.dbStatus += "Campaign update: " + response.message;

        var flatData = this.$dbCon.flatData(this.$refs.tree.getRawData());
        // Campaign_id == -1, meaning a new campaign was created. The deployed units, missions and briefings
        // campaign_id's need to be updated with the auto incremented id from the database.
        if(this.campaign_id === -1) {

          this.campaign_id = response.insert_id[0].new_id;
          flatData.forEach(function (unit) {
            unit.campaign_id = response.insert_id[0].new_id;
          });
          this.units = this.$dbCon.nestData(flatData);

          this.$store.commit('campaignAdmin/updateValue',
            {
              array_name: "missions",
              id_column_name: "campaign_id",
              id_column_value: -1,
              update_column_name: "campaign_id",
              update_column_value: this.campaign_id,
            });

          this.$store.commit('campaignAdmin/updateValue',
            {
              array_name: "briefings",
              id_column_name: "campaign_id",
              id_column_value: -1,
              update_column_name: "campaign_id",
              update_column_value: this.campaign_id,
            });
        }
         // ------------------------------------------------------------------------
         // Sending updated deployed units to the backend
         // ------------------------------------------------------------------------
        return this.$dbCon.insertUpdateData(this.$options.name, {table: "deployed_unit", payload: flatData})

      }).then(response => {

         this.dbStatus += " Unit update: " + response.message;
         var flatData = this.$dbCon.flatData(this.$refs.tree.getRawData());
         for(var i = 0; i < response.insert_id.length; i++ ){

           var index = flatData.findIndex(item => item.id === response.insert_id[i].old_id);
           flatData[index].id = response.insert_id[i].new_id;

         }
         this.units = this.$dbCon.nestData(flatData);
        // ------------------------------------------------------------------------
        // Deleting marked deployed units in the database
        // ------------------------------------------------------------------------
         return this.$dbCon.deleteData(this.$options.name, {table:"deployed_unit", payload:this.units_for_delete})

      }).then(response => {

         this.dbStatus += response.message;
         this.units_for_delete = []

        // ------------------------------------------------------------------------
        // Sending missions to the backend
        // ------------------------------------------------------------------------
        return this.$store.dispatch('campaignAdmin/sendMissions',
          {
            caller: this.$options.name,
            campaign_id: this.campaign_id
          })
        }
      ).then(response => {

        // Displaying status received from backend in status message.
        this.dbStatus += "Mission update: " + response.message;
        // ------------------------------------------------------------------------
        // Deleting marked missions in the database
        // ------------------------------------------------------------------------
        return this.$store.dispatch('campaignAdmin/deleteMissions',
          {
            caller: this.$options.name
          })
        }
      ).then(response => {

          // Displaying status received from backend in status message.
          this.dbStatus += response.message;
        // ------------------------------------------------------------------------
        // Sending missions to the backend
        // ------------------------------------------------------------------------
          return this.$store.dispatch('campaignAdmin/sendMissionBriefings',
            {
              caller: this.$options.name,
              campaign_id: this.campaign_id
            })
        }
      ).then(response => {

          // Displaying status received from backend in status message.
          this.dbStatus += "Briefing update: " + response.message;
        // ------------------------------------------------------------------------
        // Deleting marked briefings in the database
        // ------------------------------------------------------------------------

        return this.$store.dispatch('campaignAdmin/deleteMissionBriefings',
            {
              caller: this.$options.name
            })
        }
      ).then(response => {

          this.dbStatus += response.message;
          console.log(this.$parent.$options.name+": Pushing to -> {name: AdminCampaign, params: campaign_id: "+this.campaign_id+"}");
          this.$router.push({name: "AdminCampaign", params: {campaign_id: this.campaign_id}});
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
