import axios from 'axios';
import nestedSetContextFactory from 'nested-set';

export default {

  data () {
    return {
      usePHP: true
    }
  },

  methods: {

    requestViewData: function(caller, param) {
      if (this.usePHP) {

        var url = "dataRequest.php";

        return this.createGETPromise(caller, url, param);

      } else {

        return this.createGETPromise("pam/" + name);
      }
    },

    createGETPromise: function (caller, url, param) {

      var resultData = new Promise(
        function (resolve, reject) {
          axios.get(url, {params: param})
            .then(response => {
              console.log(caller+` dbConnector.createGETPromise call to ${url} with param ${JSON.stringify(param)}`);
              resolve(response.data);
            })
            .catch(error => {
              // console.log("ERROR DETECTED: ");
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
              var reason = new Error(errorStr);
              // console.log("Sending ERROR: "+reason.message);
              reject(reason);
            })
        })
      return resultData;
    },

    createPOSTPromise: function (caller, url, param){
      var resultData = new Promise(
        function (resolve, reject) {
          axios.post(url, param)
            .then(response => {
              console.log(caller+` dbConnector.createPOSTPromise call to ${url} with param ${JSON.stringify(param)}`);
              resolve(response.data);
            })
            .catch(error => {
              // console.log("ERROR DETECTED: ");
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
              var reason = new Error(errorStr);
              // console.log("Sending ERROR: "+reason.message);
              reject(reason);
            })
        })
      return resultData;
    },

    nestData: function (data) {
      const nestedSetContext = nestedSetContextFactory();
      return nestedSetContext.nest(data);
    }
  }
}
