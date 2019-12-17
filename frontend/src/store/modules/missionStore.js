import Vue from "vue"

// initial state
const state = {

  campaign: {},
  campaign_units: [],
  missions: [],
  campaign_unit_plane_asset_status: [],
  campaign_unit_member_info: [],
  reports: [],
  report: {},
  report_details: {},
  aerial_claims: [],
  aerial_claims_for_delete: [],
  ground_claims: [],
  ground_claims_for_delete: [],
  comments: [],
  units: [],
  assets: [],
  members: [],


};

// getters
const getters = {

  findByKey: (state) => (table, keyName, keyValue) => {

    // console.log("Serching "+keyName+" = "+keyValue+" in "+table);
    return state[table].find(
      function (item) {
        return item[keyName] == keyValue;
      });
  },

  filterByKey: (state) => (table, keyName, keyValue) => {

    // console.log("Serching "+keyName+" = "+keyValue+" in "+table);
    return state[table].filter(
      function (item) {
        return item[keyName] == keyValue;
      });
  },

  nestedData: (state) => (table) => {

    return Vue.prototype.$dbCon.nestData(state[table]);
  },

  missionById: (state) => (id_inn) => {

    var mission = state.missions.find(
      function (missions) {
        return missions.id == id_inn;
      }
    );
    return mission;
  },

  missionStatusById: (state, getters) => (id_inn) => {

    var mission = getters.missionById(id_inn);
    if(mission != undefined){
      return mission.mission_status;
    } else {
      return undefined;
    }
  },

  reportUnit: (state) => {

    return state.units.find(
      function (units) {
        return units.depl_unit_id === state.report.depl_unit_id;
      }
    )
  },

  reportAsset: (state) => {
    var return_asset = state.assets.find(
      function (asset) {
        return asset.id === state.report.asset_id;
      }
    )
    if(return_asset == undefined){
      return {name: "N/A"};
    } else {
      return return_asset;
    }
  },

  unitsTree: (state) => {

    return Vue.prototype.$dbCon.nestData(state.units);
  },

  reportsByUnit: (state) => (id_inn) => {

    console.log("Searching for reports of depl_uni = "+id_inn);
    var reports = state.reports.find(
      function (report) {
        return report.depl_unit_id == id_inn;
      }
    );
    if(reports !== undefined){
      return reports.reports;
    } else {
      return [];
    }

  },

  unitsByFaction: (state) => (faction_inn) => {

    return state.units.filter(
      function (units) {
        return units.faction === faction_inn;
      }
    )
  },

  assetById: (state) => (id_inn) => {
    return state.assets.find(
      function (asset) {
        return asset.id === id_inn;
      }
    )
  },

  assetByFaction: (state) => (faction_inn) => {

    if(faction_inn > 0){
      return state.assets.filter(
        function (asset) {
          return asset.faction === faction_inn && asset.parent_name === "Aircraft";
        }
      )
    } else {
      return state.assets.filter(
        function (asset) {
          return asset.faction !== Math.abs(faction_inn) && asset.parent_name === "Aircraft";
        }
      )
    }
  },

  assetByFactionControllable: (state) => (faction_inn, controlable) => {

    return state.assets.filter(
      function (asset) {
        return asset.faction === faction_inn && asset.controlable === controlable
          && asset.parent_name === "Aircraft";
      }
    )
  },

  groundTargets: (state) => {

    return state.assets.filter(
      function (asset) {
        return asset.parent_name === "Vehicle" |
          asset.parent_name === "Structure" |
          asset.name === "Aircraft";
      }
    )
  },

  aerialClaimById: (state) => (id_inn) => {


    return state.aerial_claims.find(
      function (claim) {
        return claim.claim_id === id_inn;
      });
  },

  groundClaimById: (state) => (id_inn) => {


    return state.ground_claims.find(
      function (claim) {
        return claim.claim_id === id_inn;
      });
  },

  activeMembers: (state) => {

    return state.members.filter(
      function (member) {
        return member.member_status === 0 | member.member_status === 2;          ;
      }
    )
  },

  memberById: (state) => (id_inn) => {

    return state.members.find(
      function (member) {
        return member.member_id === id_inn;
      });
  },

}

