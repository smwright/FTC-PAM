// Authentication mixin
import dbCon from "./dbConnector"

export default {

  methods: {

    syncSession: function() {

      var url = "auth.php";
      this.createPOSTPromise(this.$options.name,url,{action:'syncSession'})
        .then(response => {
          if(!this.$session.exists()){
            console.log("Auth: Session started");
            this.$session.start();
          }
          this.$session.set('user_id', response['userID']);
          this.$session.set('username', response['username']);
          this.$session.set('callsign', response['callsign']);
          this.$session.set('admin', response['admin']);
          // console.log("Session data: "+JSON.stringify(this.$session.getAll()));
        })
        .catch(error => {
          console.log(error.message);
        });
    }


  }
}
