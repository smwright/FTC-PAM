import Vue from "vue"

// initial state
const state = {

  campaigns: [
    {
      id: -1,
      name: "NEW CAMPAIGN",
      is_primary: 0,
      platform: 0,
      campaign_status: 0,
      time: 0,
      open: 0,
      campaign_link: null,
      image: null,
      description: null
    }
  ],
  units: [
    {
      id: -1,
      units: [{
        id : -1,
        campaign_id : null,
        acg_unit_id : null,
        hist_unit_id : 1,
        asset_id : null,
        report_type : null,
        lft : 1,
        rgt : 2
      }]
    }
  ],
  missions: [],
  missions_for_delete: [],
  briefings: [],
  briefings_for_delete: [],
  acg_units: [],
  hist_units: [],
  controllable_assets: [],
  unit_members: []
}

// getters
const getters = {

  campaignById: (state) => (id_inn) => {
    return state.campaigns.find(
      function (campaigns) {
        return campaigns.id === id_inn;
      });
    },

  unitsById: (state) => (id_inn) => {

    var c_units = state.units.find(
      function (units) {
        return units.id === id_inn;
      });
    if(c_units !== undefined){
      return JSON.parse(JSON.stringify(c_units.units))//c_units.units
    }
    return c_units
  },

  missionsByCampaignId: (state) => (id_inn) => {

    var missions = state.missions.filter(
      function (missions) {
        return missions.campaign_id === id_inn;
      });

    missions.sort(function (a,b) {
      return new Date(b.real_date) - new Date(a.real_date);
    });
    return missions;
  },

  missionsById: (state) => (id_inn) => {

    return state.missions.find(
      function (missions) {
        return missions.id === id_inn;
      });
  },

  briefingByCampaignID: (state) => (id_inn) => {

    return state.briefings.filter(
      function (briefings) {
        return briefings.campaign_id === id_inn;
      });
  },

  briefingByMissionIdAndFaction: (state) => (payload) => {

    return state.briefings.filter(
      function (briefings) {
        return (briefings.mission_id === payload.id
          && briefings.faction === payload.faction);
      });
  },

  acgUnitsById: (state) => (id_inn) => {

    return state.acg_units.find(
      function (units) {
        return units.id === id_inn;
      });
  },

  histUnitsById: (state) => (id_inn) => {

    return state.hist_units.find(
      function (units) {
        return units.id === id_inn;
      });
  },

  currentMembersById: (state) => (id_inn) => {

    return state.unit_members.filter(
      function (member) {
        return member.acg_unit_id === id_inn;
      }
    )
  },

  ongoing_primary_campaign: (state) => {

    return state.campaigns.find(
      function (campaign) {
        return (campaign.is_primary && campaign.campaign_status == 1);
      });
  },


}