// mutations
const mutations = {

  resetTable (state, table) {

    state[table] = [];
  },

  setDataArray (state, payload) {

    // Needed values:
    // array_name: Name of the array to set
    // array_data: Date to store in the array
    state[payload.array_name] = payload.array_data;
  },

  clearDataArray (state, payload) {

    state[payload.array_name] = [];
  },

  setReports (state, payload) {

    var index;
    for(var i = 0; i < payload.length; i++ ){

      index = state.reports.findIndex(item => item.report_id === payload[i].report_id)
      if(index === -1){
        state.reports.push(payload[i]);
      } else {
        state.reports.splice(index, 1, payload[i]);
      }
    }

  },

  clearReports (state, payload) {

    state.reports = [];
  },

  setReport (state, payload) {

    state.report = payload;
  },

  setReportDetails (state, payload) {

    state.report_details = payload;
  },

  setAerialClaims (state, payload) {

    state.aerial_claims = [];
    for(var i = 0; i < payload.length; i++ ){

        state.aerial_claims.push(payload[i]);
    }
  },

  setGroundClaims (state, payload) {

    state.ground_claims = [];
    for(var i = 0; i < payload.length; i++ ){

        state.ground_claims.push(payload[i]);
    }
  },

  setComments (state, payload) {

    state.comments = [];
    for(var i = 0; i < payload.length; i++ ){

        state.comments.push(payload[i]);
    }
  },

  setUnits (state, payload) {

    state.units = payload;
  },

  setAssets (state, payload) {

    state.assets = payload;
  },

  setMembers (state, payload) {

    state.members = payload;
  },

  updateReportValue (state, payload) {

    // Needed values:
    // array_name: Name of the array to update
    // update_column_name: Name of the property to be updated
    // update_column_value: New value of the property

    var result_array = state[payload.array_name];
    result_array[payload.update_column_name] = payload.update_column_value;
  },

  updateClaimValue (state, payload) {

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
    for (var i = 0; i < result_array.length; i++) {
      result_array[i][payload.update_column_name] = payload.update_column_value;
    }
  },

  addAerialClaim (state, payload) {

    if(state.aerial_claims.length > 0) {
      // find minimum id value in missions
      var min_id = state.aerial_claims.reduce((min, aerial_claims) => Math.min(min, aerial_claims.claim_id, 0), state.aerial_claims[0].claim_id);
      payload.claim_id = min_id - 1;
      payload.claim_detail_id = min_id - 1;
    } else {
      payload.claim_id = -1;
      payload.claim_detail_id = -1;
    }
    state.aerial_claims.push(payload);
  },

  deleteAerialClaim (state, payload) {

    for(var i=0; i < state.aerial_claims.length; i++){
      if(state.aerial_claims[i].claim_id === payload.id){

        var aerial_claim = state.aerial_claims.splice(i,1);
        if(aerial_claim[0].claim_id > 0){
          state.aerial_claims_for_delete.push(aerial_claim[0]);
        }
      }
    }
  },

  resetDeleteAerialClaims (state, payload) {

    state.aerial_claims_for_delete = [];
  },

  addGroundClaim (state, payload) {

    if(state.ground_claims.length > 0) {
      // find minimum id value in missions
      var min_id = state.ground_claims.reduce((min, aerial_claims) => Math.min(min, aerial_claims.claim_id, 0), state.ground_claims[0].claim_id);
      payload.claim_id = min_id - 1;
      payload.claim_detail_id = min_id - 1;
    } else {
      payload.claim_id = -1;
      payload.claim_detail_id = -1;
    }
    state.ground_claims.push(payload);
  },

  deleteGroundClaim (state, payload) {

    for(var i=0; i < state.ground_claims.length; i++){
      if(state.ground_claims[i].claim_id === payload.id){

        var ground_claim = state.ground_claims.splice(i,1);
        if(ground_claim[0].claim_id > 0){
          state.ground_claims_for_delete.push(ground_claim[0]);
        }
      }
    }
  },

  resetDeleteGroundClaims (state, payload) {

    state.ground_claims_for_delete = [];
  },

  addComment (state, payload) {

    state.comments.push(payload);
  },
}

