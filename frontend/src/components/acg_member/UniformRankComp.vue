<template>
  <div :class="[showBig ? 'uniform1' : 'uniform2']">
    <template v-if="faction != 0">
      <CharacterPortrait
        class="inline-block portrait"
        v-bind:faction="faction"
        v-bind:seed="portrait_seed"
      ></CharacterPortrait>
      <!--<img class="uniform-images" v-bind:src="uniformImage"/>-->
      <img class="inline-block uniform-images" v-bind:src="rankImage(faction)"/>
      <img
        v-if="showWings"
        class="uniform-images" v-bind:src="wingsImage"/>
    </template>
    <template v-else>
      <div>
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
          <div class="float-left">
            <img class="uniform-images" v-bind:src="rankImage(4)"/>
            <div class="text-align-center">
              {{rankAbbreviation(4)}}
            </div>
          </div>

        </div>
      </div>
    </template>
  </div>
</template>

<script>
import CharacterPortrait from "../acg_member/CharacterPotraitComp"

export default {
  name: "UniformRankComp",
  components: {
    CharacterPortrait
  },
  props: {

    single_component: {
      type: Boolean,
      default: false
    },
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
    portrait_seed: {
      type: String,
      default: ""
    },
    rank_lookup: {
      type: Array,
      default: function () {
        return [];
      }
    },
    character_decorations: {
      type: Array,
      default: function () {
        return [];
      }
    }
  },
  computed: {

    showBig: function () {
      // return true;
      return  this.faction == 0 || this.character_id !== 0;
    },

    showWings: function () {

      return this.character_id > 0;
    },

    uniformImage: function () {

      var baseURL = "/assets/images/";
      if (this.faction === 1) return baseURL + "lw_ranks/LWUniform.png"
      if (this.faction === 2) return baseURL + "raf_ranks/RAFUniform.png"
      if (this.faction === 3) return baseURL + "vvs_ranks/VVSUniform.png"
      if (this.faction === 4) return baseURL + "ra_ranks/RAUniform.png"
    },



    wingsImage: function () {

      var baseURL = "/assets/images/";
      let character_id = this.character_id;
      var awards = this.character_decorations.filter(
        function (item) {
          return item["character_id"] == character_id;
        });


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
      if (this.faction === 4) {

        if(awards.find(function (item) {return item.award_abr === "PBRABrass"})) {
          return baseURL + "medals_big/MedalPBRABrass.png";
        }
      }


      return undefined;
    },

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

        if(rank_obj == undefined) return "";

        rank_image = rank_obj.image;

      } else {
        rank_image = this.rank_image;
      }
      if (faction === 1) return baseURL + "lw_ranks/" + rank_image;
      if (faction === 2) return baseURL + "raf_ranks/" + rank_image;
      if (faction === 3) return baseURL + "vvs_ranks/" + rank_image;
      if (faction === 4) return baseURL + "ra_ranks/" + rank_image;
    },

    rankAbbreviation: function(faction) {

      let real_value = this.rank_real_value;
      let rank_obj = this.rank_lookup.find(
        function(item) {
          return item.real_value == real_value
            && item.faction == faction;
        }
      )
      if(rank_obj == undefined) return "";
      return rank_obj.abreviation;
    },

    rankName: function(faction) {

      let real_value = this.rank_real_value;
      let rank_obj = this.rank_lookup.find(
        function(item) {
          return item.real_value == real_value
            && item.faction == faction;
        }
      )
      if(rank_obj == undefined) return "";
      return rank_obj.rank_name;
    },
  }

}
</script>

<style scoped>

.portrait {
  max-height: 100px;
  horiz-align: center;
  vertical-align: middle;
}

.uniform-images {
  max-height: 90px;
  horiz-align: center;
  vertical-align: middle;
}

.uniform1 {
  width: 380px;
}

.uniform2 {
  width: 260px;
}

</style>
