<template>
  <div>
    <div class="container">
      <MissionHeader v-bind="missionById"></MissionHeader>
      <button class="margin-top-bottom" v-if="show_add_report_button" v-on:click="addReport">Add new report</button>
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

    this.load_mission();

  },
  data: function () {
    return {

      show_add_report_button: false
    }
  },
  computed: {

    missionById: function() {

      return this.findByKey("missions", "id", this.$route.params.mission_id);
    },

    ...mapGetters("missionStore", [
      "findByKey",
    ])
  },
  methods: {

    load_mission: async function() {

      if(this.findByKey("missions", "id", this.$route.params.mission_id) === undefined){
        await this.$store.dispatch('missionStore/loadStoreData',
          {
            caller: this.$options.name,
            call_object: {
              view: "campaign_mission_info",
              campaign_id: this.$route.params.campaign_id
            },
            data_array_name: "missions"
          }
        )
        .catch(error => {
          console.log(error.message);
        });

      }
      this.check_add_report_button();

    },

    check_add_report_button: async function() {

      console.log("CHECKING");

      var user_status = false;
      await this.$auth.getUserStatus(this.$options.name)
        .then(response => {
          //Member is active (status = 0)
          user_status = response === 0;
        })
        .catch(error => {
          console.log(error.message);
        });
      this.show_add_report_button = user_status &&
        this.findByKey("missions", "id", this.$route.params.mission_id).mission_status === 1;

    },

    addReport: function () {

      console.log(this.$options.name+": Pushing to -> {name: AddReport");
      this.$router.push({name: "AddReport"});
      //DEBUG

    }
  }

}
</script>

<style scoped>

.margin-top-bottom{
  margin: 5px 0px;
}

</style>
