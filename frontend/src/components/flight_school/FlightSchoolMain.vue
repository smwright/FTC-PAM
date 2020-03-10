<template>
  <div class="flightSchool">
    <div class="text-align-center">
    <h1>Flight School</h1>
      <p>Welcome to the ACG Flight School! Here you can find various tutorials and other stuff which will help you to improve your flying and fighting skills. These guides have either been created by ACG members or collected from around the internet to form a comprehensive library of information that any budding virtual pilot can use to get themselves into the sky and return to base safely. </p>
      <p>On the left hand side of the Flight School pages, there will always be the sidebar which lists the categories of tutorials which you can find on here. These are split according to factions. On this page you will find all kinds of tutorials that will help you with any aspect of virtual flying, regardless of the faction you choose to fly with.</p>
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
    <div class="div-button-half float-left" v-on:click="routeTo('https://www.youtube.com/watch?v=C4-TvPxLioY&list=PLnyigzFtHeNqmQMVhq1Shl972CPX4O-0B')">
      <div class="inline-block">
        <img class="buttonImageThumbnail" src="../../assets/images/flight_school_images/general/requiem_flight.jpg"/>
        <img title="IL-2 Sturmovik: Great Battles" class="buttonPlatformImage" src="../../assets/images/flight_school_images/il2_gb_logo.png"/>
        <span class="buttonTitles">Flight by Requiem</span>
        <br>
        <span>This series of lessons by Requiem on YouTube teaches you the basic prenciples of flying in IL-2 Sturmovik: Great Battles.</span>
      </div>
    </div>
    <div class="div-button-half float-right" v-on:click="routeTo('https://www.youtube.com/watch?v=UoADOlgfW6Q&list=PLnyigzFtHeNq7NoAEMS9KSnQcTd7LOsAC')">
      <div class="inline-block">
        <img class="buttonImageThumbnail" src="../../assets/images/flight_school_images/general/requiem_engines.jpg"/>
        <img title="IL-2 Sturmovik: Great Battles" class="buttonPlatformImage" src="../../assets/images/flight_school_images/il2_gb_logo.png"/>
        <span class="buttonTitles">Engines by Requiem</span>
        <br>
        <span>This second series of lessons by Requiem on YouTube teaches you how to properly manage your engine in IL-2 Sturmovik: Great Battles.</span>
      </div>
    </div>
    <div class="div-button-half float-left" v-on:click="routeTo('https://www.youtube.com/watch?v=zbyGOd6NwME&list=PLnyigzFtHeNr9zTkpxyD0ksFD3CwLa2UE')">
      <div class="inline-block">
        <img class="buttonImageThumbnail" src="../../assets/images/flight_school_images/general/requiem_maneuvers.jpg"/>
        <img title="IL-2 Sturmovik: Great Battles" class="buttonPlatformImage" src="../../assets/images/flight_school_images/il2_gb_logo.png"/>
        <span class="buttonTitles">Maneuvers by Requiem</span>
        <br>
        <span>This third series of lessons by Requiem on YouTube teaches you the basic principles of fighter pilot maneuvers in IL-2 Sturmovik: Great Battles.</span>
      </div>
    </div>
    <div class="div-button-half float-right" v-on:click="routeTo('https://www.youtube.com/watch?v=1jDeJDL9jTE&list=PLnyigzFtHeNooN19kyhiT2UqojQPacCcE')">
      <div class="inline-block">
        <img class="buttonImageThumbnail" src="../../assets/images/flight_school_images/general/requiem_weapons.jpg"/>
        <img title="IL-2 Sturmovik: Great Battles" class="buttonPlatformImage" src="../../assets/images/flight_school_images/il2_gb_logo.png"/>
        <span class="buttonTitles">Weapons by Requiem</span>
        <br>
        <span>This fourth series of lessons by Requiem on YouTube teaches you how to use special weapons against air and ground targets in IL-2 Sturmovik: Great Battles.</span>
      </div>
    </div>
    <div class="div-button-half float-left" v-on:click="routeTo('https://www.youtube.com/watch?v=rckFuhV3BlM&list=PLnyigzFtHeNo8h6EJLrer4zIDfCHCo8XY')">
      <div class="inline-block">
        <img class="buttonImageThumbnail" src="../../assets/images/flight_school_images/general/requiem_dogfights.jpg"/>
        <img title="IL-2 Sturmovik: Great Battles" class="buttonPlatformImage" src="../../assets/images/flight_school_images/il2_gb_logo.png"/>
        <span class="buttonTitles">Dogfighting by Requiem</span>
        <br>
        <span>This fifth series of lessons by Requiem on YouTube teaches you how become competitive in dogfights against other players in IL-2 Sturmovik: Great Battles.</span>
      </div>
    </div>
    <div class="div-button-half float-right" v-on:click="routeTo('https://www.youtube.com/watch?v=PZpS0SLZJVU&list=PLnyigzFtHeNpq6ozRQaIfU_fgOs9mBKH4')">
      <div class="inline-block">
        <img class="buttonImageThumbnail" src="../../assets/images/flight_school_images/general/requiem_shooting.jpg"/>
        <img title="IL-2 Sturmovik: Great Battles" class="buttonPlatformImage" src="../../assets/images/flight_school_images/il2_gb_logo.png"/>
        <span class="buttonTitles">Shooting by Requiem</span>
        <br>
        <span>This sixth series of lessons by Requiem on YouTube teaches you how to use the various gunsights and how to land deflecive shots on enemy aircraft in IL-2 Sturmovik: Great Battles.</span>
      </div>
    </div>
    <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
    <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
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
