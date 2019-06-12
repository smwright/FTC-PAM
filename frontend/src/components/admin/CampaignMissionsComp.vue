<template>

    <div>

      <SwitchableDiv>
        <template slot="buttonStateA">
            <MissionHeader
              class="div-button"
              v-bind="{
              real_date: real_date,
              name: mission_name,
              hist_date: hist_date,
              mission_status: mission_status
             }"
            >
            </MissionHeader>
        </template>
        <template slot="contentStateA">

        </template>

        <template slot="buttonStateB">
            <MissionHeader
              class="div-button"
              v-bind="{
              real_date: real_date,
              name: mission_name,
              hist_date: hist_date,
              mission_status: mission_status
             }"
            >
            </MissionHeader>
        </template>
        <template slot="contentStateB">
          <div class="container">
            <!--Name-->
            <div>
              <label>Name</label>
              <input v-model="mission_name">
            </div>

            <!--Scheduled date-->
            <div>
              <label>Scheduled date:</label>
              <date-picker
                v-model="real_date"
                lang="en"
                type="datetime"
                format="YYYY-MM-DD"
                value-type="format"
                v-bind:clearable="false">
              </date-picker>
            </div>

            <!--Historic date-->
            <div>
              <label>Historic date:</label>
              <date-picker
                v-model="hist_date"
                lang="en"
                type="datetime"
                format="YYYY-MM-DD HH:mm"
                value-type="format"
                v-bind:time-picker-options="{ start: '00:00', step: '00:10', end: '23:30' }"
                v-bind:clearable="false">
              </date-picker>
            </div>

            <!--Campaign status-->
            <div>
              <label>Campaign status</label>
              <select v-model="mission_status">
                <option v-for="(m_status, index) in missionStatus" v-bind:value="index">
                  {{ m_status }}
                </option>
              </select>
            </div>

            <!--Briefings-->
            <HideableDiv v-bind:changing-button="true">
              <template slot="buttonHidden">
                <button>Show briefing form</button>
              </template>
              <template slot="buttonVisible">
                <button>Hide briefing form</button>
              </template>
              <div>
                <template v-for="(faction, index) in factionStatus">
                  <input type="radio" v-bind:value="index" v-model="briefing_faction">
                  <label v-if="index === 0">General</label>
                  <label>{{faction.long}}</label>
                </template>
                <span>b-id: {{ selected_briefing }}</span>
              </div>
              <div>
                <textarea v-model="mission_briefing" class="textarea-style"></textarea>
              </div>
            </HideableDiv>

            <!--Delete button-->
            <div class="clearfix">
              <button class="float-right" v-on:click="deleteMission">Delete mission</button>
            </div>
          </div>


        </template>

      </SwitchableDiv>

    </div>
</template>

<script>
import DatePicker from 'vue2-datepicker'
import HideableDiv from "../basic_comp/HideableDiv"
import statConv from "../../resource/statusConverter"
import stringConv from "../../resource/stringConverter"
import SwitchableDiv from "../basic_comp/SwitchableDiv"
import MissionHeader from "../campaign/MissionHeader"

export default {
  name: "CampaignMissionsComp",
  components: {
    SwitchableDiv,
    DatePicker,
    HideableDiv,
    MissionHeader
  },
  mixins: [
    statConv,
    stringConv
  ],
  props: {
    mission_id: {
      type: Number,
      default: 0
    }
  },
  data(){
    return {
      timePickerOptions:{
        start: '00:00',
        step: '00:30',
        end: '23:30'
      },
      briefing_faction: 0,
      selected_briefing: null
    }
  },
  computed: {
    mission_name: {
      get () {

        var mission = this.$store.getters['campaignAdmin/missionsById'](this.mission_id);
        return (mission !== undefined) ? mission.name : "";
      },
      set (value) {

        this.$store.commit('campaignAdmin/updateValue',
          {
            array_name: "missions",
            id_column_name: "id",
            id_column_value: this.mission_id,
            update_column_name: "name",
            update_column_value: value
          });
      }
    },

    real_date: {
      get () {

        var mission = this.$store.getters['campaignAdmin/missionsById'](this.mission_id);
        return (mission !== undefined) ? mission.real_date : "";
      },
      set (value) {

        this.$store.commit('campaignAdmin/updateValue',
          {
            array_name: "missions",
            id_column_name: "id",
            id_column_value: this.mission_id,
            update_column_name: "real_date",
            update_column_value: value
          });
      }
    },

    hist_date: {
      get () {

        var mission = this.$store.getters['campaignAdmin/missionsById'](this.mission_id);
        return (mission !== undefined) ? mission.hist_date : "";
      },
      set (value) {

        this.$store.commit('campaignAdmin/updateValue',
          {
            array_name: "missions",
            id_column_name: "id",
            id_column_value: this.mission_id,
            update_column_name: "hist_date",
            update_column_value: value
          });
      }
    },

    mission_status: {
      get () {

        var mission = this.$store.getters['campaignAdmin/missionsById'](this.mission_id);
        return (mission !== undefined) ? mission.mission_status : "";
      },
      set (value) {

        this.$store.commit('campaignAdmin/updateValue',
          {
            array_name: "missions",
            id_column_name: "id",
            id_column_value: this.mission_id,
            update_column_name: "mission_status",
            update_column_value: value
          });
      }
    },

    mission_briefing: {

      get() {
        var briefing = this.$store.getters['campaignAdmin/briefingByMissionIdAndFaction']
        ({id: this.mission_id, faction: this.briefing_faction});
        return (briefing.length) ?  this.decodeHTML(briefing[0].text) : '';
      },
      set (value) {

        this.$store.commit('campaignAdmin/updateBriefing',
          {
            campaign_id: parseInt(this.$route.params.campaign_id),
            mission_id: this.mission_id,
            faction: this.briefing_faction,
            text: this.encodeHTML(value)
          });
      }
    }
  },

  methods: {

    deleteMission: function () {

      if(!confirm("Do you want to delete "+this.mission_name+"?")) {
        return;
      }

      this.$store.commit('campaignAdmin/deleteMission', {id: this.mission_id});
    }
  },

  sendData: async function () {


  }
}
</script>

<style scoped>

div {
  margin: 2px 0px;
}

</style>
