import axios from 'axios';
import nestedSetContextFactory from 'nested-set';

var usePHP= false;
var dbConnector = {


  createGETPromise: function (caller, url, param) {

    var resultData = new Promise(
      function (resolve, reject) {
        axios.get(url, {params: param})
          .then(response => {
            console.log(caller+` dbConnector.createGETPromise call to ${url} with param ${JSON.stringify(param)}`);
            resolve(response.data);
          })
          .catch(error => {
            var errorStr;
            errorStr = `dbConnector.createGETPromise call to ${url} with param ${JSON.stringify(param)}`;
            if (error.response) {
              // The request was made and the server responded with a status code
              // that falls out of the range of 2xx
              errorStr += " response error.";
              errorStr += ` Response data: ${error.response.data}`;
              errorStr += ` Response status: ${error.response.status}`;
              errorStr += ` Response headers: ${error.response.headers}`;
              errorStr += ` Response headers: ${error.message}`;
            } else if (error.request) {
              // The request was made but no response was receive
              // `error.request` is an instance of XMLHttpRequest in the browser and an instance of
              // http.ClientRequest in node.js
              errorStr += " request error.";
              errorStr += " "+error.request;
            } else {
              // Something happened in setting up the request that triggered an Error
              errorStr += " error.";
              errorStr += " "+error.message;
            }
            errorStr += " "+error.config;
            reject(errorStr);
          })
      })
    return resultData;
  },

  createPOSTPromise: function (caller, url, param) {

    var resultData = new Promise(
      function (resolve, reject) {
        axios.post(url, param)
          .then(response => {
            console.log(caller+` dbConnector.createPOSTPromise call to ${url} with param ${JSON.stringify(param)}`);
            resolve(response.data);
          })
          .catch(error => {
            var errorStr;
            errorStr = `dbConnector.createPOSTPromise call to ${url} with param ${JSON.stringify(param)}`;
            if (error.response) {
              // The request was made and the server responded with a status code
              // that falls out of the range of 2xx
              errorStr += " response error.";
              errorStr += ` Response data: ${error.response.data}`;
              errorStr += ` Response status: ${error.response.status}`;
              errorStr += ` Response headers: `+ JSON.stringify(error.response.headers);
              errorStr += ` Response headers: `+ JSON.stringify(error.message);
            } else if (error.request) {
              // The request was made but no response was receive
              // `error.request` is an instance of XMLHttpRequest in the browser and an instance of
              // http.ClientRequest in node.js
              errorStr += " request error.";
              errorStr += " "+error.request;
            } else {
              // Something happened in setting up the request that triggered an Error
              errorStr += " error.";
              errorStr += " "+error.message;
            }
            errorStr += " "+error.config;
            reject(errorStr);
          })
      })
    return resultData;
  },

  // createERROR: function (error) {
  //
  //   var errorStr;
  //   errorStr = `dbConnector.createGETPromise call to ${url} with param ${JSON.stringify(param)}`;
  //   if (error.response) {
  //     // The request was made and the server responded with a status code
  //     // that falls out of the range of 2xx
  //     errorStr += " response error.";
  //     errorStr += ` Response data: ${error.response.data}`;
  //     errorStr += ` Response status: ${error.response.status}`;
  //     errorStr += ` Response headers: ${error.response.headers}`;
  //     errorStr += ` Response headers: ${error.message}`;
  //   } else if (error.request) {
  //     // The request was made but no response was receive
  //     // `error.request` is an instance of XMLHttpRequest in the browser and an instance of
  //     // http.ClientRequest in node.js
  //     errorStr += " request error.";
  //     errorStr += " "+error.request;
  //   } else {
  //     // Something happened in setting up the request that triggered an Error
  //     errorStr += " error.";
  //     errorStr += " "+error.message;
  //   }
  //   errorStr += " "+error.config;
  //   return new Error(errorStr);
  // }
}

// dbConnector.install routine for Vue installation

