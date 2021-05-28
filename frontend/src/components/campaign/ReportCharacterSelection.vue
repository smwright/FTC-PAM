<template>
  <div>
    <div class="container">
      <p class = heading>CHARACTER SELECTION</p>
      <p>Choose one of the characters below or create a new character for your report. What characters are available to
      you depends on a set of criteria.</p>
      <ul>
        <li>The character has to be alive and not captured.</li>
        <li>The character has to be of the same faction as the faction of your assigned unit for this campaign.</li>
        <li>The character has not flown a sortie for a mission with a later historic date than this mission.</li>
      </ul>
      <p>If you have a character that fulfils the criteria mentioned above and that has already flown a sortie for your
      assigned historical unit for this campaign, then this is the only available character.</p>
    </div>
    <!--<p>Unit: {{ JSON.stringify(user_unit) }}</p>-->
    <!--<p>Mission:  {{ missionById(this.$route.params.mission_id) }}</p>-->

    <template v-if="info_loaded">
      <!--<div v-for="character in selectableCharacters(user_unit.depl_unit_id, user_unit.faction,-->
            <!--missionById(this.$route.params.mission_id).hist_date)">-->
        <div v-for="character in selectableCharacters(hist_unit_id, faction, mission_hist_date)">
        <!--<div>{{ JSON.stringify(character) }}</div>-->

        <template v-if="character !== null">
          <div class="div-button" v-on:click="selectCharacter(character)">
            <CharacterHeader
              v-bind="character"
              v-bind:character_decorations="decorationsByCharacterId(character.character_id)"
            ></CharacterHeader>
            <div v-if="character.last_mission_hist_date != undefined">
              <span>Last sortie on {{ character.last_mission_hist_date }} for {{ character.hist_unit_name }}.</span>
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
import statConv from "../../resource/statusConverter"
import { mapGetters } from "vuex"

export default {

  name: "ReportCharacterSelection",
  components: {
    CharacterHeader
  },
  mixins: [statConv],
  async mounted () {

    // Load character info
    this.$store.dispatch('characterStore/loadCharacters',
      {caller: this.$options.name, member_id: await this.$auth.getUserId(this.$options.name)})
      .then(async response => {
        this.$store.dispatch('characterStore/loadStoreData',
          {
            caller: this.$options.name,
            call_object: {
              view: "decoration_info",
              member_id: await this.$auth.getUserId(this.$options.name)
            },
            data_array_name: "decorations"
          }
        )
      })
      .then(async response => {
        return await this.$auth.getUserUnit(this.$options.name, this.$route.params.campaign_id)
      })
      .then(async response => {
        // this.user_unit = response[0];
        this.depl_unit_id = response[0].depl_unit_id;
        this.hist_unit_id = response[0].hist_unit_id;
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
      hist_unit_id: null,
      faction: null,
      mission_hist_date: null,
      user_id: null,
      callsign: null,
      member_rank: null
    }
  },
  computed: {

    ...mapGetters("characterStore", [
      "selectableCharacters",
      "decorationsByCharacterId"
    ]),

    ...mapGetters("missionStore", [
      "missionById"
    ]),
  },
  methods: {
    selectCharacter: async function (character) {

      // creating new character if necessary
      if(character === null || character.character_id < 0) {
        console.log("Creating new character");
         await this.$store.dispatch('characterStore/getRandomName',
           {caller: this.$options.name, faction: this.faction})
          .then(response => {
            character.first_name = response.first_name;
            character.last_name = response.last_name;

            let portrait_arr = [];
            switch(this.faction) {
              case 1:
                portrait_arr = this.lw_images;
                break;
              case 2:
                portrait_arr = this.raf_images;
                break;
              case 3:
                portrait_arr = this.vvs_images;
                break;
              case 4:
                portrait_arr = this.lw_images;
                break;
              default:
                portrait_arr = [];
                break;
            }

            let array = portrait_arr.background;
            let bg = array[Math.floor(Math.random() * array.length)];
            array = portrait_arr.ears;
            let ears = array[Math.floor(Math.random() * array.length)];
            array = portrait_arr.eyes;
            let eyes = array[Math.floor(Math.random() * array.length)];
            array = portrait_arr.hair;
            let hair = array[Math.floor(Math.random() * array.length)];
            array = portrait_arr.head;
            let head = array[Math.floor(Math.random() * array.length)];
            array = portrait_arr.mouth;
            let mouth = array[Math.floor(Math.random() * array.length)];
            array = portrait_arr.nose;
            let nose = array[Math.floor(Math.random() * array.length)];

            character.portrait_seed = bg + "-" + ears + "-" + eyes + "-" + hair + "-"
              + head + "-" + mouth + "-" + nose;

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
        accepted_by: null,
        portrait_seed: character.portrait_seed
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

      } else if (this.faction == 4) {

        var report_detail = {
          id: -1,
          report_id: -1,
          sezione: 4,
          sezione_pos: 4
        };

      }


      this.$store.commit('missionStore/setReportDetails',
        report_detail);
      this.$store.commit('missionStore/resetTable',
        "aerial_claims");
      this.$store.commit('missionStore/resetTable',
        "ground_claims");
      this.$store.commit('missionStore/resetTable',
        "aerial_claims_for_delete");
      this.$store.commit('missionStore/resetTable',
        "ground_claims_for_delete");


      console.log(this.$options.name+": Pushing to -> {name: Report, params: {report_id: -1}");
      this.$router.push({name: "Report", params: {report_id: -1}});
      //DEBUG
    }
  }
}
</script>

<style scoped>

</style>
