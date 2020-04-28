import Vue from 'vue'


// initial state
const state = {

  assets: [],
  hist_units: [],
  r_assets: [],
  r_assets_for_delete: []
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

  // setAssets (state, payload) {
  //   state.assets = payload;
  // },

  addRosterAsset (state, payload) {
    if(state.r_assets.length > 0) {
      // find minimum id value in missions
      var min_id = state.r_assets.reduce((min, r_assets) => Math.min(min, r_assets.id, 0), state.r_assets[0].id);
      payload.id = min_id - 1;
    } else {
      payload.id = -1;
    }
    state.r_assets.push(payload);
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

  deleteValue (state, payload) {

    // Needed values:
    // array_name: Name of the array to delete from
    // id_column_name: Name of the property to identify the object to be deleted
    // id_column_value: Value of the property to identify the object to be deleted
    // array_name_delete: Name of the array to store object for deletion
    //
    // !Only objects with id_column_value > 0 will be moved to array_name_delete

    for(var i=0; i < state[payload.array_name].length; i++){
      if(state[payload.array_name][i][payload.id_column_name] === payload.id_column_value){

        var delete_item = state[payload.array_name].splice(i,1);
        if(payload.id_column_value > 0){
          state[payload.array_name_delete].push(delete_item[0]);
        }
      }
    }
  },

  resetTable (state, payload) {
    // Needed values:
    // array_name: Name of the array reset

    state[payload.array_name] = [];
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
      Vue.prototype.$dbCon.requestViewData("unitInfo on behalf of " + payload.caller, payload.call_object)
        .then(response => {

          context.commit("setDataArray",
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

  sendRAssets(context, payload) {

    return new Promise(async function(resolve, reject) {

      try {

        //Cloning r_object array
        let r_assets_send_array = [];
        let formData;
        context.commit("logger/addEntry", {message: "Saving roster assets"}, {root: true});
        context.commit("logger/addEntry", {message: "Sending roster images"}, {root: true});
        for(let i=0; i<context.state.r_assets.length; i++){

          formData = context.state.r_assets[i].image;
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

          r_assets_send_array.push(
            {
              id: context.state.r_assets[i].id,
              markings: context.state.r_assets[i].markings,
              asset_id: context.state.r_assets[i].asset_id,
              hist_unit_id: context.state.r_assets[i].hist_unit_id,
              image: formData,

            }
          );
        }

        let response = await Vue.prototype.$dbCon.insertUpdateData("assetAdmin on behalf of "+payload.caller,
          {
            table: "roster_asset",
            payload: r_assets_send_array
          });
        context.commit("logger/addEntry", {message: "Roster asset: "+ response.message}, {root: true});

        response = await Vue.prototype.$dbCon.deleteData("assetAdmin on behalf of "+payload.caller,
          {table:"roster_asset", payload: context.state.r_assets_for_delete});
        context.commit("logger/addEntry", {message: "Roster asset: "+ response.message}, {root: true});

        context.commit('resetTable', 'r_assets_for_delete');

        resolve();

      } catch (e) {

        console.log(JSON.stringify(e))
        reject(e);
      }


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