dbConnector.install =  function(Vue, options) {
  console.log("Installing dbConnector... ");
  if(options && 'usePHP' in options && options.usePHP){
    usePHP = true;
    console.log("dbConnector: Using PHP backend");
  } else {
    usePHP = false;
    console.log("dbConnector: Using Kotlin backend");
  }

  Vue.prototype.$dbCon = {

    testConnection: function() {
       return "Testing connection: Connector listening...";
    },

    callBaEnAuth: function(caller, param) {

      if (usePHP) {

        var url = "auth.php";
        return dbConnector.createPOSTPromise(caller, url, {action:'syncSession'});

      } else {

        return dbConnector.createGETPromise("pam/" + name);
      }
    },

    requestViewData: function(caller, param) {

      if (usePHP) {

        var url = "dataRequest.php";
        return dbConnector.createGETPromise(caller, url, param);

      } else {

        return dbConnector.createGETPromise("pam/" + name);
      }
    },

    insertUpdateData: function(caller, param) {

      if (usePHP) {

        var url = "dataInsertUpdate.php";
        return dbConnector.createPOSTPromise(caller, url, param);

      } else {

        return dbConnector.createPOSTPromise("pam/" + name);
      }
    },

    deleteData: function(caller, param) {

      if (usePHP) {

        var url = "dataDelete.php";
        return dbConnector.createPOSTPromise(caller, url, param);

      } else {

        return dbConnector.createPOSTPromise("pam/" + name);
      }
    },

    nestData: function (data) {
      const nestedSetContext = nestedSetContextFactory();
      return nestedSetContext.nest(data);
    },

    flatData: function (data) {
      const nestedSetContext = nestedSetContextFactory();
      return nestedSetContext.flat(data);
    },

    sendForumPM: function(caller, param) {

      var url = "sendForumPM.php";
      return dbConnector.createPOSTPromise(caller, url, param);
    },

    checkDecorations: function(caller, param) {

      var url = "decorationsChecks.php";
      return dbConnector.createPOSTPromise(caller, url, param);
    },

    adjustForum: function(caller, param) {

      var url = "forumAdjust.php";
      return dbConnector.createPOSTPromise(caller, url, param);
    },
  }

}

export default dbConnector;


// CODE FOR dbConnector as mixin
// export default {
//
//   data () {
//     return {
//       usePHP: true
//     }
//   },
//
//   methods: {
//
//     requestViewData: function(caller, param) {
//       if (this.usePHP) {
//
//         var url = "dataRequest.php";
//
//         return this.createGETPromise(caller, url, param);
//
//       } else {
//
//         return this.createGETPromise("pam/" + name);
//       }
//     },
//
//     createGETPromise: function (caller, url, param) {
//
//       var resultData = new Promise(
//         function (resolve, reject) {
//           axios.get(url, {params: param})
//             .then(response => {
//               console.log(caller+` dbConnector.createGETPromise call to ${url} with param ${JSON.stringify(param)}`);
//               resolve(response.data);
//             })
//             .catch(error => {
//               // console.log("ERROR DETECTED: ");
//               var errorStr;
//               errorStr = `dbConnector.createGETPromise call to ${url} with param ${JSON.stringify(param)}`;
//               if (error.response) {
//                 // The request was made and the server responded with a status code
//                 // that falls out of the range of 2xx
//                 errorStr += " response error.";
//                 errorStr += ` Response data: ${error.response.data}`;
//                 errorStr += ` Response status: ${error.response.status}`;
//                 errorStr += ` Response headers: ${error.response.headers}`;
//                 errorStr += ` Response headers: ${error.message}`;
//               } else if (error.request) {
//                 // The request was made but no response was receive
//                 // `error.request` is an instance of XMLHttpRequest in the browser and an instance of
//                 // http.ClientRequest in node.js
//                 errorStr += " request error.";
//                 errorStr += " "+error.request;
//               } else {
//                 // Something happened in setting up the request that triggered an Error
//                 errorStr += " error.";
//                 errorStr += " "+error.message;
//               }
//               errorStr += " "+error.config;
//               var reason = new Error(errorStr);
//               // console.log("Sending ERROR: "+reason.message);
//               reject(reason);
//             })
//         })
//       return resultData;
//     },
//
//     createPOSTPromise: function (caller, url, param){
//       var resultData = new Promise(
//         function (resolve, reject) {
//           axios.post(url, param)
//             .then(response => {
//               console.log(caller+` dbConnector.createPOSTPromise call to ${url} with param ${JSON.stringify(param)}`);
//               resolve(response.data);
//             })
//             .catch(error => {
//               // console.log("ERROR DETECTED: ");
//               var errorStr;
//               errorStr = `dbConnector.createGETPromise call to ${url} with param ${JSON.stringify(param)}`;
//               if (error.response) {
//                 // The request was made and the server responded with a status code
//                 // that falls out of the range of 2xx
//                 errorStr += " response error.";
//                 errorStr += ` Response data: ${error.response.data}`;
//                 errorStr += ` Response status: ${error.response.status}`;
//                 errorStr += ` Response headers: ${error.response.headers}`;
//                 errorStr += ` Response headers: ${error.message}`;
//               } else if (error.request) {
//                 // The request was made but no response was receive
//                 // `error.request` is an instance of XMLHttpRequest in the browser and an instance of
//                 // http.ClientRequest in node.js
//                 errorStr += " request error.";
//                 errorStr += " "+error.request;
//               } else {
//                 // Something happened in setting up the request that triggered an Error
//                 errorStr += " error.";
//                 errorStr += " "+error.message;
//               }
//               errorStr += " "+error.config;
//               var reason = new Error(errorStr);
//               // console.log("Sending ERROR: "+reason.message);
//               reject(reason);
//             })
//         })
//       return resultData;
//     },
//
//     nestData: function (data) {
//       const nestedSetContext = nestedSetContextFactory();
//       return nestedSetContext.nest(data);
//     }
//   }
// }
