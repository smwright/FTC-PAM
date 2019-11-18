<template>
  <div class="container">

    <p>Career characters can be recommended for awards depending on their performance. The awards will be listed for the
      career character once the criteria are met. Awards are given by pressing the <i>Award</i> button next to the award.
      The given date is the date the award criteria was met. However this date can be changed to a later point in time.
      It is as well possible to write a short comment on the circumstances of the award. Awards can be revoked by pressing
      the <i>Revoke</i> button.</p>

    <div v-for="character in characters">

      <SwitchableDiv
        v-if="decorationsByCharacterId(character.character_id).length > 0"
        v-bind:startstate="unawardedDecorationsByCharacterId(character.character_id).length > 0"
      >
        <template slot="buttonStateA">
          <CharacterHeader class="div-button" v-bind="character"></CharacterHeader>
        </template>
        <template slot="contentStateA"></template>

        <template slot="buttonStateB">
          <CharacterHeader class="div-button" v-bind="character"></CharacterHeader>
        </template>
        <template slot="contentStateB">
          <div class="container">

            <div>
              <template v-for="decoration in decorationsByCharacterId(character.character_id)">

                <CharacterDecorationComp
                  v-bind:decoration_id="decoration.decoration_id"
                  v-bind:award_name="decoration.award_name"
                  v-bind:awarded="decoration.awarded"
                ></CharacterDecorationComp>

              </template>
            </div>
          </div>
        </template>
      </SwitchableDiv>
      <CharacterHeader v-else class="div-button-inactive" v-bind="character"></CharacterHeader>

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
      "unawardedDecorationsByCharacterId"
    ])
  }
}
</script>

<style scoped>

div {
  margin: 2px 0px;
}

</style>
