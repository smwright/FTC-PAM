// initial state
import Vue from "vue"
import moment from "moment"

const state = {

  acg_units: [],
  members: [],
  member_status_log: [],
  transfer_log: [],
  promotion_log: [],
  member_characters: [],
  member_campaign_attendance: [],
  character_sorties_stats: [],
  character_claim_raf: [],
  character_claim_lw: [],
  character_claim_vvs_group: [],
  character_claim_vvs_pers: [],
  character_claim_ground: [],
  character_decorations: [],
  character_transfers: [],
  reports: []
};

// getters
const getters = {

  findByKey: (state) => (table, keyName, keyValue) => {

    return state[table].find(
      function (item) {
        return item[keyName] === keyValue;
      });
  },

  filterByKey: (state) => (table, keyName, keyValue) => {

    return state[table].filter(
      function (item) {
        return item[keyName] === keyValue;
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
        stats_array = state.reports.filter(
          function (item) {
            return item.accepted === 1;
          });
      } else {
        stats_array = state.reports.filter(
          function (item) {
            return item.character_id === character_id
              && item.accepted === 1;
          });
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

        result_array.sorties += stats_array[i].accepted;
        result_array.pilot_ok += (stats_array[i].pilot_status === 0)? 1 : 0;
        result_array.pilot_wounded += (stats_array[i].pilot_status === 1)? 1 : 0;
        result_array.pilot_pow += (stats_array[i].pilot_status === 2)? 1 : 0;
        result_array.pilot_kia += (stats_array[i].pilot_status === 3)? 1 : 0;
        result_array.asset_ok += (stats_array[i].asset_status === 0)? 1 : 0;
        result_array.asset_damaged += (stats_array[i].asset_status === 1)? 1 : 0;
        result_array.asset_lost += (stats_array[i].asset_status === 2)? 1 : 0;
      }

      return result_array;

  },

  claimStats: (state) => (character_id, report_id, type) => {

    var stats_array, result_array;
    if(character_id !== null){

      switch (type) {
        case "raf":
          stats_array = state.character_claim_raf.filter(
            function (item) {
              return item.character_id === character_id;
            });
          result_array = {Destroyed: 0, Probable: 0, Damaged: 0};
          break;
        case "lw":
          stats_array = state.character_claim_lw.filter(
            function (item) {
              return item.character_id === character_id;
            });
          result_array = {Confirmed: 0, Unconfirmed: 0};
          break;
        case "vvs_pers":
          stats_array = state.character_claim_vvs_pers.filter(
            function (item) {
              return item.character_id === character_id;
            });
          result_array = {Confirmed: 0, Unconfirmed: 0};
          break;
        case "vvs_group":
          stats_array = state.character_claim_vvs_group.filter(
            function (item) {
              return item.character_id === character_id;
            });
          result_array = {Confirmed: 0, Unconfirmed: 0};
          break;
        case "ground":
          stats_array = state.character_claim_ground.filter(
            function (item) {
              return item.character_id === character_id;
            });
          result_array = {};
          break;
        case "ground_total":
          stats_array = state.character_claim_ground.filter(
            function (item) {
              return item.character_id === character_id;
            });
          result_array = {Victories: 0};
          break;
        default:
      }
    } else {

      switch (type) {
        case "raf":
          stats_array = state.character_claim_raf;
          result_array = {Destroyed: 0, Probable: 0, Damaged: 0};
          break;
        case "lw":
          stats_array = state.character_claim_lw;
          result_array = {Confirmed: 0, Unconfirmed: 0};
          break;
        case "vvs_pers":
          stats_array = state.character_claim_vvs_pers;
          result_array = {Confirmed: 0, Unconfirmed: 0};
          break;
        case "vvs_group":
          stats_array = state.character_claim_vvs_group;
          result_array = {Confirmed: 0, Unconfirmed: 0};
          break;
        case "ground":
          stats_array = state.character_claim_ground;
          result_array = {};
          break;
        case "ground_total":
          stats_array = state.character_claim_ground;
          result_array = {Victories: 0};
          break;
        default:
      }
    }

    if(report_id !== null){

      stats_array = stats_array.filter(
        function (item) {
          return item.report_id === report_id;
        });
    }

    if(stats_array.length == 0){

      return undefined;
    }


    if(type == "raf") {

      for(var i=0; i < stats_array.length; i++){
        result_array.Destroyed += stats_array[i].destroyed;
        result_array.Probable += stats_array[i].probables;
        result_array.Damaged += stats_array[i].damaged;
      }
    } else if(type == "lw" | type == "vvs_pers") {

      for(var i=0; i < stats_array.length; i++){
        result_array.Confirmed += stats_array[i].conf;
        result_array.Unconfirmed += stats_array[i].unconf;
      }
    } else if(type == "vvs_group") {

      let mission_array = [];
      for(var i=0; i < stats_array.length; i++){

        // Group claims are only counted once per mission for each member/character
        if(!mission_array.includes(stats_array[i].mission_id)){
          result_array.Confirmed += stats_array[i].conf;
          result_array.Unconfirmed += stats_array[i].unconf;
          mission_array.push(stats_array[i].mission_id);
        }

      }

    } else if(type == "ground") {

      for (var i = 0; i < stats_array.length; i++) {


        var key = stats_array[i].asset_name;
        if (key in result_array) {
          result_array[key] += stats_array[i].amount;
        } else {
          result_array[key] = stats_array[i].amount;
        }
      }
    } else if(type == "ground_total") {

      for(var i=0; i<stats_array.length; i++){
        result_array.Victories += stats_array[i].amount;
      }
    }

    return result_array;
  },

  reportStats: (state) => (character_id) => {

    var stats_array;
    if (character_id === null) {
      stats_array = state.reports.filter(
        function (item) {
          return item.accepted === 1;
        });
    } else {
      stats_array = state.reports.filter(
        function (item) {
          return item.character_id === character_id
            && item.accepted === 1;
        });
    }

    return stats_array;
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
  },

  resetTable (state, table) {
    state[table] = [];
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
      Vue.prototype.$dbCon.requestViewData("memberInfo on behalf of " + payload.caller, payload.call_object)
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
