import Vue from 'vue'
import Vuex from 'vuex'
import createLogger from '../../node_modules/vuex/dist/logger'
import test from './modules/test'

Vue.use(Vuex)

const debug = process.env.NODE_ENV !== 'production'

export default new Vuex.Store({

  modules: {
    test
  },
  strict: debug,
  plugins: debug ? [createLogger()] : []
})

if (module.hot) {
  // accept actions and mutations as hot modules
  module.hot.accept([

    './modules/test'
  ], () => {
    // require the updated modules
    // have to add .default here due to babel 6 module output
    const test = require('./modules/test').default
    // swap in the new actions and mutations
    store.hotUpdate({
      modules: {
        test: test
      }
    })
  })
}
