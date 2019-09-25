// initial state
const state = {

  show_index: 0,
  event_log: []
}

// getters
const getters = {

  getEntry: (state) => (shift) => {

    let rtn_index = state.show_index + shift;
    let mx_index = state.event_log.length - 1;
    if(0 <= rtn_index && rtn_index <= mx_index) {

      return state.event_log[rtn_index];
    } else {

      return {datetime: "", message: ""};
    }
  }
}

// mutations
const mutations = {

  addEntry (state, payload) {

    let currentdate = new Date();
    let datetime = currentdate.getDate() + "/"
      + (currentdate.getMonth()+1)  + "/"
      + currentdate.getFullYear() + " "
      + currentdate.getHours() + ":"
      + currentdate.getMinutes() + ":"
      + currentdate.getSeconds();
    state.event_log.push({datetime: datetime, message: payload.message});
    state.show_index = state.event_log.length -1;
  },

  showPrevious (state) {

    if(state.show_index > 0){
      state.show_index--;
    };
  },

  showNext (state) {

    if(state.show_index < state.event_log.length - 1){
      state.show_index++;
    };
  }

}

// actions
const  actions = {}

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}
