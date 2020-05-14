import Vue from 'vue'


// initial state
const state = {

  campaigns: [],
  missions: [],
  acg_units: [],
  hist_units: [],
  depl_units: [],
  acg_members: [],
  characters: [],
  assets: []
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

}


export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}