// mutations
const mutations = {

  setCampaigns (state, payload) {
    for(var i = 0; i < payload.length; i++ ){

      var index = state.campaigns.findIndex(item => item.id === payload[i].id)
      if(index === -1){
        state.campaigns.push(payload[i]);
      } else {
        state.campaigns.splice(index, 1, payload[i]);
      }
    }
  },

  resetNewCampaign (state, payload) {

    state.campaigns[0] = {
      id: -1,
      name: "NEW CAMPAIGN",
      is_primary: 0,
      platform: 0,
      campaign_status: 0,
      time: 0,
      open: 0,
      campaign_link: null,
      image: null,
      description: null
    };
  },

  setUnits (state, payload) {

    var c_units =  state.units.find(
      function (units) {
        return units.id === payload.id;
      });
    if (c_units !== undefined) {
      c_units.units = payload.value;
    } else {
      state.units.push({id: payload.id, units: payload.value})
    }
  },

  setMissions (state, payload) {

    for(var i = 0; i < payload.length; i++ ){

      var index = state.missions.findIndex(item => item.id === payload[i].id)
      if(index === -1){
        state.missions.push(payload[i]);
      } else {
        state.missions.splice(index, 1, payload[i]);
      }
    }
  },

  setBriefings (state, payload) {

    for(var i = 0; i < payload.length; i++ ){

      var index = state.briefings.findIndex(item => item.id === payload[i].id)
      if(index === -1){
        state.briefings.push(payload[i]);
      } else {
        state.briefings.splice(index, 1, payload[i]);
      }
    }
  },

  setACGUnit (state, payload) {
    for (var i = 0; i < payload.length; i++) {
      state.acg_units.push(payload[i]);
    }
  },

  setHistUnit (state, payload) {
    for (var i = 0; i < payload.length; i++) {
      state.hist_units.push(payload[i]);
    }
  },

  setControllableAsset (state, payload) {
    for (var i = 0; i < payload.length; i++) {
      state.controllable_assets.push(payload[i]);
    }
  },

  setUnitMembers (state, payload) {

    state.unit_members = payload;
  },

  addMission (state, payload) {
    if(state.missions.length > 0) {
      // find minimum id value in missions
      var min_id = state.missions.reduce((min, missions) => Math.min(min, missions.id, 0), state.missions[0].id);
      payload.id = min_id - 1;
    } else {
      payload.id = -1;
    }
    state.missions.push(payload);
  },

  deleteMission (state, payload) {

    for(var i=0; i < state.missions.length; i++){
      if(state.missions[i].id === payload.id){

        var mission = state.missions.splice(i,1)
        if(mission[0].id > 0){
          state.missions_for_delete.push(mission[0]);
        }
      }
    }

    for(var i=0; i < state.briefings.length; i++){
      if(state.briefings[i].mission_id === payload.id){

        var briefing = state.briefings.splice(i,1)
        if(briefing[0].mission_id > 0){
          state.briefings_for_delete.push(briefing[0]);
        }
      }
    }
  },

  resetDeleteMission (state, payload) {

    state.missions_for_delete = [];
  },

  resetDeleteBriefing (state, payload) {

    state.briefings_for_delete = [];
  },

  updateValue (state, payload) {

    // Needed values:
    // array_name: Name of the array to update
    // id_column_name: Name of the property to identify the object to be updated
    // id_column_value: Value of the property to identify the object to be updated
    // update_column_name: Name of the property to be updated
    // update_column_value: New value of the property

    var result_array = state[payload.array_name].filter(
      function (search_array) {
        return search_array[payload.id_column_name] === payload.id_column_value;
      });
    for(var i = 0; i < result_array.length; i++) {
      result_array[i][payload.update_column_name] = payload.update_column_value;
    }
  },

  updateBriefing (state, payload) {

    var briefings = state.briefings.find(
      function (briefings) {
        return (briefings.mission_id === payload.mission_id
          && briefings.faction === payload.faction);
      });
    if (briefings !== undefined) {
      briefings.text = payload.text;
    } else {
      if(state.briefings.length > 0){
        var min_id = state.briefings.reduce((min, briefings) => Math.min(min, briefings.id, 0), state.briefings[0].id);
        payload.id = min_id - 1;
      } else {
        payload.id = -1;
      }
      state.briefings.push(payload);
    }
  },

  updateStatus (state, payload) {

    if(payload.campaign_status == 1){

      var ongoing_primary_campaign = state.campaigns.find(
        function (campaign) {
          return (campaign.is_primary
            && campaign.campaign_status == 1
            && campaign.id !== payload.campaign_id
          );
        });
      if(ongoing_primary_campaign !== undefined) {
        alert("There can only be one ongoing primary campaign at all time. \r\n"+
        ongoing_primary_campaign.name + " is currently ongoing. \r\n" +
        "Please change it's status before switching this campaign to ongoing.");
      }
    }
  }
}

