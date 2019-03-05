<template>
  <div>
    <MissionHeader v-bind="this.mission_info"></MissionHeader>
    <router-view name="mission_lobby_content"></router-view>
  </div>
</template>

<script>
import MissionHeader from "./MissionHeader";

export default {
  name: "MissionLobby",
  components: {
    MissionHeader,
  },
  mounted () {

    this.$dbCon.requestViewData(this.$options.name, {view:"campaign_mission_info", id:this.$route.params.mission_id})
      .then(response => {
        this.mission_info = this.$dbCon.nestData(response)[0];
      })
      .catch(error => {
        console.log(error.message);
      });
  },
  data () {
    return {
      mission_info: null
    }
  },
}
</script>

<style scoped>

</style>
