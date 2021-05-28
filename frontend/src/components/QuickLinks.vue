<template>
  <div class="">
    <h2>Quick-links</h2>

    <DivLinkButton
      class=""
      route-name="ACGJoining"
    >
      <h4 class="heading">Joining ACG</h4>
      <p class="text-align-justify">
        We are welcoming to new pilots of any standard or experience, even if you've never flown before. For more info about
        joining click here.
      </p>
    </DivLinkButton>

    <DivLinkButton
      class=""
      route-name="ACGComms"
    >
      <h4 class="heading">Communications</h4>
      <p class="text-align-justify">
        ACG has its own Teamspeak server for voice communication. We also have a discord channel for quick questions and
        idle chit-chat. Click here for more info about it.
      </p>
    </DivLinkButton>

  </div>
</template>

<script>
import DivLinkButton from './basic_comp/DivLinkButton'
  ''
export default {
  name: "QuickLinks",
  components: {
    DivLinkButton
  }
}
</script>

<style scoped>

</style>
