// initial state
import Vue from "vue"

const state = {

  acg_units: [],
  hist_units: [],
  campaign_units: [],
  promotions: [],
  assets: [],
  r_assets: [],
  member_info: [],
  member_info_current: [],
  member_r_assets: [],
  promotion_log: [],
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

  filterByString: (state) => (table, keyName, searchValue) => {

    return state[table].filter(
      function (item) {
        return (searchValue === "" || item[keyName].toLowerCase().includes(searchValue.toLowerCase()));
      });
  },

  nestedData: (state) => (table) => {

    return Vue.prototype.$dbCon.nestData(state[table]);
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

  addToDataArray (state, payload) {
    // Needed values:
    // array_name: Name of the array to add to
    // array_data: Date to store add to the array
    state[payload.array_name] = state[payload.array_name].concat(payload.array_data);

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

  loadStoreDataAdd(context, payload) {

    // payload.caller: Name of the calling component,
    // payload.call_object: Object specifying the view/table to be loaded, plus additional variables that
    //                      customise the database call, i.e. filtering, ordering, ...
    // payload.data_array_name: Name of the array in the store to save the data
    return new Promise(function (resolve, reject) {
      Vue.prototype.$dbCon.requestViewData("unitAdmin on behalf of " + payload.caller, payload.call_object)
        .then(response => {

          context.commit("addToDataArray",
            {
              array_name: payload.data_array_name,
              array_data: response
            });
          resolve(response);

        })
        .catch(error => {
          reject(error);
        });
    })
  },

  loadUnitInfo(context, payload) {

    return new Promise( async function (resolve, reject) {

      await context.dispatch('loadStoreData',
        {
          caller: payload.caller,
          call_object: {
            view: "campaign_info_unit",
            // acg_unit_id: payload.acg_unit_id
          },
          data_array_name: "campaign_units"

        }
      ).catch(error => {
        reject(error);
      });

      await context.dispatch('loadStoreData',
        {
          caller: payload.caller,
          call_object: {
            view: "campaign_unit_member_info",
            acg_unit_id: payload.acg_unit_id
          },
          data_array_name: "member_info"

        }
      ).catch(error => {
        reject(error);
      });

      await context.dispatch('loadStoreData',
        {
          caller: payload.caller,
          call_object: {
            view: "campaign_unit_member_info_current",
            acg_unit_id: payload.acg_unit_id
          },
          data_array_name: "member_info_current"

        }
      ).catch(error => {
        reject(error.message);
      });

      resolve();


    })

  },

  loadHUnits(context, payload) {

    return new Promise( async function (resolve, reject) {

      await context.dispatch('loadStoreData',
        {
          caller: payload.caller,
          call_object: {
            view: "hist_unit_info",
          },
          data_array_name: "hist_units"

        }
      ).then(resp => {

        context.commit('addToDataArray',
          {
            array_name: "hist_units",
            array_data: {
              id: -1,
              name: "NEW UNIT",
              code: "",
              faction: 0,
              type: 1,
              description: "",
              image: ""
            }
          });
      }).catch(error => {
        reject(error);
      });

      resolve();

    })



  },

  sendHUnits(context, payload) {

    return new Promise(async function(resolve, reject) {

      try {

        //Cloning_h_units_array
        let hist_units_send_array = [];
        let formData;
        context.commit("logger/addEntry", {message: "Saving historical units"}, {root: true});
        context.commit("logger/addEntry", {message: "Sending historical unit emblems"}, {root: true});
        for(let i=0; i<context.state.hist_units.length; i++){

          formData = context.state.hist_units[i].image;
          if(formData instanceof FormData){

            await Vue.prototype.$dbCon.uploadImageFile("ImageUpload on behalf of "+payload.caller, formData)
              .then(response => {
                context.commit("logger/addEntry", {message: response.message}, {root: true});
                formData = response.path;
              })
              .catch(error => {
                context.commit("logger/addEntry", {message: error.error}, {root: true});
              })
          }

          hist_units_send_array.push(
            {
              id: context.state.hist_units[i].id,
              name: context.state.hist_units[i].name,
              code: context.state.hist_units[i].code,
              faction: context.state.hist_units[i].faction,
              type: context.state.hist_units[i].type,
              description: context.state.hist_units[i].description,
              image: formData
            }
          );
        }

        let response = await Vue.prototype.$dbCon.insertUpdateData("unitAdmin on behalf of "+payload.caller,
          {
            table: "hist_unit",
            payload: hist_units_send_array
          });
        context.commit("logger/addEntry", {message: "Hist unit: "+ response.message}, {root: true});

        resolve();
      } catch (e) {

        console.log(JSON.stringify(e))
        reject(e);

      }

    })
  },

  sendMemberRosterAssets(context, payload) {

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
