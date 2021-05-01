<template>
  <div class="flightSchool">
    <div class="text-align-center">
      <h1>Fliegerausbildungsregiment 14</h1>
      <img style="align-self: center;width: 50%; border-radius: 35px;" src="../../assets/images/flight_school_images/lw/1200px-Arado_Ar-96.jpg"/>
      <p>Welcome to Fliegerausbildungsregiment 14! Here you can find various tutorials and other stuff which will help you to improve your flying and fighting skills in the Luftwaffe. </p>
    </div>
    <div class="text-align-center">
      <h2>Theory</h2>
    </div>
    <div class="div-button-half float-left" v-on:click="navigate_to('https://www.theairtacticalassaultgroup.com/wiki/doku.php?id=germanflightmanuals')">
      <div class="inline-block">
        <img class="buttonImageThumbnail" src="../../assets/images/flight_school_images/raf/TF-Manuals.jpg"/>
        <img title="IL-2 Sturmovik: Cliffs of Dover 'Blitz'" class="buttonPlatformImage" src="../../assets/images/flight_school_images/il2_cliffs_logo.png"/>
        <span class="buttonTitles">TF Wiki Flight Manuals</span>
        <br>
        <span>This is the Wiki page of Team Fusion (the people developing the game), where you can find all information about the aircraft included in IL-2 Sturmovik: Cliffs of Dover 'Blitz'. </span>
      </div>
    </div>
    <div class="div-button-half float-right" v-on:click="navigate_to('https://forum.il2sturmovik.com/topic/25993-aircraft-flight-and-technical-specifications-and-operational-details/')">
      <div class="inline-block">
        <img class="buttonImageThumbnail" src="../../assets/images/flight_school_images/raf/TF-Manuals.jpg"/>
        <img title="IL-2 Sturmovik: Great Battles" class="buttonPlatformImage" src="../../assets/images/flight_school_images/il2_gb_logo.png"/>
        <span class="buttonTitles">Aircraft Specifications</span>
        <br>
        <span>Ths is the IL-2 Great Battles Forum page for all aircraft included in the IL-2 Great Battles series. Scroll down to find the specifications for all LW Aircraft included in the expansions. </span>
      </div>
    </div>
    <div class="div-button-half float-left" v-on:click="navigate_to('https://www.theairtacticalassaultgroup.com/wiki/doku.php?id=germanflightmanuals')">
      <div class="inline-block">
        <img class="buttonImageThumbnail" src="../../assets/images/flight_school_images/lw/officers.jpg"/>
        <span class="buttonTitles">Organisation</span>
        <br>
        <span>This is the Wiki page of Team Fusion (the people developing the game), where you can find all information about the aircraft included in IL-2 Sturmovik: Cliffs of Dover 'Blitz'. </span>
      </div>
    </div>
    <div class="div-button-half float-right" v-on:click="navigate_to('https://forum.il2sturmovik.com/topic/25993-aircraft-flight-and-technical-specifications-and-operational-details/')">
      <div class="inline-block">
        <img class="buttonImageThumbnail" src="../../assets/images/flight_school_images/lw/ranks.jpg"/>
        <span class="buttonTitles">Ranks & Appointments</span>
        <br>
        <span>Ths is the IL-2 Great Battles Forum page for all aircraft included in the IL-2 Great Battles series. Scroll down to find the specifications for all LW Aircraft included in the expansions. </span>
      </div>
    </div>
  </div>
</template>

<script>
  import DivLinkButton from "../basic_comp/DivLinkButton";
  export default {
    // Same name as file-name. Change the name when altering the file-name
    name: 'FlightSchoolLW',
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

  .buttonTitles {
    font-size: xx-large;
    font-weight: bold;
    padding-bottom: 10%;
  }

  .buttonImageThumbnail {
    border-radius: 25px;
    width: 24%;
    height: 24%;
    float: left;
    margin-top: 1%;
    margin-right: 4%;
    min-width: 24%;
  }

  .buttonPlatformImage {
    width: 5%;

  }</style>
