// initial state
import Vue from "vue"

const state = {

  acg_units: [],
  hist_units: [],
  campaign_units: [],
  promotions: [],
  member_info: [],
  member_info_current: [],
  promotion_log: [],
  rank_lookup: [],

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

  }
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

  loadStoreDataAdd(context, payload) {

    // payload.caller: Name of the calling component,
    // payload.call_object: Object specifying the view/table to be loaded, plus additional variables that
    //                      customise the database call, i.e. filtering, ordering, ...
    // payload.data_array_name: Name of the array in the store to save the data
    return new Promise(function (resolve, reject) {
      Vue.prototype.$dbCon.requestViewData("unitInfo on behalf of " + payload.caller, payload.call_object)
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
            acg_unit_id: payload.acg_unit_id
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

  }

}

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}
