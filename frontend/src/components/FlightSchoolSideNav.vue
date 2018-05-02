<template>
  <div>
    <!--Use the following code to create the links to the different pages of flight -->
    <!--school lessons.-->
    <!--<router-link :to="{ name: 'PUT_LESSON_NAME HERE' }">TEXT_TO_SHOW_IN_SIDENAV</router-link>-->
    <!--Add seperators <p>General</p>, <p>Royal Air Force</p>, etc.. as needed-->
   <p>CATEGORY</p>
   <router-link :to="{ name: 'PUT_LESSON_NAME HERE' }">LESSON</router-link>
   </div>
</template>

<script>

export default {
  // Same name as file-name.
  name: 'FlightSchoolSideNav',
  // Data needed in component, probably not necessary 
  data () {
    return {
      
    }
  },
  // Methods needed in component, probably not necessary
  methods: {

  }
}

</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style>
/*Styling will be added later*/
</style>
