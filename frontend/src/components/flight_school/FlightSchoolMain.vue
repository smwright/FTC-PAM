<template>
  <div class="flightSchool">
    <div class="text-align-center">
    <h1>Flight School</h1>
      <img style="align-self: center;width: 70%; border-radius: 35px;" src="../../assets/images/flight_school_images/flight-school-header.jpg"/>
      <p>Welcome to the ACG Flight School! Here you can find various tutorials and other stuff which will help you to improve your flying and fighting skills. </p>
    </div>
    <div class="text-align-center">
      <h2>Theory</h2>
    </div>
    <DivLinkButton class="div-button-half float-left" v-bind="{routeName: 'FlightSchoolBasicNavigation'}">
      <div>
        <img class="buttonImageThumbnail" src="../../assets/images/flight_school_images/navigation/basic_nav_thumb.png"/>
        <span class="buttonTitles">Navigation for Beginners </span>
        <br>
        <span>This walk-through from 'Grey' shows you how to get to somewhere using the instruments and a little maths, without magnetic deviation (see the advanced navigation). </span>
      </div>
    </DivLinkButton>
    <DivLinkButton class="div-button-half float-right" v-bind="{routeName: 'FlightSchoolAdvancedNavigation'}">
      <div class="inline-block">
        <img class="buttonImageThumbnail" src="../../assets/images/flight_school_images/navigation/advanced_nav01.jpg"/>
        <span class="buttonTitles">Advanced Navigation</span>
        <br>
        <span>This lesson from 'Robo' teaches navigation as it was typically done by fighter pilots during the war. Although this lesson focusses on the Hawker Hurricane, the methods can equally be applied to the Luftwaffe aircraft. </span>
      </div>
    </DivLinkButton>
    <div class="div-button-half float-left" v-on:click="navigate_to('https://youtu.be/4J4kiMuYskg')">
      <div class="inline-block">
        <img class="buttonImageThumbnail" src="../../assets/images/flight_school_images/general/formation.jpg"/>
        <span class="buttonTitles">Formation Flying</span>
        <br>
        <span>'Miki', our resident fighter pilot, explains the basics of formation flying and staying with your leader through combat manoeuvres. This is demonstrated in the Hawker Hurricane, but this skill can be equally applied to all aircraft. </span>
      </div>
    </div>
    <div class="div-button-half float-right" v-on:click="navigate_to('https://youtu.be/lL4tKIddW5s')">
      <div class="inline-block">
        <img class="buttonImageThumbnail" src="../../assets/images/flight_school_images/general/stalls-spins.jpg"/>
        <span class="buttonTitles">Stalls and Spins</span>
        <br>
        <span>Stalls and spins can be daunting for new or inexperienced pilots. 'Spud' explains the causes for these events, and how to get out of them safely.</span>
      </div>
    </div>
    <div class="div-button-half float-left" v-on:click="routeTo('https://www.youtube.com/watch?v=kRVFQs2XYy4')">
      <div class="inline-block">
        <img class="buttonImageThumbnail" src="../../assets/images/flight_school_images/general/gunnery.jpg"/>
        <span class="buttonTitles">Gunnery Basics</span>
        <br>
        <span>This 1943 Navy training film was used to enhance in-classroom learning of Navy pilots. The basics of aerial gunnery shown are applicable in-game as well!</span>
      </div>
    </div>
    <div class="div-button-half float-right" v-on:click="navigate_to('https://drive.google.com/file/d/18ftOQUSQNBh8pPVcjylyt-j3t5PpUDRu/view')">
      <div class="inline-block">
        <img class="buttonImageThumbnail" src="../../assets/images/flight_school_images/general/aircraft_recognition.jpg"/>
        <img title="IL-2 Sturmovik: Cliffs of Dover 'Blitz'" class="buttonPlatformImage" src="../../assets/images/flight_school_images/il2_cliffs_logo.png"/>
        <span class="buttonTitles">Aircraft Identification</span>
        <br>
        <span>This guide made by Marco from ATAG shows you how to easily recognise the type of an aircraft at a glance. Look out for the characteristic features of each aircraft and you will find that you will quickly be able to identify them!</span>
      </div>
    </div>
    <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
    <br><br><br><br><br><br><br><br>
    <div class="text-align-center">
      <h2>Controls</h2>
    </div>
    <div class="div-button-half float-left" v-on:click="navigate_to('https://theairtacticalassaultgroup.com/forum/showthread.php?t=10158')">
      <div class="inline-block">
        <img class="buttonImageThumbnail" src="../../assets/images/flight_school_images/general/bomber_gunner.jpg"/>
        <img title="IL-2 Sturmovik: Cliffs of Dover 'Blitz'" class="buttonPlatformImage" src="../../assets/images/flight_school_images/il2_cliffs_logo.png"/>
        <span class="buttonTitles">Bomber Gunnery</span>
        <br>
        <span>This is a topic on the ATAG Forum which shows you what controls to set up in order to use the rear gunner position in bombers. It will give you the ability to jump into any gunner position and be ready for the action. </span>
      </div>
    </div>
    <div class="div-button-half float-right" v-on:click="navigate_to('https://www.youtube.com/watch?v=flpz90gmHGo')">
      <div class="inline-block">
        <img class="buttonImageThumbnail" src="../../assets/images/flight_school_images/general/info_box.jpg"/>
        <img title="IL-2 Sturmovik: Cliffs of Dover 'Blitz'" class="buttonPlatformImage" src="../../assets/images/flight_school_images/il2_cliffs_logo.png"/>
        <span class="buttonTitles">Engine Controls Box</span>
        <br>
        <span>Here 'Heiden' from 3./JG51 explains how you can change your engine information indicator from analog to digital. He also looks at other info window topics.</span>
      </div>
    </div>
    <br><br><br><br><br><br><br><br>
    <div class="text-align-center">
      <h2>Full Mission Builder</h2>
    </div>
    <div class="div-button-half float-left" v-on:click="navigate_to('https://www.youtube.com/watch?v=A4_nZHmdk9I&list=PLlUs-9KA-ShKV4wCgJbizzkGMbt8RCX9-')">
      <div class="inline-block">
        <img class="buttonImageThumbnail" src="../../assets/images/flight_school_images/navigation/FMB.jpg"/>
        <img title="IL-2 Sturmovik: Cliffs of Dover 'Blitz'" class="buttonPlatformImage" src="../../assets/images/flight_school_images/il2_cliffs_logo.png"/>
        <span class="buttonTitles">Boyezee's Guide</span>
        <br>
        <span>'Boyezee' shows you the basics to build your own missions in Cliffs of Dover. If you have any questions for 'Boyezee', or need any help, post your question in our forums.</span>
      </div>
    </div>
    <div>
      <router-view name="lessoncontainer"></router-view>
    </div>

  </div>
</template>

<script>
import DivLinkButton from "../basic_comp/DivLinkButton";
export default {
  // Same name as file-name. Change the name when altering the file-name
  name: 'FlightSchoolMain',
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

  }

</style>
