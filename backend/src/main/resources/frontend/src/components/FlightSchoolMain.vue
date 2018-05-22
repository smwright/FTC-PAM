<template>
  <div class="flightSchool">
    <!--Put the html and content for the lessons and the flight school lessons here.-->
    <!--Please put every piece of the lesson page in proper html elements:-->
    <!--<p></p>, <h1></h1>, etc...-->
    <p>FLIGHT SCHOOL ENTRY PAGE</p>
    <div>
      <router-view name="lessoncontainer"></router-view>
    </div>
    
  </div>
</template>

<script>
export default {
  // Same name as file-name. Change the name when altering the file-name
  name: 'FlightSchoolMain',
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
/*Style will be added later. No need to work on this yet.*/
</style>
