

var auth = {
  session: null,
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

    syncSession: function(caller) {
      console.log(caller +" Auth: Syncing sessions...")
      var url = "auth.php";
      Vue.prototype.$dbCon.callBaEnAuth(caller, {action:'syncSession'})
        .then(response => {
          if(!auth.session.exists()){
            console.log("Auth: Session started");
            auth.session.start();
          }
          auth.session.set('user_id', response['userID']);
          auth.session.set('username', response['username']);
          auth.session.set('callsign', response['callsign']);
          auth.session.set('admin', response['admin']);
          console.log(caller + " Auth: Session data-> "+JSON.stringify(auth.session.getAll()));
        })
        .catch(error => {
          console.log(error.message);
        });
    },

    isAdmin: function(caller) {
      if(!auth.session.exists()){
        auth.session.start();
        auth.session.syncSession(caller);
      }
      if(!auth.session.has("admin")){
        auth.syncSession();
      }
      return auth.session.get("admin") == 1;
    }
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
