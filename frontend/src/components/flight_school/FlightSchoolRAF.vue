<template>
  <div class="flightSchool">
    <div class="text-align-center">
      <h1>No. 6 Operational Training Unit</h1>
      <img style="align-self: center;width: 70%; border-radius: 35px;" src="../../assets/images/flight_school_images/flight-school-header.jpg"/>
      <p>Welcome to No. 6 Operational Training Unit! Here you can find various tutorials and other stuff which will help you to improve your flying and fighting skills in the RAF. </p>
    </div>
    <div class="text-align-center">
      <h2>Theory</h2>
    </div>
    <div class="div-button-half float-left" v-on:click="navigate_to('https://www.theairtacticalassaultgroup.com/wiki/doku.php?id=britishflightmanuals')">
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
        <img title="IL-2 Sturmovik: Cliffs of Dover 'Blitz'" class="buttonPlatformImage" src="../../assets/images/flight_school_images/il2_gb_logo.png"/>
        <span class="buttonTitles">Aircraft Specifications</span>
        <br>
        <span>Ths is the IL-2 Great Battles Forum page for all aircraft included in the IL-2 Great Battles series. Scroll down to find the specifications for all RAF Aircraft included in the Battle of Bodenplatte expansion. </span>
      </div>
    </div>
    <DivLinkButton class="div-button-half float-left" v-bind="{routeName: 'FlightSchoolRAFOrganisation'}">
      <div class="inline-block">
        <img class="buttonImageThumbnail" src="../../assets/images/flight_school_images/raf/organisation.jpg"/>
        <span class="buttonTitles">Organisation</span>
        <br>
        <span>The RAF is not always logical and can sound, to the unfamiliar, like the rules of cricket as described on a novelty tea towel, so here is a short aide memoire.</span>
      </div>
    </DivLinkButton>
    <DivLinkButton class="div-button-half float-right" v-bind="{routeName: 'FlightSchoolRAFRanks'}">
      <div class="inline-block">
        <img class="buttonImageThumbnail" src="../../assets/images/flight_school_images/navigation/raf_rank.jpg"/>
        <span class="buttonTitles">Ranks & Appointments</span>
        <br>
        <span>Here you will get to know the RAF ranks, what tasks are reserved for each and how to address them properly. Of course these are all only for reference in our virtual flying world, but we like to know a few things to aid authenticity.</span>
      </div>
    </DivLinkButton>
    <DivLinkButton class="div-button-half float-left" v-bind="{routeName: 'FlightSchoolRAFAlphabet'}">
      <div class="inline-block">
        <img class="buttonImageThumbnail" src="../../assets/images/flight_school_images/navigation/raf_alphabet.jpg"/>
        <span class="buttonTitles">Phonetic Alphabet</span>
        <br>
        <span>Learn the The Royal Air Force's phonetic alphabet of World War II, particularly with the arrival of the Americans in 1943, which makes things a little tricky to be authentic, but we try our best to stick with the 1940 version. </span>
      </div>
    </DivLinkButton>
    <DivLinkButton class="div-button-half float-right" v-bind="{routeName: 'FlightSchoolRAFVocabulary'}">
      <div class="inline-block">
        <img class="buttonImageThumbnail" src="../../assets/images/flight_school_images/navigation/raf_vocabulary.png"/>
        <span class="buttonTitles">Wartime Vocabulary</span>
        <br>
        <span>Speak like the RAF personnel of the day with this guide to codewords and slang. Here is a list of the most common terms and meanings known. Some try to use this language in missions; for immersion purposes of course! </span>
      </div>
    </DivLinkButton>
    <div class="text-align-center">
      <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
      <h2>Practice</h2>
    </div>
    <div class="div-button-half float-right" v-on:click="navigate_to('https://www.youtube.com/watch?v=A4_nZHmdk9I&list=PLlUs-9KA-ShKV4wCgJbizzkGMbt8RCX9-')">
      <div class="inline-block">
        <img class="buttonImageThumbnail" src="../../assets/images/flight_school_images/navigation/Gunsight.jpg"/>
        <img title="IL-2 Sturmovik: Cliffs of Dover 'Blitz'" class="buttonPlatformImage" src="../../assets/images/flight_school_images/il2_cliffs_logo.png"/>
        <span class="buttonTitles">Convergence & Gunsight</span>
        <br>
        <span>Learn how to set up your guns to best deal Jerry a deadly blow with this tutorial by 'Spud'.</span>
      </div>
    </div>
    <div class="div-button-half float-right" v-on:click="navigate_to('https://www.youtube.com/watch?v=A4_nZHmdk9I&list=PLlUs-9KA-ShKV4wCgJbizzkGMbt8RCX9-')">
      <div class="inline-block">
        <img class="buttonImageThumbnail" src="../../assets/images/flight_school_images/general/gunnery.jpg"/>
        <img title="IL-2 Sturmovik: Great Battles" class="buttonPlatformImage" src="../../assets/images/flight_school_images/il2_gb_logo.png"/>
        <span class="buttonTitles">Reflector by Requiem</span>
        <br>
        <span>This lesson by Requiem on YouTube teaches you how to use the RAF reflector sight effectively in IL-2 Sturmovik: Great Battles.</span>
      </div>
    </div>
    <br><br><br><br><br><br><br><br>
    <div class="text-align-center">
      <h2>Hurricane Mk. I Rotol (100 octane)</h2>
    </div>
    <div class="div-button-half float-left" v-on:click="navigate_to('https://youtu.be/Dv4lWBIjkq8')">
      <div class="inline-block">
        <img class="buttonImageThumbnail" src="../../assets/images/flight_school_images/raf/start-up.jpg"/>
        <img title="IL-2 Sturmovik: Cliffs of Dover 'Blitz'" class="buttonPlatformImage" src="../../assets/images/flight_school_images/il2_cliffs_logo.png"/>
        <span class="buttonTitles">Start-up & Warm-up</span>
        <br>
        <span>A tutorial from Spud demonstrating the fit and proper method of pre-flight checks. Note this version is slightly outdated, but the basic principles still apply.</span>
      </div>
    </div>
    <div class="div-button-half float-right" v-on:click="navigate_to('https://youtu.be/sItxHmWZdlI')">
      <div class="inline-block">
        <img class="buttonImageThumbnail" src="../../assets/images/flight_school_images/raf/scramble.jpg"/>
        <img title="IL-2 Sturmovik: Cliffs of Dover 'Blitz'" class="buttonPlatformImage" src="../../assets/images/flight_school_images/il2_cliffs_logo.png"/>
        <span class="buttonTitles">Scramble Procedure</span>
        <br>
        <span>Want to get off the ground in a rush to go and deal the Boche some of what he deserves? Follow this tutorial from 'Bunny' to find out how. </span>
      </div>
    </div>
    <div class="div-button-half float-left" v-on:click="navigate_to('https://youtu.be/SyEx8x7umVc')">
      <div class="inline-block">
        <img class="buttonImageThumbnail" src="../../assets/images/flight_school_images/raf/landing.jpg"/>
        <img title="IL-2 Sturmovik: Cliffs of Dover 'Blitz'" class="buttonPlatformImage" src="../../assets/images/flight_school_images/il2_cliffs_logo.png"/>
        <span class="buttonTitles">Landing Procedure</span>
        <br>
        <span>Want to know how to put the Hurricane down in a perfect 3-point landing? Follow this tutorial from 'Dickie' to find out how to to get it right every time and impress the boss! </span>
      </div>
    </div>
    <div class="div-button-half float-right" v-on:click="navigate_to('https://youtu.be/BI4kQU1gvIs')">
      <div class="inline-block">
        <img class="buttonImageThumbnail" src="../../assets/images/flight_school_images/raf/fast-landing.jpg"/>
        <img title="IL-2 Sturmovik: Cliffs of Dover 'Blitz'" class="buttonPlatformImage" src="../../assets/images/flight_school_images/il2_cliffs_logo.png"/>
        <span class="buttonTitles">Fast Landing Procedure</span>
        <br>
        <span>Want to know how to put the Hurricane down in a rush after some combat? Follow this tutorial from 'Bunny' to find out how not to prang your precious kite! </span>
      </div>
    </div>
    <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
    <div class="text-align-center">
      <h2>Spitfire Mk. Ia (100 octane)</h2>
    </div>
    <div class="div-button-half float-left" v-on:click="navigate_to('https://youtu.be/b7WeKDbwZJU')">
      <div class="inline-block">
        <img class="buttonImageThumbnail" src="../../assets/images/flight_school_images/raf/spitfireI_takeoff.jpg"/>
        <img title="IL-2 Sturmovik: Cliffs of Dover 'Blitz'" class="buttonPlatformImage" src="../../assets/images/flight_school_images/il2_cliffs_logo.png"/>
        <span class="buttonTitles">Start-up & Takeoff</span>
        <br>
        <span>Keen to get your weapon into the skies to smash Jerry? Follow this tutorial from 'Dickie' to find out how to strap in and launch into the big blue. </span>
      </div>
    </div>
    <div class="div-button-half float-right" v-on:click="navigate_to('https://youtu.be/OI1qi-tGi7E')">
      <div class="inline-block">
        <img class="buttonImageThumbnail" src="../../assets/images/flight_school_images/raf/spit-landing.jpg"/>
        <img title="IL-2 Sturmovik: Cliffs of Dover 'Blitz'" class="buttonPlatformImage" src="../../assets/images/flight_school_images/il2_cliffs_logo.png"/>
        <span class="buttonTitles">Landing Procedure</span>
        <br>
        <span>Want to know how to put the Spitfire down gently? Follow this tutorial from 'Dickie' to find out how not to prang your precious kite! </span>
      </div>
    </div>
  </div>
</template>

<script>
  import DivLinkButton from "../basic_comp/DivLinkButton";
  export default {
    // Same name as file-name. Change the name when altering the file-name
    name: 'FlightSchoolRAF',
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

<!-- Add "scoped" attribute to limit CSS to this component only -->
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
