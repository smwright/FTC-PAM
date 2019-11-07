<template>
  <div class="typed-on-paper">

    <div class="padding-10">
      <table>
        <tr><td>Name:</td><td>{{ character.name }}</td></tr>
        <tr><td>Status:</td><td>{{ character.status }}</td></tr>
        <tr><td>Current unit:</td><td>{{ character.unit }}</td></tr>
      </table>
    </div>

    <div class="clearfix">
      <SortiePilotAssetStats
        v-bind:character_id="character_id"
      ></SortiePilotAssetStats>
      <ClaimStats
        v-bind:character_id="character_id"
      ></ClaimStats>

    </div>

    <h1>Awards:</h1>
    <AwardComp
      class=""
      v-bind:character_id="character_id"
      v-bind:extended_info="false"
    ></AwardComp>

    <h1>Sorties:</h1>
    <SortieComp
      v-bind:character_id="character_id"
    ></SortieComp>

  </div>
</template>

<script>
import { mapState, mapGetters } from "vuex"
import statConv from "../../resource/statusConverter"
import SortiePilotAssetStats from "./SortiePilotAssetStatsComp"
import ClaimStats from "./ClaimStatsComp"
import AwardComp from "./AwardComp"
import SortieComp from "./SortieComp"

export default {
  name: "CharacterProfile",
  mixins: [statConv],
  components: {
    SortiePilotAssetStats,
    ClaimStats,
    AwardComp,
    SortieComp
  },
  mounted () {

    this.updateCharacterID(this.$route.params.character_id);
  },
  data () {
    return {

      character_id: 0,
    }
  },
  beforeRouteUpdate (to, from, next) {
    // called when the route that renders this component has changed,
    // but this component is reused in the new route.
    // For example, for a route with dynamic params `/foo/:id`, when we
    // navigate between `/foo/1` and `/foo/2`, the same `Foo` component instance
    // will be reused, and this hook will be called when that happens.
    // has access to `this` component instance.
    this.updateCharacterID(this.$route.params.character_id);
    next();
  },
  computed: {

    character: function() {
      var character_object = {
        name: "",
        status: "",
        unit: ""
      }
      var character = this.findByKey("member_characters", "character_id", this.character_id);
      if(character !== undefined){
        character_object.name = character.rank_abreviation + " " +character.first_name + " " + character.last_name;
        character_object.status = this.pilotStatus[character.character_status];
        character_object.unit = character.hist_unit_name;
      }
      return character_object;
    },


    ...mapGetters("memberInfo", [
      "findByKey",

    ])

  },
  methods: {

    updateCharacterID: function (c_id) {

      // Updating member id and loading status log
      this.character_id = Number(c_id);

    },

  }
}
</script>

<style scoped>

</style>
