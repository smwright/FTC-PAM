import Vue from "vue"

// initial state
const state = {

  characters: []

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
  }


}

// mutations
const mutations = {

  setCharacters (state, payload) {

    state.characters = payload;
  }

}

// actions
const  actions = {

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
      // var name = null;
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
