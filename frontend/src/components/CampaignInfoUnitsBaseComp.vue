<template>
  <div class="mainContainer">
    <div class="link-list" v-on:click="toggleUnitInfo">
      <div class="inline">
        <button v-if="children.length >0" v-on:click.stop="toggleChildUnits">{{showChildUnitsButtonText}}</button>
        <span>{{ id }}</span>
        <span class="link-list-heading">{{ name }}</span>
      </div>
      <div class="inline float-right">
        <span>{{ unit_code }}</span>
      </div>
    </div>
    <CampaignInfoUnitsMembersComp
      v-show="showUnitInfo"
      v-bind:id="id"
      v-bind:acg_unit_id="acg_unit_id"
    >
    </CampaignInfoUnitsMembersComp>
    <div v-if="showChildUnits" v-for="child in children">
      <CampaignInfoUnitsBaseComp v-bind="child"></CampaignInfoUnitsBaseComp>
    </div>
  </div>
</template>

<script>
import CampaignInfoUnitsMembersComp from "./CampaignInfoUnitsMembersComp";

export default {
  name: "CampaignInfoUnitsBaseComp",
  components: {CampaignInfoUnitsMembersComp},
  props: {
    id: {
      type: Number,
      default: null
    },
    acg_unit_id: {
      type: Number,
      default: null
    },
    name: String,
    children: {
      type: Array,
      default: function () {
        return [];
      }
    },
    unit_code: {
      type: String,
      default: ""
    }
  },
  data () {
    return {
      showChildUnits: false,
      showChildUnitsButtonText: "+",
      showUnitInfo: false
    }
  },
  methods: {

    toggleChildUnits: function () {
      this.showChildUnits = !this.showChildUnits
      if(this.showChildUnits) {
        this.showChildUnitsButtonText = "-"
      } else {
        this.showChildUnitsButtonText = "+"
      }
    },
    toggleUnitInfo: function () {
      this.showUnitInfo = !this.showUnitInfo;
    }
  },
 }
</script>

<style scoped>
 .mainContainer {
   margin: 0px 0px 0px 10px;
 }
</style>
