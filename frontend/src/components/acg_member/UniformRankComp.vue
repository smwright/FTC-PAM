<template>
  <div class="uniform-container">
    <img class="uniform-images" v-bind:src="uniformImage"/>
    <img class="uniform-images" v-bind:src="rankImage"/>
    <img class="uniform-images" v-bind:src="wingsImage"/>
  </div>
</template>

<script>
import {mapState, mapGetters} from "vuex"

export default {
  name: "UniformRankComp",
  props: {

    character_id: {
      type: Number,
      default: 0
    },
    rank_name: {
      type: String,
      default: ""
    },
    rank_abr: {
      type: String,
      default: ""
    },
    rank_image: {
      type: String,
      default: ""
    },
    rank_disp_value: {
      type: Number,
      default: 0
    },
    faction: {
      type: Number,
      default: 0
    }
  },
  computed: {

    uniformImage: function () {

      var baseURL = "/assets/images/";
      if (this.faction === 1) return baseURL + "lw_ranks/LWUniform.png"
      if (this.faction === 2) return baseURL + "raf_ranks/RAFUniform.png"
      if (this.faction === 3) return baseURL + "vvs_ranks/VVSUniform.png"
    },

    rankImage: function () {

      var baseURL = "/assets/images/";
      if (this.faction === 1) return baseURL + "lw_ranks/" + this.rank_image;
      if (this.faction === 2) return baseURL + "raf_ranks/" + this.rank_image;
      if (this.faction === 3) return baseURL + "vvs_ranks/" + this.rank_image;
    },

    wingsImage: function () {

      var baseURL = "/assets/images/";
      var awards = this.filterByKey('character_decorations', 'character_id', this.character_id);

      if (this.faction === 1) {

        if(awards.find(function (item) {return item.award_abr === "FBA"})) {
          return baseURL + "medals_big/MedalFBA.png";
        }
        if(awards.find(function (item) {return item.award_abr === "FBAgd"})) {
          return baseURL + "medals_big/MedalFBAgd.png";
        }
      }
      if (this.faction === 2) {

        if(awards.find(function (item) {return item.award_abr === "AB"})) {
          if(this.rank_disp_value < 8){

            return baseURL + "medals_big/MedalABFabric.png";
          } else {

            return baseURL + "medals_big/MedalABBrass.png";
          }
        }
      }
      if (this.faction === 3) {

        if(awards.find(function (item) {return item.award_abr === "AB_VVS"})) {
          return baseURL + "medals_big/MedalAB_VVS.png";
        }
      }

      return undefined;
    },

    ...mapGetters("memberInfo", [
      "filterByKey"

    ])


  }
}
</script>

<style scoped>

.uniform-images {
  max-height: 90px;
}

.uniform-container {
  width: 360px;
}

</style>
