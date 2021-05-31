<template>
  <div class="container">
    <DivLinkButton
      v-for="(character) in characters"
      v-bind:class="{ axis: isAxis(character.faction), allied: isAllied(character.faction) }"
      v-bind:key="character.character_id"
      v-bind="{routeName: 'CharacterGeneral',
        routeParams: {character_id: character.character_id }}"
    >
        <div class="clearfix">
          <div class="inline-block float-left width-80">

            <div class="heading character-header">
              <span>{{ decodeHTML(character.rank_abreviation) }}</span>
              <span>{{ decodeHTML(character.first_name) }} {{ decodeHTML(character.last_name) }}</span>
            </div>

            <div class="character-header">
              <span> Status: {{ pilotStatus[character.character_status] }}</span>
              <span> | Sorties: {{ sortiePilotAssetStats(character.character_id).sorties }}</span>
              <span> | Unit: {{ character.hist_unit_name }}</span>
              <span> |
                <ClaimStats
                  v-bind:character_id="character.character_id"
                  v-bind:compact_style="true"
                ></ClaimStats>
              </span>
            </div>

            <div class="clearfix">

              <UniformRankComp
                class="inline-block float-left container width-30 uniform-stripe"
                v-bind:character_id="character.character_id"
                v-bind:rank_name="character.rank_name"
                v-bind:rank_abr="character.rank_abreviation"
                v-bind:rank_image="character.rank_image"
                v-bind:rank_disp_value="character.disp_value"
                v-bind:faction="character.faction"
                v-bind:portrait_seed="character.portrait_seed"
                v-bind:character_decorations="decorations"
              ></UniformRankComp>

              <div class="inline-block width-60 container uniform-stripe">
                <AwardComp
                  class=""
                  v-bind:character_id="character.character_id"
                  v-bind:small_awards="true"
                  v-bind:character_decorations="character_decorations(character.character_id)"
                ></AwardComp>
              </div>
            </div>
          </div>

          <div class="inline-block float-right unit-div">
            <img class="unit-image" v-bind:src="character.hist_unit_image"/>
          </div>
        </div>
    </DivLinkButton>
  </div>
</template>

<script>
import stringConv from "../../resource/stringConverter"
import DivLinkButton from "../basic_comp/DivLinkButton"
import CharacterHeader from "../campaign/CharacterHeader"
import UniformRankComp from "./UniformRankComp"
import AwardComp from "./AwardComp"
import ClaimStats from "./ClaimStatsComp"
import {mapState, mapGetters} from "vuex"
import statConv from "../../resource/statusConverter"

export default {
  name: "MemberCharactersComp",
  components: {
    DivLinkButton,
    CharacterHeader,
    UniformRankComp,
    AwardComp,
    ClaimStats
  },
  mixins: [
    stringConv,
    statConv
  ],
  computed: {

    ...mapState("memberInfo", {

      characters: state => state.member_characters,
      decorations: state => state.character_decorations
    }),

    ...mapGetters("memberInfo", [
      "sortiePilotAssetStats",
    ])

  },
  methods: {

    isAxis: function (faction) {

      return faction === 1 || faction === 4;
    },

    isAllied: function (faction) {

      return faction === 2 || faction === 3;
    },

    character_decorations: function (character_id) {

      var awards = this.decorations.filter(
        function (item) {
          return item["character_id"] == character_id;
        });
      return awards;
    }
  }
}
</script>

<style scoped>

.character-header {
  padding: 2px 10px;
}

.unit-div {
  padding: 10px;
}

.unit-image {
  max-height: 150px;
}

.uniform-stripe {
  height: 100px;
}

</style>
