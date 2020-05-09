<template>
  <div>
    <div class="container">
      <MissionHeader v-bind="missionById"></MissionHeader>
      <HideableDiv
        v-if="missionById !== undefined"
        v-bind:changing-button="true"
      >
        <template slot="buttonVisible">
          <button>Hide help</button>
          <button class="margin-top-bottom" v-if="show_add_report_button" v-on:click.stop="addReport">Add new report</button>

        </template>
        <template slot="buttonHidden">
          <button>Show help</button>
          <button class="margin-top-bottom" v-if="show_add_report_button" v-on:click.stop="addReport">Add new report</button>

        </template>
        <MissionHelp v-bind:mission_name="missionById.name"></MissionHelp>
      </HideableDiv>
    </div>
    <router-view name="mission_lobby_content"></router-view>
  </div>
</template>

<script>
import MissionHeader from "./MissionHeader";
import MissionHelp from "./MissionLobbyHelp"
import HideableDiv from "../basic_comp/HideableDiv"
import { mapGetters } from "vuex"

export default {
  name: "MissionLobby",
  components: {
    MissionHeader,
    HideableDiv,
    MissionHelp
  },
  mounted () {

    if(this.findByKey("missions", "id", this.$route.params.mission_id) === undefined){
      this.$store.dispatch('missionStore/loadStoreData',
        {
          caller: this.$options.name,
          call_object: {
            view: "campaign_mission_info",
            campaign_id: this.$route.params.campaign_id
          },
          data_array_name: "missions"
        }
      ).catch(error => {
        console.log(error.message);
      });
    }

  },
  computed: {

    missionById: function() {

      return this.findByKey("missions", "id", this.$route.params.mission_id);
    },

    show_add_report_button: async function() {

      var user_status = false;
      this.$auth.getUserStatus(this.$options.name)
        .then(response => {
          user_status = response === 0;
        })
        .catch(error => {
          console.log(error.message);
        });
      return (user_status && this.findByKey("missions", "id", this.$route.params.mission_id).mission_status === 1);


    },

    ...mapGetters("missionStore", [
      "findByKey",
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

.margin-top-bottom{
  margin: 5px 0px;
}

</style>
