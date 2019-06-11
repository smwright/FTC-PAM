import Vue from 'vue'


// initial state
const state = {

  assets: null,
  dbStatus: "TEST"
}

// getters
const getters = {

  getAssets: function (state) {
    return JSON.parse(JSON.stringify(state.assets));
  }
}

// mutations
const mutations = {

  setAssets (state, payload) {
    state.assets = payload;
  },

  setName (state, payload) {
    // var id = payload.id;
    // var value = payload.value;

    console.log(state.assets[0]);

    // state.assets.find(
    //   function(x) {
    //     return x.id === this[0];
    //   }, payload.id).name = payload.value;
    // myArray.find(x => x.id === '45').foo;
  }
}

// actions
const  actions = {

  loadAssets (context, caller) {

    Vue.prototype.$dbCon.requestViewData(caller, {view: "asset_info"})
        .then(response => {
          context.commit("setAssets", Vue.prototype.$dbCon.nestData(response));
          // this.assets = this.$dbCon.nestData(response);
          // this.assets_display = response;
        })
        .catch(error => {
          console.log(error.message);
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
