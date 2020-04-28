<template>
  <div>

    <!--                      -->
    <!--ACG-UNITS (base units)-->
    <!--                      -->
    <HideableDiv>
      <template slot="buttonHidden">
        <div class="div-button heading">Base units</div>
      </template>
      <DivLinkButton
      class="unit-buttons"
      v-for="unit in acg_units"
      v-bind:key="unit.id"
      v-bind="{routeName: 'ACGUnitInfo', routeParams: {unit_id: unit.id}}"
      >
        <span class="heading">{{ unit.name }}</span>
      </DivLinkButton>
    </HideableDiv>

    <!--                      -->
    <!--HIST-UNITS            -->
    <!--                      -->
    <HideableDiv>
      <template slot="buttonHidden">
        <div class="div-button heading">Historical units</div>
      </template>

      <div class="search-div">
        <div class="container narrow">
          <label>Search unit:</label>
          <input v-model="searchString">
        </div>
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
        v-bind:class="{ luftwaffe: (unit.faction == 1), raf: (unit.faction == 2), vvs: (unit.faction == 3)}"
        v-bind:key="unit.id"
        v-bind="{routeName: 'HistUnitInfo', routeParams: {unit_id: unit.id}}"
      >
        <img class="unitEmblem" :src="unit.image"/>
        <span class="heading">{{ unit.name }}</span>
      </DivLinkButton>
    </HideableDiv>

  </div>
</template>

<script>
import { mapState, mapGetters } from "vuex"
import statusConv from "../../resource/statusConverter"
import DivLinkButton from "../basic_comp/DivLinkButton"
import HideableDiv from "../basic_comp/HideableDiv"

export default {
  name: "UnitInfoSideNav",
  components: {
    DivLinkButton,
    HideableDiv
  },
  mixins: [
    statusConv
  ],
  mounted () {

    this.$store.dispatch('unitInfo/loadStoreData',
      {
        caller: this.$options.name,
        call_object: {
          view: "acg_unit",
        },
        data_array_name: "acg_units"
      }
    ).catch(error => {
      console.log(error.message);
    });

    this.$store.dispatch('unitInfo/loadStoreData',
      {
        caller: this.$options.name,
        call_object: {
          view: "hist_unit_info",
        },
        data_array_name: "hist_units"
      }
    ).catch(error => {
      console.log(error.message);
    });

    this.$store.dispatch('unitInfo/loadStoreData',
      {
        caller: this.$options.name,
        call_object: {
          view: "rank_lookup",
        },
        data_array_name: "rank_lookup"
      }
    ).catch(error => {
      console.log(error.message);
    });
  },
  data() {
    return {

      showLW: true,
      showRAF: true,
      showVVS: true,
      searchString: "",
    }
  },
  computed: {

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

      let showLW = this.showLW;
      let showRAF = this.showRAF;
      let showVVS = this.showVVS;
      let hist_units = this.filterByString("hist_units", "name", this.searchString);
      return hist_units.filter(
        function (unit) {
          return (
            (showLW && unit.faction === 1) ||
            (showRAF && unit.faction === 2) ||
            (showVVS && unit.faction === 3)
          );
        });

      return hist_units;
    },

    ...mapState('unitInfo', {
      acg_units: state => state.acg_units,
      hist_units: state => state.hist_units
    }),

    ...mapGetters("unitInfo", [
      "filterByKey",
      "filterByString"
    ])
  },
  methods: {

    switchShowLW: function () {
      this.showLW = !this.showLW;
    },

    switchShowRAF: function () {
      this.showRAF = !this.showRAF;
    },

    switchShowVVS: function () {
      this.showVVS = !this.showVVS;
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
