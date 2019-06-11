// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import store from './store'
import session from 'vue-session'
import auth from './resource/auth'
import dbCon from './resource/dbConnector'

Vue.config.productionTip = false;

//plugins

Vue.use(session, {persist: true});
Vue.use(dbCon, {usePHP: true});
Vue.use(auth);
// mixins
// Vue.mixin(auth);
// Vue.mixin(dbCon);


/* eslint-disable no-new */
var vm = new Vue({
  el: '#app',
  name: "Vue-instance",
  router,
  store,
  components: { App },
  template: '<App/>'
})