// actions
const  actions = {

  loadStoreData(context, payload) {

    // payload.caller: Name of the calling component,
    // payload.call_object: Object specifying the view/table to be loaded, plus additional variables that
    //                      customise the database call, i.e. filtering, ordering, ...
    // payload.data_array_name: Name of the array in the store to save the data
    return new Promise(function (resolve, reject) {
      Vue.prototype.$dbCon.requestViewData("memberInfo on behalf of " + payload.caller, payload.call_object)
        .then(response => {

          context.commit("setDataArray",
            {
              array_name: payload.data_array_name,
              array_data: response
            });
          resolve(response);

        })
        .catch(error => {
          reject(error.message);
        });
    })
  },

  loadReports (context, payload) {

    return new Promise(function (resolve, reject) {

      Vue.prototype.$dbCon.requestViewData("missionStore on behalf of " + payload.caller,
        {
          view: "mission_report_nav_list",
          mission_id: payload.mission_id,
          depl_unit_id: payload.depl_unit_id
        })
        .then(response => {

          context.commit("setReports", response);
          resolve(response.length > 0);

        })
        .catch(error => {

          reject(error.message);
        })
    })
  },

  loadReport (context, payload) {

    return new Promise( async function (resolve, reject) {


      await context.dispatch("loadUnits", payload);
      // report_id = -1 for new reports. No need to load the data from the backend.
      if(payload.report_id > 0){

        await context.dispatch("loadReportInfo", payload);
        if (context.state.report.faction == 1) {

          payload.detail_view = "report_detail_lw";
          payload.aerial_claim_view = "claim_lw_info";

        } else if (context.state.report.faction == 2) {

          payload.detail_view = "report_detail_raf";
          payload.aerial_claim_view = "claim_raf_info";

        } else if (context.state.report.faction == 3) {

          payload.aerial_claim_view = "claim_vvs_info";

        }
        await context.dispatch("loadReportDetails", payload);
        await context.dispatch("loadAerialClaims", payload);
        await context.dispatch("loadGroundClaims", payload);
        await context.dispatch("loadComments", payload);
      }
      await context.dispatch("loadAssets", payload);
      await context.dispatch("loadMembers", payload);

      resolve();
    })

  },

  loadReportInfo (context, payload) {

    return new Promise(function (resolve, reject) {

      Vue.prototype.$dbCon.requestViewData("missionStore on behalf of " + payload.caller,
      {view: "report_info", report_id: payload.report_id})
        .then(response => {

          context.commit("setReport", response[0]);
          resolve();

        })
        .catch(error => {

          reject(error.message);
        })
    })

  },

  loadReportDetails (context, payload) {

    return new Promise(function (resolve, reject) {

      Vue.prototype.$dbCon.requestViewData("missionStore on behalf of " + payload.caller,
        {view: payload.detail_view, report_id: payload.report_id})
        .then(response => {

          context.commit("setReportDetails", response[0]);
          resolve();

        })
        .catch(error => {

          reject(error.message);
        })
    })

  },

  loadAerialClaims (context, payload) {

    return new Promise(function (resolve, reject) {

      Vue.prototype.$dbCon.requestViewData("missionStore on behalf of " + payload.caller,
        {view: payload.aerial_claim_view, report_id: payload.report_id})
        .then(response => {

          context.commit("setAerialClaims", response);
          resolve();

        })
        .catch(error => {

          reject(error.message);
        })
    })

  },

  loadGroundClaims (context, payload) {

    return new Promise(function (resolve, reject) {

      Vue.prototype.$dbCon.requestViewData("missionStore on behalf of " + payload.caller,
        {view: "claim_ground_info", report_id: payload.report_id})
        .then(response => {

          context.commit("setGroundClaims", response);
          resolve();

        })
        .catch(error => {

          reject(error.message);
        })
    })

  },

  loadComments (context, payload) {

    return new Promise(function (resolve, reject) {

      Vue.prototype.$dbCon.requestViewData("missionStore on behalf of " + payload.caller,
        {view: "comment_info", report_id: payload.report_id})
        .then(response => {

          context.commit("setComments", response);
          resolve();

        })
        .catch(error => {

          reject(error.message);
        })

    })
  },

  loadUnits (context, payload) {

    return new Promise(function (resolve, reject) {

      Vue.prototype.$dbCon.requestViewData("missionStore on behalf of " + payload.caller,
        {view: "campaign_info_unit", campaign_id: payload.campaign_id})
        .then(response => {

          context.commit("setUnits", response);
          resolve();

        })
        .catch(error => {

          reject(error.message);
        })
    })

  },

  loadAssets (context, payload) {

    return new Promise(function (resolve, reject) {

      Vue.prototype.$dbCon.requestViewData("missionStore on behalf of " + payload.caller,
        {view: "asset_subtree"})
        .then(response => {

          context.commit("setAssets", response);
          resolve();

        })
        .catch(error => {

          reject(error.message);
        })
    })

  },

  loadMembers (context, payload) {

    return new Promise(function (resolve, reject) {

      Vue.prototype.$dbCon.requestViewData("missionStore on behalf of " + payload.caller,
        {view: "member_info_with_last_status"})
        .then(response => {

          context.commit("setMembers", response);
          resolve();

        })
        .catch(error => {

          reject(error.message);
        })
    })
  },

  sendReport (context, payload) {

    context.commit("logger/addEntry", {message: "Sending report"}, {root: true});
    return new Promise(async function (resolve, reject) {


      var now = new Date();
      var year = now.getFullYear();
      var month = now.getMonth() + 1;
      var day = now.getDate();
      var response;
      var response_detail;

      //Cloning report from state for final adjustments
      var report = JSON.parse(JSON.stringify(context.state.report));
      //Cloning report_details from state for final adjustments
      if(context.state.report_details !== undefined){

        var report_details = JSON.parse(JSON.stringify(context.state.report_details));
      }

      try {

        // ------------------------------------------------------------------------
        // create new character in database
        // ------------------------------------------------------------------------
        if(report.character_id < 0){

           response = await Vue.prototype.$dbCon.insertUpdateData("missionStore on behalf of "+payload.caller,
            {
              table: "career_character",
              payload: [
                {
                  id: -1,
                  personified_by: report.member_id,
                  first_name: report.first_name,
                  last_name: report.last_name
                }]
            });

           // console.log("Character: "+response.message);
          context.commit("logger/addEntry", {message: "Character: "+response.message}, {root: true});
           // update character_id with id from created character
           report.character_id = response.insert_id[0].new_id;
        }

        // ------------------------------------------------------------------------
        // sending report to database
        // ------------------------------------------------------------------------
        report.id = report.report_id;
        report.date_submitted = year+"-"+month+"-"+day;
        report.accepted = 0;
        report.deployed_unit_id = report.depl_unit_id;
        report.accepted_by = null;

        response = await Vue.prototype.$dbCon.insertUpdateData("missionStore on behalf of "+payload.caller,
          {
            table: "report",
            payload: [report]
          })

        // console.log("Report: "+response.message);
        context.commit("logger/addEntry", {message: "Report: "+response.message}, {root: true});

        // update report_id in state
        if(report.id < 0){

          context.commit('updateReportValue',
            {
              array_name: "report",
              update_column_name: "report_id",
              update_column_value: response.insert_id[0].new_id
            });

          context.commit('updateClaimValue',
            {
              array_name: "aerial_claims",
              id_column_name: "report_id",
              id_column_value: response.insert_id[0].old_id,
              update_column_name: "report_id",
              update_column_value: response.insert_id[0].new_id
            });

          context.commit('updateClaimValue',
            {
              array_name: "ground_claims",
              id_column_name: "report_id",
              id_column_value: response.insert_id[0].old_id,
              update_column_name: "report_id",
              update_column_value: response.insert_id[0].new_id
            });
        }

        if(context.state.report_details !== undefined && report_details.report_id < 0){

          report_details.report_id = response.insert_id[0].new_id;
          // update report_detail.report_id in state
          context.commit('updateReportValue',
            {
              array_name: "report_details",
              update_column_name: "report_id",
              update_column_value: response.insert_id[0].new_id
            });
        }

        // ------------------------------------------------------------------------
        // sending report_detail to database
        // ------------------------------------------------------------------------

        if (report.faction == 1) {

          // ------------------------------------------------------------------------
          // Sending LW specific details
          // ------------------------------------------------------------------------
          response_detail = await Vue.prototype.$dbCon.insertUpdateData("missionStore on behalf of "+payload.caller,
            {
              table: "report_detail_lw",
              payload: [report_details]
            });
          // console.log(" Report detail LW: "+response.message);
          context.commit("logger/addEntry", {message: "Report detail LW: "+response.message}, {root: true});


        } else if (report.faction == 2) {

          // ------------------------------------------------------------------------
          // Sending RAF specific details
          // ------------------------------------------------------------------------
          response_detail = await Vue.prototype.$dbCon.insertUpdateData("missionStore on behalf of "+payload.caller,
            {
              table: "report_detail_raf",
              payload: [report_details]
            });
          // console.log(" Report detail RAF: "+response.message);
          context.commit("logger/addEntry", {message: "Report detail RAF: "+response.message}, {root: true});


        } else if (report.faction == 3) {


        }

        if(context.state.report_details !== undefined && report_details.id < 0) {

          // update report_detail.id in state
          context.commit('updateReportValue',
            {
              array_name: "report_details",
              update_column_name: "id",
              update_column_value: response_detail.insert_id[0].new_id
            });
        }

        // ------------------------------------------------------------------------
        // sending claims to database
        // ------------------------------------------------------------------------
        if(context.state.aerial_claims.length > 0){

          await context.dispatch("sendAerialClaims", payload);
        }

        if(context.state.ground_claims.length > 0){

          await context.dispatch("sendGroundClaims", payload);
        }

        // ------------------------------------------------------------------------
        // deleting claims in database
        // ------------------------------------------------------------------------
        if(context.state.aerial_claims_for_delete.length > 0){

          await context.dispatch("deleteAerialClaims", payload);
        }

        if(context.state.ground_claims_for_delete.length > 0){

          await context.dispatch("deleteGroundClaims", payload);
        }

        // ------------------------------------------------------------------------
        // reload reports into missionStore
        // ------------------------------------------------------------------------
        await context.dispatch("loadReports",
          {
            caller: "missionStore - Report submit",
            mission_id: context.state.report.mission_id,
            depl_unit_id: context.state.report.depl_unit_id,
          });
        alert("Report sent, check logger for further info.")
        resolve();

      } catch (e) {

        console.log(JSON.stringify(e))
        reject(e);
      }
    })
  },

  sendAerialClaims (context, payload) {

    return new Promise(async function (resolve, reject) {

      try {

        // ------------------------------------------------------------------------
        // sending aerial claims to database
        // ------------------------------------------------------------------------
        var aerial_claim_general = [];
        var aerial_claim_specific = [];
        var claim_general_response;
        var claim_specific_response;

        //Cloning aerial claims from state for final adjustments
        var aerial_claims = JSON.parse(JSON.stringify(context.state.aerial_claims));

        // ------------------------------------------------------------------------
        // Sending general information
        // ------------------------------------------------------------------------

        for (var i = 0; i < aerial_claims.length; i++) {

          aerial_claim_general.push({
            id: aerial_claims[i].claim_id,
            report_id: aerial_claims[i].report_id,
            description: aerial_claims[i].description,
            accepted: 0,
            asset_id: aerial_claims[i].asset_id,
            accepted_by: null
          });
        }

        claim_general_response = await Vue.prototype.$dbCon.insertUpdateData("missionStore on behalf of " + payload.caller,
          {
            table: "claim",
            payload: aerial_claim_general
          });
        // console.log("Claim: "+claim_general_response.message);

        // update claim_id in state
        for(var i = 0; i < claim_general_response.insert_id.length; i++){

          if(claim_general_response.insert_id[i].old_id < 0){

            context.commit('updateClaimValue',
              {
                array_name: "aerial_claims",
                id_column_name: "claim_id",
                id_column_value: claim_general_response.insert_id[i].old_id,
                update_column_name: "claim_id",
                update_column_value: claim_general_response.insert_id[i].new_id
              });
          }
        }
        //Cloning aerial claims again from state for final adjustments
        var aerial_claims = JSON.parse(JSON.stringify(context.state.aerial_claims));

        if (context.state.report.faction == 1) {

          // ------------------------------------------------------------------------
          // Sending LW claims
          // ------------------------------------------------------------------------

          for (var i = 0; i < aerial_claims.length; i++) {

            aerial_claim_specific.push({
              id: aerial_claims[i].claim_detail_id,
              claim_id: aerial_claims[i].claim_id,
              claim_time: aerial_claims[i].claim_time,
              place: aerial_claims[i].place,
              opponent: aerial_claims[i].opponent,
              fate_of_crew: aerial_claims[i].fate_of_crew,
              type_of_destruction: aerial_claims[i].type_of_destruction,
              type_of_impact: aerial_claims[i].type_of_impact,
              confirmed: 0,
              witness: aerial_claims[i].witness_id
            });

            if(aerial_claims[i].witness_id !== null) {

              var message = "[url=http://aircombatgroup.co.uk/acg-pam-2/#"
                +payload.path
                +"]This is an automatic created message. "
                +context.state.report.callsign
                +" appealed to you as a witness for the claim in mission "
                +context.state.report.mission_id
                +"."
                +"[/url]";

              Vue.prototype.$dbCon.sendForumPM("missionStore on behalf of "+payload.caller,
                {
                  sender: context.state.report.member_id,
                  receiver: aerial_claims[i].witness_id,
                  message: message,
                  subject: "Comment received"
                })
                .then(response => {

                  console.log(JSON.stringify(response));
                })
            }
          }

          claim_specific_response = await Vue.prototype.$dbCon.insertUpdateData("missionStore on behalf of " + payload.caller,
            {
              table: "claim_lw",
              payload: aerial_claim_specific
            });
          // console.log("Claim spec: "+claim_specific_response.message);

        } else if (context.state.report.faction == 2) {

          // ------------------------------------------------------------------------
          // Sending RAF claims
          // ------------------------------------------------------------------------

          for (var i = 0; i < aerial_claims.length; i++) {

            aerial_claim_specific.push({
              id: aerial_claims[i].claim_detail_id,
              claim_id: aerial_claims[i].claim_id,
              enemy_status: aerial_claims[i].enemy_status,
              shared: aerial_claims[i].shared,
            });

          }

          claim_specific_response = await Vue.prototype.$dbCon.insertUpdateData("missionStore on behalf of " + payload.caller,
            {
              table: "claim_raf",
              payload: aerial_claim_specific
            });
          // console.log("Claim spec: "+claim_specific_response.message);

        } else if (context.state.report.faction == 3) {

          // ------------------------------------------------------------------------
          // Sending VVS claims
          // ------------------------------------------------------------------------

          for(var i = 0; i < aerial_claims.length; i++){

            aerial_claim_specific.push({
              id: aerial_claims[i].claim_detail_id,
              claim_id: aerial_claims[i].claim_id,
              claim_time: aerial_claims[i].claim_time,
              place: aerial_claims[i].place,
              group_claim: aerial_claims[i].group_claim,
              confirmed: 0,
              witness: aerial_claims[i].witness_id,
            });

            if(aerial_claims[i].witness_id !== null) {

              var message = "[url=http://aircombatgroup.co.uk/acg-pam-2/#"
                +payload.path
                +"]This is an automatic created message. "
                +context.state.report.callsign
                +" appealed to you as a witness for the claim in mission "
                +context.state.report.mission_id
                +"."
                +"[/url]";

              Vue.prototype.$dbCon.sendForumPM("missionStore on behalf of "+payload.caller,
                {
                  sender: context.state.report.member_id,
                  receiver: aerial_claims[i].witness_id,
                  message: message,
                  subject: "Comment received"
                })
                .then(response => {

                  console.log(JSON.stringify(response));
                })
            }

          }

          claim_specific_response = await Vue.prototype.$dbCon.insertUpdateData("missionStore on behalf of "+payload.caller,
            {
              table: "claim_vvs",
              payload: aerial_claim_specific
            });
          // console.log("Claim spec: "+claim_specific_response.message);


        }

        context.commit("logger/addEntry",
          {message: "Claim: "+claim_general_response.message+" Claim detail: "+claim_specific_response.message},
          {root: true});

        for(var i = 0; i < claim_specific_response.insert_id.length; i++){

          if(claim_specific_response.insert_id[i].old_id < 0){

            context.commit('updateClaimValue',
              {
                array_name: "aerial_claims",
                id_column_name: "claim_detail_id",
                id_column_value: claim_specific_response.insert_id[i].old_id,
                update_column_name: "claim_detail_id",
                update_column_value: claim_specific_response.insert_id[i].new_id
              });
          }
        }

        resolve();

      } catch (e) {

        console.log(JSON.stringify(e))
        reject(e);
      }
    })
  },

  sendGroundClaims(context, payload) {

    return new Promise(async function (resolve, reject) {

      try {

        // ------------------------------------------------------------------------
        // Sending ground claims
        // ------------------------------------------------------------------------
        var ground_claim_general = [];
        var ground_claim_specific = [];
        var claim_general_response;
        var claim_specific_response;

        //Cloning ground claims from state for final adjustments
        var ground_claims = JSON.parse(JSON.stringify(context.state.ground_claims));

        for(var i = 0; i < ground_claims.length; i++){

          ground_claim_general.push({
            id: ground_claims[i].claim_id,
            report_id: ground_claims[i].report_id,
            description: ground_claims[i].description,
            accepted: 0,
            asset_id: ground_claims[i].asset_id,
            accepted_by: null
          });

        }

        claim_general_response = await Vue.prototype.$dbCon.insertUpdateData("missionStore on behalf of "+payload.caller,
          {
            table: "claim",
            payload: ground_claim_general
          });

        // update claim_id in state
        for(var i = 0; i < claim_general_response.insert_id.length; i++){

          if(claim_general_response.insert_id[i].old_id < 0){

            context.commit('updateClaimValue',
              {
                array_name: "ground_claims",
                id_column_name: "claim_id",
                id_column_value: claim_general_response.insert_id[i].old_id,
                update_column_name: "claim_id",
                update_column_value: claim_general_response.insert_id[i].new_id
              });
          }
        }

        //Cloning ground claims from state for final adjustments
        var ground_claims = JSON.parse(JSON.stringify(context.state.ground_claims));

        for(var i = 0; i < ground_claims.length; i++){

          ground_claim_specific.push({
            id: ground_claims[i].claim_detail_id,
            claim_id: ground_claims[i].claim_id,
            amount: ground_claims[i].amount,
          });

        }

        claim_specific_response = await Vue.prototype.$dbCon.insertUpdateData("missionStore on behalf of "+payload.caller,
          {
            table: "claim_ground",
            payload: ground_claim_specific
          });
        // console.log("Claim spec: "+claim_specific_response.message);
        context.commit("logger/addEntry",
          {message: "Claim: "+claim_general_response.message+" Claim detail: "+claim_specific_response.message},
          {root: true});

        for(var i = 0; i < claim_specific_response.insert_id.length; i++){

          if(claim_specific_response.insert_id[i].old_id < 0){

            context.commit('updateClaimValue',
              {
                array_name: "ground_claims",
                id_column_name: "claim_detail_id",
                id_column_value: claim_specific_response.insert_id[i].old_id,
                update_column_name: "claim_detail_id",
                update_column_value: claim_specific_response.insert_id[i].new_id
              });
          }
        }

        resolve();

      } catch (e) {

        console.log(JSON.stringify(e))
        reject(e);
      }
    })
  },

  deleteAerialClaims(context, payload) {

    return new Promise(async function (resolve, reject) {

      try {

        var claim_ids = [];
        var claim_detail_ids = [];
        var claim_response;
        var claim_detail_response;

        for (var i = 0; i < context.state.aerial_claims_for_delete.length; i++){

          claim_ids.push({id: context.state.aerial_claims_for_delete[i].claim_id});
          claim_detail_ids.push({id: context.state.aerial_claims_for_delete[i].claim_detail_id});
        }

        claim_response = await Vue.prototype.$dbCon.deleteData("missionStore on behalf of "+payload.caller,
          {table:"claim", payload: claim_ids});

        if (context.state.report.faction == 1) {

          // ------------------------------------------------------------------------
          // Deleting LW claims
          // ------------------------------------------------------------------------
          claim_detail_response = await Vue.prototype.$dbCon.deleteData("missionStore on behalf of "+payload.caller,
            {table:"claim_lw", payload: claim_detail_ids});

        } else if (context.state.report.faction == 2) {

          // ------------------------------------------------------------------------
          // Deleting RAF claims
          // ------------------------------------------------------------------------
          claim_detail_response = await Vue.prototype.$dbCon.deleteData("missionStore on behalf of "+payload.caller,
            {table:"claim_raf", payload: claim_detail_ids});

        } else if (context.state.report.faction == 3) {

          // ------------------------------------------------------------------------
          // Deleting VVS claims
          // ------------------------------------------------------------------------
          claim_detail_response = await Vue.prototype.$dbCon.deleteData("missionStore on behalf of "+payload.caller,
            {table:"claim_vvs", payload: claim_detail_ids});
        }

        // console.log("Claim: "+claim_response.message);
        // console.log("Claim detail: "+claim_detail_response.message);
        context.commit("logger/addEntry",
          {message: "Claim: "+claim_response.message+" Claim detail: "+claim_detail_response.message},
          {root: true});

        context.commit('resetDeleteAerialClaims')
        resolve();

      } catch (e) {

        console.log(JSON.stringify(e))
        reject(e);
      }
    })
  },

  deleteGroundClaims(context, payload) {

    return new Promise(async function (resolve, reject) {

      try {

        var claim_ids = [];
        var claim_detail_ids = [];
        var claim_response;
        var claim_detail_response;

        for (var i = 0; i < context.state.ground_claims_for_delete.length; i++){

          claim_ids.push({id: context.state.ground_claims_for_delete[i].claim_id});
          claim_detail_ids.push({id: context.state.ground_claims_for_delete[i].claim_detail_id});
        }

        claim_response = await Vue.prototype.$dbCon.deleteData("missionStore on behalf of "+payload.caller,
          {table:"claim", payload: claim_ids});
        claim_detail_response = await Vue.prototype.$dbCon.deleteData("missionStore on behalf of "+payload.caller,
          {table:"claim_ground", payload: claim_detail_ids});

        // console.log("Claim: "+claim_response.message);
        // console.log("Claim detail: "+claim_detail_response.message);
        context.commit("logger/addEntry",
          {message: "Claim: "+claim_response.message+" Claim detail: "+claim_detail_response.message},
          {root: true});


        context.commit('resetDeleteGroundClaims')
        resolve();

      } catch (e) {

        console.log(JSON.stringify(e))
        reject(e);
      }
    })
  },

  sendComment(context, payload) {

    return new Promise(function(resolve, reject) {

      var comment = {
        id: -1,
        member_id: payload.member_id,
        report_id: context.state.report.report_id,
        comment_date: payload.comment_date,
        comment_text: payload.comment_text
      };

      Vue.prototype.$dbCon.insertUpdateData("missionStore on behalf of "+payload.caller,
        {
          table: "comment",
          payload: [comment]
        })
        .then(response => {

          var message =
            "[url=http://aircombatgroup.co.uk/acg-pam-2/#"
            +payload.path
            +"]This is an automatic created message. Your report for mission "
            +context.state.report.mission_id
            +" from "
            +context.state.report.date_submitted
            +" was commented."
            +"[/url]";

          Vue.prototype.$dbCon.sendForumPM("missionStore on behalf of "+payload.caller,
            {
              sender: payload.member_id,
              receiver: context.state.report.member_id,
              message: message,
              subject: "Comment received"
            })
            .then(response => {

              console.log(JSON.stringify(response));
            })

          context.dispatch("loadComments",
            {caller: "Comment", report_id: context.state.report.report_id});

          resolve();
        })
        .catch(error => {

          console.log(error.message);
          reject();
        })
    })

  },

  deleteComment(context, payload) {

    Vue.prototype.$dbCon.deleteData("missionStore on behalf of "+payload.caller,
      {table:"comment", payload: [{id: payload.id}]})
      .then(response => {

        context.dispatch("loadComments",
          {caller: "comment", report_id: context.state.report.report_id});
      })
      .catch(error => {

        console.log(error.message);
      })
  },

  acceptRejectReport(context, payload) {

    var accept_parcel = {
      id: context.state.report.report_id,
      accepted: context.state.report.accepted ? 0 : 1,
      accepted_by: (context.state.report.accepted) ? null : payload.member_id
    };
    Vue.prototype.$dbCon.insertUpdateData("missionStore on behalf of "+payload.caller,
      {
        table: "report",
        payload: [accept_parcel]
      })
      .then(response => {

        console.log("Report approval/rejection: "+response.message);

        context.commit('updateReportValue',
          {
            array_name: "report",
            update_column_name: "accepted",
            update_column_value: accept_parcel.accepted
          });
        context.commit('updateReportValue',
          {
            array_name: "report",
            update_column_name: "accepted_by",
            update_column_value: accept_parcel.accepted_by
          });

        context.dispatch("loadReports",
          {
            caller: "missionStore - Report Accept/Reject",
            mission_id: context.state.report.mission_id,
            depl_unit_id: context.state.report.depl_unit_id,
          });

      })
      .catch(error => {

        console.log(error.message);
      });
    if(accept_parcel.accepted){
      Vue.prototype.$dbCon.checkDecorations("missionStore on behalf of "+payload.caller,
        {
          character_id: context.state.report.character_id,
          faction: context.state.report.faction
        });
    }
  },

  acceptRejectClaim(context, payload) {

    var accept_parcel = {
      id: payload.id,
      accepted: payload.accepted,
      accepted_by: payload.member_id
    }
    Vue.prototype.$dbCon.insertUpdateData("missionStore on behalf of "+payload.caller,
      {
        table: "claim",
        payload: [accept_parcel]
      })
      .then(response => {

        console.log("Report approval/rejection: "+response.message);

        context.commit('updateClaimValue',
          {
            array_name: payload.claim_table,
            id_column_name: "claim_id",
            id_column_value: payload.id,
            update_column_name: "accepted",
            update_column_value: payload.accepted
          });
        context.commit('updateClaimValue',
          {
            array_name: payload.claim_table,
            id_column_name: "claim_id",
            id_column_value: payload.id,
            update_column_name: "accepted_by",
            update_column_value: payload.member_id
          });

      })
      .catch(error => {

        console.log(error.message);
      })
  },

  confirmClaim(context, payload) {

    var confirm_parcel = {
      id: payload.id,
      confirmed: payload.confirmed,
    }

    var claim_table;
    if(context.state.report.faction === 1) {

      claim_table = "claim_lw";
    } else if(context.state.report.faction === 3) {

      claim_table = "claim_vvs";
    }

    Vue.prototype.$dbCon.insertUpdateData("missionStore on behalf of "+payload.caller,
      {
        table: claim_table,
        payload: [confirm_parcel]
      })
      .then(response => {

        console.log("Report confirmation: "+response.message);

        context.commit('updateClaimValue',
          {
            array_name: "aerial_claims",
            id_column_name: "claim_detail_id",
            id_column_value: payload.id,
            update_column_name: "confirmed",
            update_column_value: payload.confirmed
          });
      })
      .catch(error => {

        console.log(error.message);
      })
  }

}


export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}
