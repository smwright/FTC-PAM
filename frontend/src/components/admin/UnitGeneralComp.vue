<template>
  <div class="container">

    <p class="heading">Decoration recommendations:</p>
    <p>The following pilots where recommended for decorations. Approval of the commanding officers or squadron/Staffel adjutant
      is needed for awarding the decoration.</p>

    <div
      class="container"
      v-for="character_id in character_ids">

      <template v-for="(decoration, index) in decorationsByCharacterId(character_id)">

        <div
          v-if="index == 0"
          class="heading">
          <span>{{ decoration.abreviation }}</span>
          <span>{{ decoration.first_name }} '{{ decoration.callsign }}' {{ decoration.last_name }}</span>
        </div>

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

<script>
import {mapState, mapGetters} from "vuex"
import CharacterDecorationComp from './MemberCharacterDecorationComp'

export default {
  name: "UnitGeneralComp",
  components:{
    CharacterDecorationComp
  },
  computed: {

    character_ids: function() {

      return [...new Set(this.decorations.map(item => item.character_id))];

      },

    ...mapState("characterStore", {

      decorations: state => state.decorations,
    }),

    ...mapGetters("characterStore", [
      "decorationsByCharacterId"
    ])
  },
  methods: {

  }
}
</script>

<style scoped>

</style>
