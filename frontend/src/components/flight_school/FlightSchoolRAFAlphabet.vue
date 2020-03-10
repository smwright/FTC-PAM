<template>
  <div>
  <h1 class="text-align-center">The Phonetic Alphabet</h1>
    <p align="center">The Royal Air Force changed the codes during World War II, particularly with the arrival of the Americans in 1943, which makes things a little tricky to be authentic, but we try our best to stick with the 1940 version.</p>
    <table align="center" border="1">
      <tr class="rosterTableHeader">
      <tr>
        <th width="70px">Letter</th>
        <th width="70px">1939-42</th>
        <th width="70px">1942-43</th>
        <th width="70px">1943-45</th>
        <th width="70px">Today</th>
      </tr>
      <tr>
        <td>A</td>
        <td>Ace</td>
        <td>Apple</td>
        <td>Able</td>
        <td>Alpha</td>
      </tr>
      <tr>
        <td>B</td>
        <td>Beer</td>
        <td>Beer</td>
        <td>Baker</td>
        <td>Bravo</td>
      </tr>
      <tr>
        <td>C</td>
        <td>Charlie</td>
        <td>Charlie</td>
        <td>Charlie</td>
        <td>Charlie</td>
      </tr>
      <tr>
        <td>D</td>
        <td>Don</td>
        <td>Dog</td>
        <td>Dog</td>
        <td>Delta</td>
      </tr>
      <tr>
        <td>E</td>
        <td>Edward</td>
        <td>Edward</td>
        <td>Easy</td>
        <td>Echo</td>
      </tr>
      <tr>
        <td>F</td>
        <td>Freddie</td>
        <td>Freddie</td>
        <td>Fox</td>
        <td>Foxtrot</td>
      </tr>
      <tr>
        <td>G</td>
        <td>George</td>
        <td>George</td>
        <td>George</td>
        <td>Golf</td>
      </tr>
      <tr>
        <td>H</td>
        <td>Harry</td>
        <td>Harry</td>
        <td>How</td>
        <td>Hotel</td>
      </tr>
      <tr>
        <td>I</td>
        <td>Ink</td>
        <td>In</td>
        <td>Item</td>
        <td>India</td>
      </tr>
      <tr>
        <td>J</td>
        <td>Johnnie</td>
        <td>Johnnie</td>
        <td>Jig</td>
        <td>Juliet</td>
      </tr>
      <tr>
        <td>K</td>
        <td>King</td>
        <td>King</td>
        <td>King</td>
        <td>Kilo</td>
      </tr>
      <tr>
        <td>L</td>
        <td>London</td>
        <td>Love</td>
        <td>Love</td>
        <td>Lima</td>
      </tr>
      <tr>
        <td>M</td>
        <td>Monkey</td>
        <td>Mother</td>
        <td>Mike</td>
        <td>Mike</td>
      </tr>
      <tr>
        <td>N</td>
        <td>Nuts</td>
        <td>Nuts</td>
        <td>Nab</td>
        <td>November</td>
      </tr>
      <tr>
        <td>O</td>
        <td>Orange</td>
        <td>Orange</td>
        <td>Oboe</td>
        <td>Oscar</td>
      </tr>
      <tr>
        <td>P</td>
        <td>Pip</td>
        <td>Peter</td>
        <td>Peter</td>
        <td>Papa</td>
      </tr>
      <tr>
        <td>Q</td>
        <td>Queen</td>
        <td>Queen</td>
        <td>Queen</td>
        <td>Quebec</td>
      </tr>
      <tr>
        <td>R</td>
        <td>Robert</td>
        <td>Robert</td>
        <td>Roger</td>
        <td>Romeo</td>
      </tr>
      <tr>
        <td>S</td>
        <td>Sugar</td>
        <td>Sugar</td>
        <td>Sugar</td>
        <td>Sierra</td>
      </tr>
      <tr>
        <td>T</td>
        <td>Toc</td>
        <td>Tommy</td>
        <td>Tare</td>
        <td>Tango</td>
      </tr>
      <tr>
        <td>U</td>
        <td>Uncle</td>
        <td>Uncle</td>
        <td>Uncle</td>
        <td>Uniform</td>
      </tr>
      <tr>
        <td>V</td>
        <td>Vic</td>
        <td>Vic</td>
        <td>Victor</td>
        <td>Victor</td>
      </tr>
      <tr>
        <td>W</td>
        <td>William</td>
        <td>William</td>
        <td>William</td>
        <td>Whiskey</td>
      </tr>
      <tr>
        <td>X</td>
        <td>X-Ray</td>
        <td>X-Ray</td>
        <td>X-Ray</td>
        <td>X-Ray</td>
      </tr>
      <td>Y</td>
      <td>Yorker</td>
      <td>Yorker</td>
      <td>Yoke</td>
      <td>Yankee</td>
      <tr>
        <td>Z</td>
        <td>Zebra</td>
        <td>Zebra</td>
        <td>Zebra</td>
        <td>Zulu</td>
      </tr>
    </table>
  </div>
</template>

<script>
  import DivLinkButton from "../basic_comp/DivLinkButton";
  export default {
    // Same name as file-name. Change the name when altering the file-name
    name: 'FlightSchoolRAFAlphabet',
    components: {DivLinkButton},
    // Data needed in component, probably not necessary
    data () {
      return {
        // Data goes in here...

      }
    },
    // Methods needed in component, probably not necessary
    methods: {

      navigate_to: function (link) {

        location.replace(link);
      }
    }
  }
</script>

<style scoped>

</style>
