<template>
  <div>
    <DivLinkButton v-bind="{routeName: 'FlightSchoolMain'}">
      <div class="heading">General</div>
    </DivLinkButton>

    <DivLinkButton v-bind="{routeName: 'FlightSchoolRAF'}">
      <div class="heading">Royal Air Force</div>
    </DivLinkButton>

    <DivLinkButton v-bind="{routeName: 'FlightSchoolLW'}">
      <div class="heading">Luftwaffe</div>
    </DivLinkButton>

    <DivLinkButton v-bind="{routeName: 'FlightSchoolVVS'}">
      <div class="heading">Soviet Air Forces</div>
    </DivLinkButton>

    <DivLinkButton v-bind="{routeName: 'FlightSchoolUSAAF'}">
      <div class="heading">United States Army Air Force</div>
    </DivLinkButton>

    <DivLinkButton v-bind="{routeName: 'FlightSchoolRAI'}">
      <div class="heading">Regia Aeronautica Italiana</div>
    </DivLinkButton>


  </div>
</template>

<script>
  import DivLinkButton from "../basic_comp/DivLinkButton"

  export default {
    name: "FlightSchoolSideNav",
    components: {
      DivLinkButton
    },
    methods: {

      navigate_to: function (link) {

        location.replace(link);
      }
    }

  }
</script>

<style scoped>

</style>
