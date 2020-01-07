// initial state
import Vue from "vue"

const state = {

  acg_units: [],
  members: [{
    member_id: -1,
    username: "",
    callsign: "",
    admin: 0
  }],
  member_status_log: [],
  transfer_log: [],
  promotion_log: [],
  rank_lookup: [],
};

// getters
const getters = {

  membersByUnitId: (state) => (id_inn, showActive, showOnLeave, showDismissed, showPassedAway, searchString) => {

    return state.members.filter(
      function (member) {
        return member.acg_unit_id === id_inn &&
          (

            ((showActive && member.member_status === 0) ||
              (showOnLeave && member.member_status === 2) ||
              (showDismissed && member.member_status === 1) ||
              (showPassedAway && member.member_status === 3))
              && (member.callsign.toLowerCase().includes(searchString.toLowerCase()) || searchString === "")

          );
      }
    )
  },

  memberById: (state) => (id_inn) => {

    return state.members.find(
      function (member) {
        return member.member_id === id_inn;
      });
  },

  statusById: (state) => (id_inn) => {

    return state.member_status_log.find(
      function (status) {
        return status.id === id_inn;
      });
  },

  transferById: (state) => (id_inn) => {

    return state.transfer_log.find(
      function (status) {
        return status.id === id_inn;
      });
  },

  statusAfterBefore: (state) => (array_name, id_inn, date_column_name, date_inn, before) => {

    var return_array;
    var return_object;
    if(before){

      return_array = state[array_name].filter(
        function (status) {
          return status[date_column_name] <= date_inn;
        }
      )

      if(id_inn >= 0){
        return_array = return_array.filter(
          function (status) {
            if(status[date_column_name] === date_inn){
              return status.id < id_inn
            } else {
              return true;
            }
          }
        )
      }
      return_object = return_array[return_array.length - 1];

    } else {

      if(id_inn < 0) {
        return_array = state[array_name].filter(
          function (status) {
            return status[date_column_name] > date_inn;
          }
        )
      } else {
        return_array = state[array_name].filter(
          function (status) {
            return status[date_column_name] >= date_inn;
          }
        );
        return_array = return_array.filter(
          function (status) {
            if(status[date_column_name] === date_inn){
              return status.id > id_inn
            } else {
              return true;
            }
          }
        )
      }
      return_object = return_array[0];
    }

    if(return_object !== undefined){
      return JSON.parse(JSON.stringify(return_object));
    } else {
      return return_object;
    }
  },

  unitById: (state) => (id_inn) => {

    return state.acg_units.find(
      function (unit) {
        return unit.id === id_inn;
      });
  },

  rankByValueFaction: (state) => (value_inn, faction_inn) => {

    // return {rank_name: "TEST"};
    var rank = state.rank_lookup.find(
      function (rank) {

        return rank.real_value === value_inn && rank.faction === faction_inn;
      });
    // console.log("VALUE: "+value_inn+" FACTION "+faction_inn+" "+JSON.stringify(rank));
    if(rank === undefined){
      return {rank_name: ""};
    } else {
      return rank;
    }
  },

  rankValues: (state) => {

    if(state.rank_lookup.length > 0){

      var max_value = state.rank_lookup.reduce((max_value, rank) => {
        return Math.max(max_value, rank.real_value);
      }, 1);
      return Array.from(Array(max_value), (x, index) => 1 + index);
    }
  }

}

