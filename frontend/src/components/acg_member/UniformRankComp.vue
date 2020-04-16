<template>
  <div :class="[showBig ? 'uniform1' : 'uniform2']">
    <template v-if="faction != 0">
      <img class="uniform-images" v-bind:src="uniformImage"/>
      <img class="uniform-images" v-bind:src="rankImage(faction)"/>
      <img
        v-if="showWings"
        class="uniform-images" v-bind:src="wingsImage"/>
    </template>
    <template v-else>
      <div>
        <div>
          Rank-value {{rank_real_value}}
        </div>

      </div>
      <div class="clearfix">
        <div class="float-left">
          <img class="uniform-images" v-bind:src="rankImage(1)"/>
          <div class="text-align-center">
            {{rankAbbreviation(1)}}
          </div>
        </div>
        <div class="float-left">
          <img class="uniform-images" v-bind:src="rankImage(2)"/>
          <div class="text-align-center">
            {{rankAbbreviation(2)}}
          </div>
        </div>
        <div class="float-left">
          <img class="uniform-images" v-bind:src="rankImage(3)"/>
          <div class="text-align-center">
            {{rankAbbreviation(3)}}
          </div>
        </div>

      </div>
    </template>
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
    rank_real_value: {
      type: Number,
      default: 0
    },
    rank_disp_value: {
      type: Number,
      default: 0
    },
    faction: {
      type: [Number, String],
      default: 0
    },
    rank_lookup: {
      type: Array,
      default: function () {
        return [];
      }
    },
  },
  computed: {

    showBig: function () {

      return  this.faction == 0 || this.character_id > 0;
    },

    showWings: function () {

      return this.character_id > 0;
    },

    uniformImage: function () {

      var baseURL = "/assets/images/";
      if (this.faction === 1) return baseURL + "lw_ranks/LWUniform.png"
      if (this.faction === 2) return baseURL + "raf_ranks/RAFUniform.png"
      if (this.faction === 3) return baseURL + "vvs_ranks/VVSUniform.png"
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
  },
  methods: {

    rankImage: function (faction) {

      var baseURL = "/assets/images/";
      let rank_image;
      let real_value = this.rank_real_value;
      if(this.rank_image == ""){

        let rank_obj = this.rank_lookup.find(
          function(item) {
            return item.real_value == real_value
              && item.faction == faction;
          }
        )

        rank_image = rank_obj.image;

      } else {
        rank_image = this.rank_image;
      }
      if (faction === 1) return baseURL + "lw_ranks/" + rank_image;
      if (faction === 2) return baseURL + "raf_ranks/" + rank_image;
      if (faction === 3) return baseURL + "vvs_ranks/" + rank_image;
    },

    rankAbbreviation: function(faction) {

      let real_value = this.rank_real_value;
      let rank_obj = this.rank_lookup.find(
        function(item) {
          return item.real_value == real_value
            && item.faction == faction;
        }
      )

      return rank_obj.abreviation;
    },
  }

}
</script>

<style scoped>

.uniform-images {
  max-height: 90px;
}

.uniform1 {
  width: 360px;
}

.uniform2 {
  width: 260px;
}

</style>
