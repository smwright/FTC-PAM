<template>
  <h2>RAF Vocabulary</h2>
</template>

<script>
  import DivLinkButton from "../basic_comp/DivLinkButton";
  export default {
    // Same name as file-name. Change the name when altering the file-name
    name: 'FlightSchoolRAFVocabulary',
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
