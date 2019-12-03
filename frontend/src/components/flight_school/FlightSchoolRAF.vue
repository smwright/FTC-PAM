<template>
  <div>
  <div class="div-button-half float-left" v-on:click="navigate_to('https://www.youtube.com/watch?v=A4_nZHmdk9I&list=PLlUs-9KA-ShKV4wCgJbizzkGMbt8RCX9-')">
    <div class="inline-block">
      <img class="buttonImageThumbnail" src="../../assets/images/flight_school_images/navigation/FMB.jpg"/>
      <span class="buttonTitles">TF Wiki Flight Manuals</span>
      <br>
      <span>Ths is the Wiki page of Team Fusion (the people developing the game), where you can find all information about the aircraft included in IL-2 Sturmovik: Cliffs of Dover 'Blitz'. </span>
    </div>
  </div>
  </div>
</template>

<script>
export default {
  // Same name as file-name. Change the name when altering the file-name
  name: 'FlightSchoolRAF',
  // Data needed in component, probably not necessary 
  data () {
    return {
      // Data goes in here...
      
    }
  },
  // Methods needed in component, probably not necessary
  methods: {

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
