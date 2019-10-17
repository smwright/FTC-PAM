// initial state
import Vue from "vue"
import moment from "moment"

const state = {

  acg_units: [],
  members: [],
  member_status_log: [],
  transfer_log: [],
  promotion_log: [],
  member_campaign_attendance: [],
  character_sorties_stats: [],
  character_claim_raf: [],
  character_claim_lw: [],
  character_claim_vvs_group: [],
  character_claim_vvs_pers: [],
  character_claim_ground: [],
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

    var member = state.members.find(
      function (member) {
        return member.member_id === id_inn;
      });
    if(member === undefined){
      return {member: "", member_status: "", acg_unit_id: undefined};
    } else {
      return member;
    }
  },

  currentACGUnitById: (state, getters) => (id_inn) => {

    var member = getters.memberById(id_inn);
    if(member.acg_unit_id !== undefined){
      var unit = state.acg_units.find(
        function (unit) {
          return unit.id === member.acg_unit_id;
        });
      if(unit !== undefined){
        return unit;
      }
    }
    return {name: ""};
  },

  unitById: (state) => (id_inn) => {

    return state.acg_units.find(
      function (unit) {
        return unit.id === id_inn;
      });
  },

  lengthOfService: (state) => {


    var status_array = state.member_status_log.filter(
      function (status) {
        return status.member_status === 0 || status.member_status === 2;
      }
    )

    var date_start, date_end;
    var period, period_to_add;
    if(status_array.length > 0){

      period = moment.duration(0);

      for(var i = 0; i < status_array.length; i++){

        date_start = moment(status_array[i].status_date_in);
        if(status_array[i].status_date_out === null) {
          date_end = moment();
        } else {
          date_end = moment(status_array[i].status_date_out);
        }
        period_to_add = moment.duration(date_end.diff(date_start));
        period = period.add(period_to_add);
      }

      var return_str = "";
      if(period.years() === 1){
        return_str += period.years() + " year ";
      } else {
        return_str += period.years() + " years ";
      }
      if(period.months() === 1){
        return_str += period.months() + " month ";
      } else {
        return_str += period.months() + " months ";
      }
      if(period.days() === 1){
        return_str += period.days() + " day ";
      } else {
        return_str += period.days() + " days ";
      }
      return return_str;

    } else {

      return "";
    }
  },

  sortiePilotAssetStats: (state) => (character_id) => {

      var stats_array;
      if(character_id === null){
        stats_array = state.character_sorties_stats;
      } else {

      }

      var result_array = {
        sorties: 0,
        pilot_ok: 0,
        pilot_wounded: 0,
        pilot_pow: 0,
        pilot_kia: 0,
        asset_ok: 0,
        asset_damaged: 0,
        asset_lost: 0};

      for(var i=0; i < stats_array.length; i++) {

        result_array.sorties += stats_array[i].sorties;
        result_array.pilot_ok += stats_array[i].pilot_ok;
        result_array.pilot_wounded += stats_array[i].pilot_wounded;
        result_array.pilot_pow += stats_array[i].pilot_pow;
        result_array.pilot_kia += stats_array[i].pilot_kia;
        result_array.asset_ok += stats_array[i].asset_ok;
        result_array.asset_damaged += stats_array[i].asset_damaged;
        result_array.asset_lost += stats_array[i].asset_lost;
      }

      return result_array;

  },

  claimStats: (state) => (character_id, type) => {

    var stats_array, result_array;
    if(character_id === null){

      switch (type) {
        case "raf":
          stats_array = state.character_claim_raf;
          result_array = {destroyed: 0, probables: 0, damaged: 0};
          break;
        case "lw":
          stats_array = state.character_claim_lw;
          result_array = {conf: 0, unconf: 0};
          break;
        case "vvs_pers":
          stats_array = state.character_claim_vvs_pers;
          result_array = {conf: 0, unconf: 0};
          break;
        case "vvs_group":
          stats_array = state.character_claim_vvs_group;
          result_array = {conf: 0, unconf: 0};
          break;
        case "ground":
          stats_array = state.character_claim_ground;
          result_array = {};
          break;
        default:
      }
    } else {

    }

    if(stats_array.length == 0){

      return undefined;
    }


    if(type == "raf") {

      for(var i=0; i < stats_array.length; i++){
        result_array.destroyed += stats_array[i].destroyed;
        result_array.probables += stats_array[i].probables;
        result_array.damaged += stats_array[i].damaged;
      }
    } else if(type == "lw" | type == "vvs_pers" | type == "vvs_group") {

      for(var i=0; i < stats_array.length; i++){
        result_array.conf += stats_array[i].conf;
        result_array.unconf += stats_array[i].unconf;
      }
    } else if(type == "ground") {

      for(var i=0; i<stats_array.length; i++){


        var key = stats_array[i].asset_name;
        if(key in result_array){
          result_array[key] += stats_array[i].amount;
        } else {
          result_array[key] = stats_array[i].amount;
        }
      }
    }

    return result_array;
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

  setDataArray (state, payload) {

    // Needed values:
    // array_name: Name of the array to set
    // array_data: Date to store in the array
    state[payload.array_name] = payload.array_data;
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
      Vue.prototype.$dbCon.requestViewData("memberInfo on behalf of " + payload.caller, payload.call_object)
        .then(response => {

          context.commit("setDataArray",
            {
              array_name: payload.data_array_name,
              array_data: response
            });
          resolve();

        })
        .catch(error => {
          reject(error.message);
        });
    })
  },

  loadACGUnits (context, payload) {

    return new Promise(function (resolve, reject) {
      if (context.state.acg_units.length === 0) {
        Vue.prototype.$dbCon.requestViewData("memberInfo on behalf of " + payload.caller, {view: "acg_unit"})
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

      Vue.prototype.$dbCon.requestViewData("memberInfo on behalf of " + payload.caller,
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
      if (context.state.members.length === 0) {
        Vue.prototype.$dbCon.requestViewData("memberInfo on behalf of " + payload.caller,
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

}

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}
