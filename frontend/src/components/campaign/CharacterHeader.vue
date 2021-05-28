<template>
  <div class="clearfix">
    <div class="inline-block float-left width-80">

      <div class="heading character-header">
        <span>{{ decodeHTML(rank_abreviation) }}</span>
        <span>{{ decodeHTML(first_name) }} {{ decodeHTML(last_name) }}</span>
      </div>

      <div
        v-if="first_name !== 'NEW CHARACTER'"
        class="clearfix"
      >
        <UniformRankComp
          class="inline-block float-left container width-30 uniform-stripe"
          v-bind:character_id="character_id"
          v-bind:rank_name="rank_name"
          v-bind:rank_abr="rank_abreviation"
          v-bind:rank_image="rank_image"
          v-bind:rank_disp_value="disp_value"
          v-bind:faction="faction"
          v-bind:portrait_seed="portrait_seed"
          v-bind:character_decorations="character_decorations"
        ></UniformRankComp>

        <div class="inline-block width-60 uniform-stripe">
          <AwardComp
            class="container"
            v-bind:character_id="character_id"
            v-bind:small_awards="true"
            v-bind:character_decorations="character_decorations"
          ></AwardComp>
        </div>
      </div>

    </div>

    <div
      class="inline-block float-right unit-div"
      v-if="first_name !== 'NEW CHARACTER'"
    >
      <img class="unit-image" v-bind:src="hist_unit_image"/>
    </div>

  </div>
</template>

<script>
import stringConv from "../../resource/stringConverter"
import statConv from "../../resource/statusConverter"
import UniformRankComp from "../acg_member/UniformRankComp"
import AwardComp from "../acg_member/AwardComp"

export default {
  name: "CharacterHeader",
  components: {
    UniformRankComp,
    AwardComp,
  },
  mixins: [
    stringConv,
    statConv
  ],
  props: {
    character_id: {
      type: Number,
      default: null
    },
    first_name: {
      type: String,
      default: null
    },
    last_name: {
      type: String,
      default: null
    },
    rank_name: {
      type: String,
      default: null
    },
    rank_abreviation: {
      type: String,
      default: null
    },
    rank_image: {
      type: String,
      default: null
    },
    disp_value: {
      type: Number,
      default: null
    },
    faction:{
      type: Number,
      default: null
    },
    portrait_seed: {
      type: String,
      default: ""
    },
    hist_unit_image: {
      type: String,
      default: ""
    },
    character_decorations: {
      type: Array,
      default: function () {
        return [];
      }
    }
  },
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
  max-height: 100px;
}

.uniform-stripe {
  height: 100px;
}

</style>
