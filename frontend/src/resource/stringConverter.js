// Mixin for string conversion, html-encoding, html-decoding etc...
import he from 'he'
export default {

  methods: {

    decodeHTML: function (text) {
      if(typeof text == 'string') {
        return  he.decode(text);
      } else {
        return null;
      }
    }
  }
}

