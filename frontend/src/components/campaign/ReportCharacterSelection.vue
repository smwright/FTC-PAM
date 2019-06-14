<template>
  <div>
    <div class="heading">CHARACTER SELECTION</div>
    <p class="container">Choose one of the characters below for your report. More info to be put here....</p>
    <!--<p>Unit: {{ JSON.stringify(user_unit) }}</p>-->
    <!--<p>Mission:  {{ missionById(this.$route.params.mission_id) }}</p>-->

    <template v-if="info_loaded">
      <!--<div v-for="character in selectableCharacters(user_unit.depl_unit_id, user_unit.faction,-->
            <!--missionById(this.$route.params.mission_id).hist_date)">-->
        <div v-for="character in selectableCharacters(depl_unit_id, faction, mission_hist_date)">
        <!--<div>{{ JSON.stringify(character) }}</div>-->

        <template v-if="character !== null">
          <div class="div-button" v-on:click="selectCharacter(character)">
            <CharacterHeader v-bind="character"></CharacterHeader>
            <div v-if="character.last_mission_hist_date != undefined">
              <span>Last sortie on {{ character.last_mission_hist_date }}</span>
            </div>
          </div>
        </template>

        <!--<template v-else>-->
          <!--<div class="div-button" v-on:click="selectCharacter(character)">-->
            <!--<p>There was no suitable character found. A new character will be created for this Report.</p>-->
          <!--</div>-->
        <!--</template>-->
      </div>
    </template>
  </div>
</template>

<script>
import CharacterHeader from "../campaign/CharacterHeader"
import { mapGetters } from "vuex"

export default {

  name: "ReportCharacterSelection",
  components: {
    CharacterHeader
  },
  async mounted () {

    // Load character info
    this.$store.dispatch('characterStore/loadCharacters',
      {caller: this.$options.name, member_id: await this.$auth.getUserId(this.$options.name)})
      .then(async response => {
        return await this.$auth.getUserUnit(this.$options.name, this.$route.params.campaign_id)
      })
      .then(async response => {
        // this.user_unit = response[0];
        this.depl_unit_id = response[0].depl_unit_id;
        this.faction = response[0].faction;
        this.mission_hist_date = this.missionById(this.$route.params.mission_id).hist_date;
        this.user_id = await this.$auth.getUserId(this.$options.name);
        this.callsign = await this.$auth.getUserCallsign(this.$options.name);

        return this.$dbCon.requestViewData(this.$options.name,
          {view: "mission_member_rank", member_id: this.user_id, mission_id: this.$route.params.mission_id,
            faction: this.faction});
      })
      .then(response => {

        this.member_rank = response[0];
        this.info_loaded = true;
      })
      .catch(error => {
        console.log(error.message);
      });

  },
  data () {
    return {
      info_loaded: false,
      user_unit: null,
      depl_unit_id: null,
      faction: null,
      mission_hist_date: null,
      user_id: null,
      callsign: null,
      member_rank: null
    }
  },
  computed: {

    ...mapGetters("characterStore", [
      "selectableCharacters"
    ]),

    ...mapGetters("missionStore", [
      "missionById"
    ]),
  },
  methods: {
    selectCharacter: async function (character) {

      console.log("SELECT TRIGGERED");
      console.log(JSON.stringify(character)+ " SELECTED");

      // creating new character if necessary
      if(character === null || character.character_id < 0) {
        console.log("Creating new character");
         await this.$store.dispatch('characterStore/getRandomName',
           {caller: this.$options.name, faction: this.faction})
          .then(response => {
            character.first_name = response.first_name;
            character.last_name = response.last_name;
          })
          .catch(error => {
            console.log(error.message);
          });
      }

      var report_info = {
        report_id: -1,
        mission_id: this.$route.params.mission_id,
        asset_id: null,
        depl_unit_id: this.depl_unit_id,
        character_id: character.character_id,
        first_name: character.first_name,
        last_name: character.last_name,
        member_id: this.user_id,
        callsign: this.callsign,
        faction: this.faction,
        rank_value: this.member_rank.real_value,
        rank_name: this.member_rank.rank_name,
        abreviation: this.member_rank.abreviation,
        image: this.member_rank.image,
        pilot_status: 0,
        asset_status: 0,
        base: null,
        markings: null,
        synopsis: null,
        accepted: 0,
        accepted_by: null
      }

      console.log(JSON.stringify(report_info));
      this.$store.commit('missionStore/setReport',
        report_info);

      if (this.faction == 1) {

        var report_detail = {
          id: -1,
          report_id: -1,
          swarm: 4,
          swarm_pos: 4
        };

      } else if (this.faction == 2) {

        var report_detail = {
          id: -1,
          report_id: -1,
          flight: 2,
          section: 8,
          section_pos: 5,
          serial_no: null
        };

      } else if (this.faction == 3) {

        var report_detail = {};

      }

      this.$store.commit('missionStore/setReportDetails',
        report_detail);

      console.log(this.$options.name+": Pushing to -> {name: Report, params: {report_id: -1}");
      this.$router.push({name: "Report", params: {report_id: -1}});
      //DEBUG
    }
  }
}
</script>

<style scoped>

</style>
