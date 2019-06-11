<template>
  <div>
    <div>
      <MissionHeader v-bind="missionById(this.$route.params.mission_id)"></MissionHeader>
    </div>
    <div>
      <p>Mission information and buttons:</p>
      <button v-if="show_add_report_button" v-on:click="addReport">Add report</button>

    </div>
    <router-view name="mission_lobby_content"></router-view>
  </div>
</template>

<script>
import MissionHeader from "./MissionHeader";
import { mapGetters } from "vuex"

export default {
  name: "MissionLobby",
  components: {
    MissionHeader,
  },
  mounted () {

    // Load mission info
    this.$store.dispatch('missionStore/loadMission', {caller: this.$options.name, mission_id: this.$route.params.mission_id})
      .then(response => {

        // Load user info
        return this.$auth.getUserStatus(this.$options.name);
      })
      .then(response => {

        this.show_add_report_button = (response === 0 && this.missionStatusById(this.$route.params.mission_id) === 1);
      })
      .catch(error => {
        console.log(error.message);
      });

  },
  data () {
    return {
      show_add_report_button: false
    }
  },
  computed: {

    ...mapGetters("missionStore", [
      "missionById",
      "missionStatusById"
    ])
  },
  methods: {

    addReport: function () {

      console.log(this.$options.name+": Pushing to -> {name: AddReport");
      this.$router.push({name: "AddReport"});
      //DEBUG

    }
  }

}
</script>

<style scoped>

</style>