// mutations
const mutations = {

  setACGUnit (state, payload) {

    for(var i = 0; i < payload.length; i++ ){

      var index = state.acg_units.findIndex(item => item.id === payload[i].id)
      if(index === -1){
        state.acg_units.push(payload[i]);
      } else {
        state.acg_units.splice(index, 1, payload[i]);
      }
    }
  },

  setMembers (state, payload) {

    for(var i = 0; i < payload.length; i++ ){

      var index = state.members.findIndex(item => item.member_id === payload[i].member_id)
      if(index === -1){
        state.members.push(payload[i]);
      } else {
        state.members.splice(index, 1, payload[i]);
      }
    }
  },

  setStatusLog (state, payload) {

    state.member_status_log = payload;
  },

  setTransferLog (state, payload) {

    state.transfer_log = payload;
  },

  setPromotionLog (state, payload) {

    state.promotion_log = payload;
  },

  setRankLookup (state, payload) {

    state.rank_lookup = payload;
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

  loadACGUnits (context, payload) {

    return new Promise(function (resolve, reject) {
      if (context.state.acg_units.length === 0) {
        Vue.prototype.$dbCon.requestViewData("memberAdmin on behalf of " + payload.caller, {view: "acg_unit"})
          .then(response => {

            context.commit("setACGUnit", response);
            resolve();

          })
          .catch(error => {
            reject(error.message);
          });
      } else {
        resolve();
      }
    })
  },

  loadMember (context, payload) {

    return new Promise(function (resolve, reject) {

      Vue.prototype.$dbCon.requestViewData("memberAdmin on behalf of " + payload.caller,
        {view: "member_info_with_last_status", member_id: payload.member_id})
        .then(response => {

          context.commit("setMembers", response);
          resolve();

        })
        .catch(error => {
          reject(error.message);
        });

    })
  },

  loadMembers (context, payload) {

    return new Promise(function (resolve, reject) {
      if (context.state.members.length === 1) {
        Vue.prototype.$dbCon.requestViewData("memberAdmin on behalf of " + payload.caller,
          {view: "member_info_with_last_status"})
          .then(response => {

            context.commit("setMembers", response);
            resolve();

          })
          .catch(error => {
            reject(error.message);
          });
      } else {
        resolve();
      }
    })
  },


  loadStatusLog (context, payload) {

    return new Promise(function (resolve, reject) {

      Vue.prototype.$dbCon.requestViewData("memberAdmin on behalf of " + payload.caller,
        {view: "member_status_log_info", member_id: payload.member_id})
        .then(response => {

          context.commit("setStatusLog", response);
          resolve();

        })
        .catch(error => {
          reject(error.message);
        });
    })
  },

  loadTransferLog (context, payload) {

    return new Promise(function (resolve, reject) {

      Vue.prototype.$dbCon.requestViewData("memberAdmin on behalf of " + payload.caller,
        {view: "transfer_info", member_id: payload.member_id})
        .then(response => {

          context.commit("setTransferLog", response);
          resolve();

        })
        .catch(error => {
          reject(error.message);
        });
    })
  },

  loadPromotionLog (context, payload) {

    return new Promise(function (resolve, reject) {

      Vue.prototype.$dbCon.requestViewData("memberAdmin on behalf of " + payload.caller,
        {view: "promotion_info", member_id: payload.member_id})
        .then(response => {

          context.commit("setPromotionLog", response);
          resolve();

        })
        .catch(error => {
          reject(error.message);
        });
    })
  },

  loadRankLookup (context, payload) {

    return new Promise(function (resolve, reject) {

      Vue.prototype.$dbCon.requestViewData("memberAdmin on behalf of " + payload.caller,
        {view: "rank_lookup", member_id: payload.member_id})
        .then(response => {

          context.commit("setRankLookup", response);
          resolve();

        })
        .catch(error => {
          reject(error.message);
        });
    })
  },

  sendMemberInfo (context, payload) {

    return new Promise(async function (resolve, reject) {

      var member = context.getters.memberById(payload.member_id);

      var response = await Vue.prototype.$dbCon.insertUpdateData("memberAdmin on behalf of "+payload.caller,
        {
          table: "acg_member",
          payload: [
            {
              id: payload.member_id,
              username: member.username,
              callsign: member.callsign,
              admin: member.admin
            }]
        });
      console.log(JSON.stringify(response));
      resolve(response);
    })
  },

  updateStatus (context, payload) {

    return new Promise(async function (resolve, reject) {

      var insert_status =
        {
          id: -1,
          member_id: payload.member_id,
          member_status: payload.status,
          status_date_in: payload.status_date,
          status_date_out: null,
          comment: payload.status_comment
        };

      var status_before = context.getters.statusAfterBefore("member_status_log", insert_status.id,
        "status_date_in", insert_status.status_date_in, 1);
      var status_after = context.getters.statusAfterBefore("member_status_log", insert_status.id,
        "status_date_in", insert_status.status_date_in, 0);

      var status_array = [];
      if(status_before !== undefined){
        status_before.status_date_out = payload.status_date;
        status_array.push(status_before)
      }

      if(status_after !== undefined){
        insert_status.status_date_out = status_after.status_date_in;
      }

      status_array.push(insert_status);
      var response = await Vue.prototype.$dbCon.insertUpdateData("memberAdmin on behalf of "+payload.caller,
        {
          table: "member_status_log",
          payload: status_array
        });
      resolve(response);

    })
  },

  deleteStatus (context, payload) {

    return new Promise(async function (resolve, reject) {

      var delete_status = context.getters.statusById(payload.status_id);
      var status_before = context.getters.statusAfterBefore("member_status_log", delete_status.id,
        "status_date_in", delete_status.status_date_in, 1);
      var status_after = context.getters.statusAfterBefore("member_status_log", delete_status.id,
        "status_date_in", delete_status.status_date_in, 0);

      var update_status_array = [];
      if(status_before !== undefined && status_after !== undefined){
        status_before.status_date_out = status_after.status_date_in;
        update_status_array.push(status_before)
      }

      if(status_before !== undefined && status_after === undefined){
        status_before.status_date_out = null;
        update_status_array.push(status_before)
      }

      var update_response = await Vue.prototype.$dbCon.insertUpdateData("memberAdmin on behalf of "+payload.caller,
        {
          table: "member_status_log",
          payload: update_status_array
        });

      var delete_response = await Vue.prototype.$dbCon.deleteData("memberAdmin on behalf of "+payload.caller,
        {
          table:"member_status_log",
          payload: [delete_status]
        });

      resolve(update_response.message+", "+delete_response.message);

    })
  },

  updateTransfer (context, payload) {

    return new Promise(async function (resolve, reject) {

      var insert_transfer =
        {
          id: -1,
          member_id: payload.member_id,
          acg_unit_id: payload.transfer_unit,
          transfer_date_in: payload.transfer_date,
          transfer_date_out: null
        };
      console.log("payload: "+JSON.stringify(insert_transfer));

      var transfer_before = context.getters.statusAfterBefore("transfer_log", insert_transfer.id,
        "transfer_date_in", insert_transfer.transfer_date_in, 1);
      var transfer_after = context.getters.statusAfterBefore("transfer_log", insert_transfer.id,
        "transfer_date_in", insert_transfer.transfer_date_in, 0);

      console.log("before: "+JSON.stringify(transfer_before));
      console.log("after: "+JSON.stringify(transfer_after));

      var transfer_array = [];
      if(transfer_before !== undefined){
        transfer_before.transfer_date_out = payload.transfer_date;
        transfer_array.push(transfer_before)
      }

      if(transfer_after !== undefined){
        insert_transfer.transfer_date_out = transfer_after.transfer_date_in;
      }

      transfer_array.push(insert_transfer);
      var response = await Vue.prototype.$dbCon.insertUpdateData("memberAdmin on behalf of "+payload.caller,
        {
          table: "transfer",
          payload: transfer_array
        });
      resolve(response);

    })
  },

  deleteTransfer (context, payload) {

    return new Promise(async function (resolve, reject) {

      var delete_transfer = context.getters.transferById(payload.transfer_id);
      var transfer_before = context.getters.statusAfterBefore("transfer_log", delete_transfer.id,
        "transfer_date_in", delete_transfer.transfer_date_in, 1);
      var transfer_after = context.getters.statusAfterBefore("transfer_log", delete_transfer.id,
        "transfer_date_in", delete_transfer.transfer_date_in, 0);

      var update_transfer_array = [];
      if(transfer_before !== undefined && transfer_after !== undefined){
        transfer_before.transfer_date_out = transfer_after.transfer_date_in;
        update_transfer_array.push(transfer_before)
      }

      if(transfer_before !== undefined && transfer_after === undefined){
        transfer_before.transfer_date_out = null;
        update_transfer_array.push(transfer_before)
      }

      var update_response = await Vue.prototype.$dbCon.insertUpdateData("memberAdmin on behalf of "+payload.caller,
        {
          table: "transfer",
          payload: update_transfer_array
        });

      var delete_response = await Vue.prototype.$dbCon.deleteData("memberAdmin on behalf of "+payload.caller,
        {
          table:"transfer",
          payload: [delete_transfer]
        });

      resolve(update_response.message+", "+delete_response.message);

    })
  },

  updatePromotion (context, payload) {

    return new Promise(async function (resolve, reject) {

      var insert_promotion =
        {
          id: -1,
          member_id: payload.member_id,
          rank_value: payload.promotion_value,
          promotion_date: payload.promotion_date,
          comment: payload.promotion_comment
        };

      var response = await Vue.prototype.$dbCon.insertUpdateData("memberAdmin on behalf of "+payload.caller,
        {
          table: "promotion",
          payload: [insert_promotion]
        });

      Vue.prototype.$dbCon.adjustForum("missionStore on behalf of "+payload.caller,
        {
          updateForumRank: payload.member_id
        });

      resolve(response);

    })
  },

  deletePromotion (context, payload) {

    return new Promise(async function (resolve, reject) {

      var delete_response = await Vue.prototype.$dbCon.deleteData("memberAdmin on behalf of "+payload.caller,
        {
          table: "promotion",
          payload: [{id: payload.promotion_id}]
        });

      Vue.prototype.$dbCon.adjustForum("missionStore on behalf of "+payload.caller,
        {
          updateForumRank: payload.member_id
        });

      resolve(delete_response.message);

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
