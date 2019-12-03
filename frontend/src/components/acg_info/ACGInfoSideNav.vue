<template>
  <div>
    <DivLinkButton v-bind="{routeName: 'AboutACG'}">
      <div class="heading">About Us</div>
    </DivLinkButton>

    <DivLinkButton v-bind="{routeName: 'ACGHistory'}">
      <div class="heading">History</div>
    </DivLinkButton>

    <DivLinkButton v-bind="{routeName: 'AboutACGCampaign'}">
      <div class="heading">Campaign</div>
    </DivLinkButton>

    <DivLinkButton v-bind="{routeName: 'ACGRanks'}">
      <div class="heading">Ranks</div>
    </DivLinkButton>

    <DivLinkButton v-bind="{routeName: 'ACGMedals'}">
      <div class="heading">Medals</div>
    </DivLinkButton>

    <div
      class="div-button heading"
      v-on:click="navigate_to('https://www.aircombatgroup.co.uk/field_book.pdf')">
      Field Book
    </div>
  </div>
</template>

<script>
import DivLinkButton from "../basic_comp/DivLinkButton"

export default {
  name: "ACGInfoSideNav",
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
