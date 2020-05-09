<template>
  <div>
    <DivLinkButton v-bind="{routeName: 'AboutACG'}">
      <div class="heading">About us</div>
    </DivLinkButton>

    <DivLinkButton v-bind="{routeName: 'ACGHistory'}">
      <div class="heading">History</div>
    </DivLinkButton>

    <DivLinkButton v-bind="{routeName: 'ACGJoining'}">
      <div class="heading">Joining ACG</div>
    </DivLinkButton>

    <DivLinkButton v-bind="{routeName: 'ACGStructure'}">
      <div class="heading">ACG Structure</div>
    </DivLinkButton>

    <DivLinkButton v-bind="{routeName: 'ACGComms'}">
      <div class="heading">Communications</div>
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
import HideableDiv from "../basic_comp/HideableDiv"

export default {
  name: "ACGInfoSideNav",
  components: {
    DivLinkButton,
    HideableDiv
  },
  methods: {

    navigate_to: function (link) {

      location.replace(link);
    }
  }

}
</script>

<style scoped>

.subcontent-buttons{
  font-size: 1em;
  margin: 2px 0px 0px 15px;
  width: calc(100% - 15px - 26px);
}

</style>
