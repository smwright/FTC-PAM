import Vue from "vue"

// initial state
const state = {

  characters: [],
  decorations: []

}

// getters
const getters = {

  selectableCharacters: (state) => (depl_unit_id, faction, mission_hist_date) => {

    // Check for character that flew in this deployed unit
    var characters = state.characters.filter(
      function (character) {
        return character.deployed_unit_id === depl_unit_id &&
          character.character_status <= 1;
      }
    )

    // Return character if available
    if (characters.length > 0) {
      return characters;
    }

    // Check for active, past characters of the same faction
    characters = state.characters.filter(
      function (character) {
        return character.faction === faction &&
          Date.parse(character.last_mission_hist_date) < Date.parse(mission_hist_date) &&
          character.character_status <= 1;
      }
    )

    // Add new character entry and return characters
    characters.push({character_id: -1, first_name: "NEW CHARACTER"});
    return characters;
  },

  decorationsById: (state) => (id) => {

    return state.decorations.find(
      function (decoration) {
        return decoration.decoration_id === id;
      }
    )
  },

  decorationsByCharacterId: (state) => (id) => {

     return state.decorations.filter(
       function (decoration) {
         return decoration.character_id === id;
       }
     )
  },

  unawardedDecorationsByCharacterId: (state) => (id) => {

    return state.decorations.filter(
      function (decoration) {
        return decoration.character_id === id && decoration.awarded === 0;
      }
    )
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

  setCharacters (state, payload) {

    state.characters = payload;
  },

  setDecorations (state, payload) {

    for(var i = 0; i < payload.length; i++){

      var index = state.decorations.findIndex(item => item.decoration_id === payload[i].decoration_id);
      if(index === -1){
        state.decorations.push(payload[i]);
      } else {
        state.decorations.splice(index, 1, payload[i]);
      }
    }
  },

  resetCharacters (state, payload) {

    state.characters = [];
  },

  resetDecorations (state, payload) {

    state.decorations = [];
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

  loadCharacters (context, payload) {


    return new Promise(function (resolve, reject) {

      Vue.prototype.$dbCon.requestViewData("characterStore on behalf of " + payload.caller,
        {view: "character_latest_report", member_id: payload.member_id})
        .then(response => {

          context.commit("setCharacters", response);
          resolve();
        })
        .catch(error => {

          reject(error.message);
        })
    })
  },

  loadDecorations (context, payload) {

    return new Promise(function (resolve, reject) {

      context.commit("resetDecorations");

      Vue.prototype.$dbCon.requestViewData("characterStore on behalf of " + payload.caller,
        {view: "decoration_info", member_id: payload.member_id})
        .then(response => {

          context.commit("setDecorations", response);
          resolve();
        })
        .catch(error => {

          reject(error.message);
        })

    })
  },

  getRandomName (context, payload) {

    return new Promise(async function (resolve, reject) {

      try {

        var first_name = await Vue.prototype.$dbCon.requestViewData("characterStore on behalf of " + payload.caller,
          {view: "random_first_name", faction: payload.faction});
        var last_name = await Vue.prototype.$dbCon.requestViewData("characterStore on behalf of " + payload.caller,
          {view: "random_last_name", faction: payload.faction});
        resolve({first_name: first_name[0].name, last_name: last_name[0].name});

      } catch (e) {

        reject(e);

      }
    })
  },

  awardRevokeDecoration (context, payload) {

    var award_parcel = {
      id: payload.id,
      awarded: payload.awarded,
      awarded_by: payload.member_id
    };

    var decoration = context.getters.decorationsById(payload.id);
    award_parcel.comment = decoration.decoration_comment;

    Vue.prototype.$dbCon.insertUpdateData("characterStore on behalf of "+payload.caller,
      {
        table: "decoration",
        payload: [award_parcel]
      })
      .then(response => {

        context.commit('updateValue',
          {
            array_name: "decorations",
            id_column_name: "decoration_id",
            id_column_value: payload.id,
            update_column_name: "awarded",
            update_column_value: payload.awarded
          });
        context.commit('updateValue',
          {
            array_name: "decorations",
            id_column_name: "decoration_id",
            id_column_value: payload.id,
            update_column_name: "awarded_by",
            update_column_value: payload.member_id
          });

      })
      .catch(error => {

        console.log(error.message);
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
