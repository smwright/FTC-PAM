<template>
  <div>
    <div class="search-div">
      <div class="container narrow">
        <label>Search unit:</label>
        <input v-model="searchString">
      </div>
      <div
        class="div-button narrow"
        v-on:click="switchShowNF()"
        v-bind:class="{nofaction: showNF}"
      >{{ showNFButtonText }}</div>
      <div
        class="div-button narrow"
        v-on:click="switchShowLW()"
        v-bind:class="{luftwaffe: showLW}"
      >{{ showLWButtonText }}</div>
      <div
        class="div-button narrow"
        v-on:click="switchShowRAF()"
        v-bind:class="{raf: showRAF}"
      >{{ showRAFButtonText }}</div>
      <div
        class="div-button narrow"
        v-on:click="switchShowVVS()"
        v-bind:class="{vvs: showVVS}"
      >{{ showVVSButtonText }}</div>
    </div>

    <DivLinkButton
      class="unit-buttons"
      v-for="unit in hist_units_filtered"
      v-if="unit.id > 0"
      v-bind:class="{ nofaction: (unit.faction == 0), luftwaffe: (unit.faction == 1), raf: (unit.faction == 2), vvs: (unit.faction == 3)}"
      v-bind:key="unit.id"
      v-bind="{routeName: routeName, routeParams: {unit_id: unit.id}}"
    >
      <img class="unitEmblem" :src="unit_emblem(unit.image)"/>
      <span class="heading">{{ unit.name }}</span>
    </DivLinkButton>
  </div>
</template>

<script>
import { mapState, mapGetters } from "vuex"
import statusConv from "../../resource/statusConverter"
import DivLinkButton from "../basic_comp/DivLinkButton"
import HideableDiv from "../basic_comp/HideableDiv"


export default {
  name: "HistUnitSideNav",
  components: {
    DivLinkButton,
    HideableDiv
  },
  mixins: [
    statusConv
  ],
  props: {
    routeName: {
      type: String,
      default: 'HistUnitInfo'
    }
  },
  data() {
    return {

      showNF: true,
      showLW: true,
      showRAF: true,
      showVVS: true,
      searchString: "",
    }
  },
  computed: {

    showNFButtonText: function () {

      return this.showNF ? "Hide without faction" : "Show without faction"
    },

    showLWButtonText: function () {

      return this.showLW ? "Hide "+this.factionStatus[1].long : "Show "+this.factionStatus[1].long
    },

    showRAFButtonText: function () {

      return this.showRAF ? "Hide "+this.factionStatus[2].long : "Show "+this.factionStatus[2].long
    },

    showVVSButtonText: function () {

      return this.showVVS ? "Hide "+this.factionStatus[3].long : "Show "+this.factionStatus[3].long
    },

    hist_units_filtered: function () {

      let showNF = this.showNF;
      let showLW = this.showLW;
      let showRAF = this.showRAF;
      let showVVS = this.showVVS;
      let hist_units = this.filterByString("hist_units", "name", this.searchString);
      return hist_units.filter(
        function (unit) {
          return (
            (showNF && unit.faction === 0) ||
            (showLW && unit.faction === 1) ||
            (showRAF && unit.faction === 2) ||
            (showVVS && unit.faction === 3)
          );
        });

      return hist_units;
    },

    ...mapState("unitAdmin", {
      acg_units: state => state.acg_units,
      hist_units: state => state.hist_units
    }),

    ...mapGetters("unitAdmin", [
      "filterByKey",
      "filterByString"
    ])
  },
  methods: {

    switchShowNF: function () {
      this.showNF = !this.showNF;
    },

    switchShowLW: function () {
      this.showLW = !this.showLW;
    },

    switchShowRAF: function () {
      this.showRAF = !this.showRAF;
    },

    switchShowVVS: function () {
      this.showVVS = !this.showVVS;
    },

    unit_emblem: function (image) {

      if(image instanceof FormData) {
        return image.getAll('imageURL');
      } else {
        return image;
      }
    },

  }
}
</script>

<style scoped>

  .search-div{
    padding-bottom: 10px;
  }

  .narrow{
    font-size: 1em;
    margin: 2px 0px 0px 20px;
    padding-top: 5px;
    padding-bottom: 5px;
    width: calc(100% - 20px - 26px);
  }

  .unitEmblem {
    height: 37px;
    vertical-align: middle;
  }

</style>
