import axios from 'axios';
import nestedSetContextFactory from 'nested-set';

var usePHP = true;

function requestViewData(param) {

  if (usePHP) {

    var url = "dataRequest.php";
    // var param = {
    //   view: name
    // }

    return createGETPromise(url, param);

  } else {

    return createGETPromise("pam/"+name);

  }
}

function createGETPromise(url, param) {

  var resultData = new Promise(
    function (resolve, reject) {
      axios.get(url, {params: param})
        .then(response => {
          console.log(`dbConnector.createGETPromise call to ${url} with param ${JSON.stringify(param)}`);
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
          } else if (error.request) {
            // The request was made but no response was received
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
          reject(reason);
        })

    }
  )
  return resultData;
}

function createPOSTPromise(url, param) {

  var resultData = new Promise(
    function (resolve, reject) {
      axios.post(url, param)
        .then(response => {
          console.log(`dbConnector.createPOSTPromise call to ${url} with param ${JSON.stringify(param)}`);
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
            errorStr += ` Response headers: ${error.response.headers}`;
          } else if (error.request) {
            // The request was made but no response was received
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
          reject(reason);
        })

    }
  )
  return resultData;
}

function nestData(data) {
  const nestedSetContext = nestedSetContextFactory();
  return nestedSetContext.nest(data);
}

export {
  requestViewData,
  createGETPromise,
  createPOSTPromise,
  nestData,
}
