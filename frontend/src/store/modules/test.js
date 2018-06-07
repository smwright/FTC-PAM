// initial state
const state = {
  count: 0
}

// getters
const getters = {
  doubleCount (state) {
    return state.count * 2
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
