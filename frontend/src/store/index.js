import Vue from 'vue'
import Vuex from 'vuex'
import createLogger from '../../node_modules/vuex/dist/logger'
import test from './modules/test'
import campaignAdmin from './modules/campaignAdmin'

Vue.use(Vuex)

const debug = process.env.NODE_ENV !== 'production'

export default new Vuex.Store({

  modules: {
    test,
    campaignAdmin
  },
  strict: debug,
  plugins: debug ? [createLogger()] : []
})


// Hot reloading enabled for dev according to https://vuex.vuejs.org/guide/hot-reload.html
if (module.hot) {
  // accept actions and mutations as hot modules
  module.hot.accept([

    './modules/test',
    // './modules/campaignAdmin'
  ], () => {
    // require the updated modules
    // have to add .default here due to babel 6 module output
    const test = require('./modules/test').default
    const campaignAdmin = require('./modules/campaignAdmin')
    // swap in the new actions and mutations
    store.hotUpdate({
      modules: {
        test: test,
        campaignAdmin: campaignAdmin
      }
    })
  })
}
