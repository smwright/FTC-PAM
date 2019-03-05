<template>
  <div>
    <div class="heading">Briefing</div>
    <DivLinkButton
      class="heading"
      v-for="briefing in briefing_info"
      v-bind:key="briefing.id"
      v-bind="{routeName: 'Briefing', routeParams: {briefing_faction: briefing.faction}}"
    >
      {{ factionStatus[briefing.faction].long }}
    </DivLinkButton>
  </div>
</template>

<script>
import DivLinkButton from "../basic_comp/DivLinkButton"
import statConv from "../../resource/statusConverter"

export default {
  name: "BriefingSideNav",
  components: {DivLinkButton},
  mixins: [statConv],
  mounted () {

    this.$dbCon.requestViewData(this.$options.name, {view:"briefing", mission_id:this.$route.params.mission_id})
      .then(response => {
        this.briefing_info = response;
      })
      .catch(error => {
        console.log(error.message);
      });
  },
  data () {
    return {
      briefing_info: null
    }
  },
}
</script>

<style scoped>

</style>
