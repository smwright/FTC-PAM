// IMPORTANT !!!
// The functions below depend on session variables being set. It might occur that certain
// variables need to be synced with the backend first.
// Therefore all functions requesting user variables are asynchronous with 'await' calls
// for possible synchronisation.
// Make sure to define the functions calling for user variables via the functions below as
// well asynchronous with await.

var auth = {
  session: null,
  test: 0,
}

auth.install = function (Vue, options) {
  console.log("Installing authentication plugin...");
  auth.session = Vue.prototype.$session;
  // console.log(auth_session.getAll());
  if(!auth.session.exists()){
    console.log("Auth: starting and storing session...");
    auth.session.start();
  }
  console.log("Auth: Session id: " + auth.session.id());

  Vue.prototype.$auth = {

    syncSession: async function(caller) {
      console.log(caller +" Auth: Syncing sessions...")
      var url = "auth.php";
      try {
        var response = await Vue.prototype.$dbCon.callBaEnAuth(caller, {action:'syncSession'})
        if(!auth.session.exists()){
          console.log("Auth: Session started");
          auth.session.start();
        }
        auth.session.set('user_id', response['userID']);
        auth.session.set('username', response['username']);
        auth.session.set('callsign', response['callsign']);
        auth.session.set('admin', response['admin']);
        console.log(caller + " Auth: Session data-> "+JSON.stringify(auth.session.getAll()))
      } catch(error) {
        console.log(error.message);
      }
    },

    isAdmin: async function(caller) {
      if(!auth.session.exists()){
        auth.session.start();
        await auth.session.syncSession(caller);
      }
      if(!auth.session.has("admin")){
        await auth.syncSession();
      }
      return auth.session.get("admin") === 1;
    },

    getUserId: async function(caller) {
      if(!auth.session.exists()){
        auth.session.start();
        await auth.session.syncSession(caller);
      }
      if(!auth.session.has("user_id")){
        await auth.syncSession();
      }
      return auth.session.get("user_id");
    },

    getUserCallsign: async function(caller) {
      if(!auth.session.exists()){
        auth.session.start();
        await auth.session.syncSession(caller);
      }
      if(!auth.session.has("callsign")){
        await auth.syncSession();
      }
      return auth.session.get("callsign");
    },

    getFaction: async function(caller, mission_id) {

      if(!auth.session.exists()){
        auth.session.start();
        await auth.session.syncSession(caller);
      }
      return Vue.prototype.$dbCon.requestViewData(caller,
        {view:"mission_member_faction", mission_id: mission_id, member_id: auth.session.get("user_id")});
    },

    getUserUnit: async function(caller, campaign_id) {

      if(!auth.session.exists()){
        auth.session.start();
        await auth.session.syncSession(caller);
      }
      return Vue.prototype.$dbCon.requestViewData(caller,
        {view:"campaign_member_latest_unit", campaign_id: campaign_id, member_id: auth.session.get("user_id")});
    },

    getUserStatus: async function(caller) {

      if(!auth.session.exists()){
        auth.session.start();
        await auth.session.syncSession(caller);
      }
      return new Promise(function (resolve, reject) {

        Vue.prototype.$dbCon.requestViewData(caller,
          {view:"member_info_with_last_status", member_id: auth.session.get("user_id")})
          .then(response => {

            resolve(response[0].member_status);
          })
          .catch(error => {

            reject(error.message);
          })
      })
    },

  }

}

export default auth;

// Code for authentication mixin

// export default {
//
//   methods: {
//
//     syncSession: function() {
//
//       console.log(this.$parent.$options.name+" Auth: Syncing sessions...")
//       var url = "auth.php";
//       this.createPOSTPromise(this.$options.name,url,{action:'syncSession'})
//         .then(response => {
//           if(!this.$session.exists()){
//             console.log("Auth: Session started");
//             this.$session.start();
//           }
//           this.$session.set('user_id', response['userID']);
//           this.$session.set('username', response['username']);
//           this.$session.set('callsign', response['callsign']);
//           this.$session.set('admin', response['admin']);
//           // console.log("Session data: "+JSON.stringify(this.$session.getAll()));
//         })
//         .catch(error => {
//           console.log(error.message);
//         });
//     },
//
//     isAdmin: function() {
//
//       if(!this.$session.exists()){
//         this.$session.start();
//       }
//       if(!this.$session.has("admin")){
//         this.syncSession();
//       }
//
//       return this.$session.get("admin") == 1;
//     }
//
//
//   }
// }
