<template>
  <div class="container">

    <p>Career characters can be recommended for awards depending on their performance. The awards will be listed for the
      career character once the criteria are met. Awards are given by pressing the <i>Award</i> button next to the award.
      The given date is the date the award criteria was met. However this date can be changed to a later point in time.
      It is as well possible to write a short comment on the circumstances of the award. Awards can be revoked by pressing
      the <i>Revoke</i> button.</p>

    <div v-for="character in characters">

      <SwitchableDiv
        v-bind:startstate="unawardedDecorationsByCharacterId(character.character_id).length > 0"
      >
        <template slot="buttonStateA">
          <div class="div-button">
            <CharacterHeader  v-bind="character"></CharacterHeader>
            <span>ID: {{ character.character_id }}</span>
            <span>| Reports: {{ character_reports(character.character_id).length }} </span>
          </div>
        </template>
        <template slot="contentStateA"></template>

        <template slot="buttonStateB">
          <div class="div-button">
            <CharacterHeader v-bind="character"></CharacterHeader>
            <span>ID: {{character.character_id }}</span>
            <span>| Reports: {{ character_reports(character.character_id).length }} </span>
          </div>
        </template>
        <template slot="contentStateB">
          <div class="container">

            <div>
              <template v-for="decoration in decorationsByCharacterId(character.character_id)">

                <CharacterDecorationComp
                  v-bind:decoration_id="decoration.decoration_id"
                  v-bind:award_name="decoration.award_name"
                  v-bind:awarded="decoration.awarded"
                  v-bind:award_image="decoration.award_image"
                ></CharacterDecorationComp>

              </template>
            </div>
          </div>
        </template>
      </SwitchableDiv>
    </div>
  </div>
</template>

<script>
import CharacterHeader from "../campaign/CharacterHeader"
import SwitchableDiv from "../basic_comp/SwitchableDiv"
import CharacterDecorationComp from './MemberCharacterDecorationComp'
import {mapState, mapGetters} from "vuex"

export default {
  name: "MemberCharacterComp",
  components: {
    CharacterHeader,
    SwitchableDiv,
    CharacterDecorationComp
  },
  computed: {

    ...mapState("characterStore", {

      characters: state => state.characters,
    }),

    ...mapGetters("characterStore", [
      "decorationsByCharacterId",
      "unawardedDecorationsByCharacterId",
      "filterByKey"
    ])
  },
  methods: {

    character_reports: function(character_id) {

      return this.filterByKey("reports", "character_id", character_id);
    }
  }
}
</script>

<style scoped>

div {
  margin: 2px 0px;
}

span {
  margin: 2px 0px;
}

</style>
