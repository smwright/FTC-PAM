import Vue from 'vue'

// initial state
const state = {
  count: 0
}

// getters
const getters = {
  doubleCount (state) {
    // return state.count * 2;
    return Vue.prototype.$dbCon.testConnection();
  }
}

// actions
const  actions = {}

// mutations
const mutations = {
  increment (state) {
    state.count++
  }
}

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}
