// initial state
import Vue from "vue"

const state = {

  // acg_units: [],
  // decorations: [],
  assets: [],
  r_assets: [],
  campaign_units: [],
  member_info: [],
  member_r_assets: [],
  rank_lookup: [],
  mission_unit_active_members: [],
  mission_unit_attending_members_count: []


}

// getters
const getters = {

  findByKey: (state) => (table, keyName, keyValue) => {

    return state[table].find(
      function (item) {
        return item[keyName] == keyValue;
      });
  },

  filterByKey: (state) => (table, keyName, keyValue) => {

    return state[table].filter(
      function (item) {
        return item[keyName] == keyValue;
      });
  },

  filterByKeys: (state) => (table, filterInput) => {

    let filterArray = JSON.parse(JSON.stringify(state[table]));
    let filterEntries = Object.entries(filterInput);
    for(let i=0; i<filterEntries.length; i++){
      filterArray = filterArray.filter(
        function (item) {
          return item[filterEntries[i][0]] == filterEntries[i][1];
        });
    }
    return filterArray;

  },

}

// mutations
const mutations = {

  setDataArray (state, payload) {

    // Needed values:
    // array_name: Name of the array to set
    // array_data: Date to store in the array
    state[payload.array_name] = payload.array_data;
  },

  addToArray (state, payload) {
    // Needed values:
    // array_name: Name of the array to add to
    // array_data: Data to add to the array. Has to conform to the structure of the array to add to.
    let add_array = state[payload.array_name];
    let add_data = payload.array_data
    if(add_array.length > 0) {
      // find minimum id value in array
      var min_id = add_array.reduce((min, add_array) => Math.min(min, add_array.id, 0), add_array[0].id);
      add_data.id = min_id - 1;
    } else {
      add_data.id = -1;
    }
    add_array.push(add_data);
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
}

// actions
const  actions = {

  loadStoreData(context, payload) {

    // payload.caller: Name of the calling component,
    // payload.call_object: Object specifying the view/table to be loaded, plus additional variables that
    //                      customise the database call, i.e. filtering, ordering, ...
    // payload.data_array_name: Name of the array in the store to save the data
    return new Promise(function (resolve, reject) {
      Vue.prototype.$dbCon.requestViewData("unitAdmin on behalf of " + payload.caller, payload.call_object)
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

  sendMemberRosterAssets(context, payload) {

    console.log("HERE");
    return new Promise(async function(resolve, reject) {

      try {

        let send_array = context.state.member_r_assets.filter(
          function(item){
            return item.roster_asset_id !== null;
          });
        console.log(JSON.stringify(send_array));
        let delete_array = context.state.member_r_assets.filter(
          function(item){
            return item.roster_asset_id === null & item.id > 0;
          });

        if(send_array.length > 0){
          context.commit("logger/addEntry", {message: "Saving member roster assets"}, {root: true});
          let response = await Vue.prototype.$dbCon.insertUpdateData("unitAdmin on behalf of "+payload.caller,
            {
              table: "member_roster_asset",
              payload: send_array
            });
          context.commit("logger/addEntry", {message: "Member roster asset: "+ response.message}, {root: true});
        }
        if(delete_array.length > 0){
          let response = await Vue.prototype.$dbCon.deleteData("unitAdmin on behalf of "+payload.caller,
            {table:"member_roster_asset", payload: delete_array});
          context.commit("logger/addEntry", {message: "Member roster: "+ response.message}, {root: true});

        }

        resolve();

      } catch (e) {

        console.log(JSON.stringify(e))
        reject(e);
      }

    });
  }

}

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}