// actions
const  actions = {

  loadCampaigns (context, payload) {

    Vue.prototype.$dbCon.requestViewData("campaignAdmin on behalf of "+payload.caller,
      {
        view: "campaign",
        order: "ORDER BY id DESC"
      })
      .then(response => {

        context.commit("setCampaigns", response);

      })
      .catch(error => {
        console.log(error.message);
      });
  },

  loadCampaign (context, payload) {

    Vue.prototype.$dbCon.requestViewData("campaignAdmin on behalf of "+payload.caller,
      {view: "campaign", id: payload.campaign_id })
      .then(response => {

        context.commit("setCampaigns", response);

      })
      .catch(error => {
        console.log(error.message);
      });

  },

  sendCampaign (context, payload) {

    return new Promise(function (resolve, reject) {

      var campaign = JSON.parse(JSON.stringify(context.getters.campaignById(payload.campaign_id)));
      Vue.prototype.$dbCon.insertUpdateData("campaignAdmin on behalf of "+payload.caller,
        {
          table: "campaign",
          payload: [campaign]
        })
        .then(response => {

          if(payload.campaign_id === -1){

            context.commit("resetNewCampaign");
            campaign.id = response.insert_id[0].new_id;
            context.commit("setCampaigns", [campaign]);
          }
          resolve(response);
      })
        .catch(error => {
          reject(error.message);
        });

    })

  },

  loadACGUnits (context, payload) {

    return new Promise(function (resolve, reject) {
      if (context.state.acg_units.length === 0) {
        Vue.prototype.$dbCon.requestViewData("campaignAdmin on behalf of " + payload.caller, {view: "acg_unit"})
          .then(response => {

            context.commit("setACGUnit", response);
            resolve();

          })
          .catch(error => {
            reject(error.message);
          });
      } else {
        resolve();
      }
    })
  },

  loadHistUnits (context, payload) {

    return new Promise(function (resolve, reject) {
      if (context.state.hist_units.length === 0) {
        Vue.prototype.$dbCon.requestViewData("campaignAdmin on behalf of " + payload.caller, {view: "hist_unit"})
          .then(response => {

            context.commit("setHistUnit", response);
            resolve();

          })
          .catch(error => {
            reject(error.message);
          });
      } else {
        resolve();
      }
    })
  },

  loadControllableAssets (context, payload) {

    return new Promise(function (resolve, reject) {
      if (context.state.controllable_assets.length === 0) {
        Vue.prototype.$dbCon.requestViewData("campaignAdmin on behalf of " + payload.caller,
          {view: "asset_subtree", parent_name: "Aircraft"})
          .then(response => {

            context.commit("setControllableAsset", response);
            resolve();

          })
          .catch(error => {
            reject(error.message);
          });
      } else {
        resolve();
      }
    })
  },

  loadUnitMembers (context, payload) {

    return new Promise(function (resolve, reject) {
      if (context.state.unit_members.length === 0) {
        Vue.prototype.$dbCon.requestViewData("campaignAdmin on behalf of " + payload.caller, {view: "current_unit_members"})
          .then(response => {

            context.commit("setUnitMembers", response);
            resolve();

          })
          .catch(error => {
            reject(error.message);
          });
      } else {
        resolve();
      }
    })
  },

  loadMissions (context, payload) {

    return new Promise(function (resolve, reject) {

      var missions = state.missions.filter(
        function (missions) {
          return missions.campaign_id === payload.campaign_id;
        });

      if (missions.length === 0 | payload.force) {
        Vue.prototype.$dbCon.requestViewData("campaignAdmin on behalf of " + payload.caller,
          {view: "campaign_mission_info", campaign_id: payload.campaign_id })
          .then(response => {

            context.commit("setMissions", response);
            resolve();

          })
          .catch(error => {

            reject(error.message);
          });
      } else {
        resolve();
      }
    })
  },

  sendMissions  (context, payload) {

    return new Promise(function (resolve, reject) {

      var missions = context.getters.missionsByCampaignId(payload.campaign_id);
      console.log(JSON.stringify(missions));
      Vue.prototype.$dbCon.insertUpdateData("campaignAdmin on behalf of "+payload.caller,
        {
          table: "mission",
          payload: missions
        })
        .then(response => {

          // Updating mission and briefing id's after mission insert in the databse
          for(var i = 0; i < response.insert_id.length; i++) {

            context.commit('updateValue',
              {
                array_name: "missions",
                id_column_name: "id",
                id_column_value: response.insert_id[i].old_id,
                update_column_name: "id",
                update_column_value: response.insert_id[i].new_id,
              });
            context.commit('updateValue',
              {
                array_name: "briefings",
                id_column_name: "mission_id",
                id_column_value: response.insert_id[i].old_id,
                update_column_name: "mission_id",
                update_column_value: response.insert_id[i].new_id,
              });

          }

          resolve(response);
        })
        .catch(error => {
          reject(error.message);
        });
    })
  },

  deleteMissions  (context, payload) {

    return new Promise(function (resolve, reject) {

      Vue.prototype.$dbCon.deleteData("campaignAdmin on behalf of "+payload.caller,
        {table:"mission", payload: context.state.missions_for_delete})
        .then(response => {
          context.commit('resetDeleteMission');
          resolve(response);
        })
        .catch(error => {
          reject(error.message);
        });
    })
  },

  loadMissionBriefings (context, payload) {

    return new Promise(function (resolve, reject) {

      var briefings = state.briefings.filter(
        function (briefings) {
          return briefings.campaign_id === payload.campaign_id;
        });
      if (briefings.length === 0 | payload.force) {
        Vue.prototype.$dbCon.requestViewData("campaignAdmin on behalf of " + payload.caller,
          {view: "briefing_info", campaign_id: payload.campaign_id  })
          .then(response => {

            context.commit("setBriefings", response);
            resolve();

          })
          .catch(error => {
            reject(error.message);
          });
      } else {
        resolve();
      }
    })
  },

  sendMissionBriefings (context, payload) {

    var briefings = context.getters.briefingByCampaignID(payload.campaign_id);

    return new Promise(function (resolve, reject){
      Vue.prototype.$dbCon.insertUpdateData("campaignAdmin on behalf of "+payload.caller,
        {
          table: "briefing",
          payload: briefings
        })
        .then(response => {

          // Updating mission and briefing id's after mission insert in the databse
          for(var i = 0; i < response.insert_id.length; i++) {


            context.commit('updateValue',
              {
                array_name: "briefings",
                id_column_name: "id",
                id_column_value: response.insert_id[i].old_id,
                update_column_name: "id",
                update_column_value: response.insert_id[i].new_id,
              });

          }

          resolve(response);
        })
        .catch(error => {
          reject(error.message);
        });


    })
  },

  deleteMissionBriefings  (context, payload) {

    return new Promise(function (resolve, reject) {

      Vue.prototype.$dbCon.deleteData("campaignAdmin on behalf of "+payload.caller,
        {table:"briefing", payload: context.state.briefings_for_delete})
        .then(response => {

          context.commit('resetDeleteBriefing');
          resolve(response);
        })
        .catch(error => {
          reject(error.message);
        });
    })
  },

}


export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}
