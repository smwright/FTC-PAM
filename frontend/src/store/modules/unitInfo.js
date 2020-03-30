// initial state
import Vue from "vue"

const state = {

  acg_units: [],
  hist_units: []

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

  filterByString: (state) => (table, keyName, searchValue) => {

    return state[table].filter(
      function (item) {
        return (searchValue === "" || item[keyName].toLowerCase().includes(searchValue.toLowerCase()));
      });
  }

}

// mutations
const mutations = {

  setDataArray (state, payload) {

    // Needed values:
    // array_name: Name of the array to set
    // array_data: Date to store in the array
    state[payload.array_name] = payload.array_data;
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

}

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}
