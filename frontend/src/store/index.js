import Vue from 'vue'
import Vuex from 'vuex'
import createLogger from '../../node_modules/vuex/dist/logger'
import test from './modules/test'
import campaignAdmin from './modules/campaignAdmin'
import memberAdmin from './modules/memberAdmin'
import memberInfo from './modules/memberInfo'
import unitInfo from './modules/unitInfo'
import characterStore from './modules/characterStore'
import missionStore from './modules/missionStore'
import unitAdmin from './modules/unitAdmin'
import logger from './modules/logger'

Vue.use(Vuex)

const debug = process.env.NODE_ENV !== 'production'

export default new Vuex.Store({

  modules: {
    test,
    campaignAdmin,
    memberAdmin,
    memberInfo,
    unitInfo,
    characterStore,
    missionStore,
    unitAdmin,
    logger
  },
  strict: debug,
  plugins: debug ? [createLogger()] : [createLogger()]
})


// Hot reloading enabled for dev according to https://vuex.vuejs.org/guide/hot-reload.html
if (module.hot) {
  // accept actions and mutations as hot modules
  module.hot.accept([

    // './modules/test',
    // './modules/campaignAdmin'
  ], () => {
    // require the updated modules
    // have to add .default here due to babel 6 module output
    const test = require('./modules/test').default;
    const campaignAdmin = require('./modules/campaignAdmin');
    const memberAdmin = require('./modules/memberAdmin');
    const memberInfo = require('./modules/memberInfo');
    const unitInfo = require('./modules/unitInfo');
    const missionStore = require('./modules/missionStore');
    const characterStore = require('./modules/characterStore');
    const unitAdmin = require('./modules/unitAdmin');
    const logger = require('./modules/logger')
    // swap in the new actions and mutations
    store.hotUpdate({
      modules: {
        test: test,
        campaignAdmin: campaignAdmin,
        memberAdmin: memberAdmin,
        memberInfo: memberInfo,
        unitInfo: unitInfo,
        missionStore: missionStore,
        characterStore: characterStore,
        unitAdmin: unitAdmin,
        logger: logger
      }
    })
  })
}
