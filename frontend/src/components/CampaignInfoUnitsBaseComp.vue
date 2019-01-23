<template>
  <div class="mainContainer">
    <div class="inline">
      <button v-if="children.length >0" v-on:click.stop="toggleChildUnits">{{showChildUnitsButtonText}}</button>
      <span class="link-list-heading">{{ name }}</span>
    </div>
    <div class="inline float-right">
      <span>{{ unit_code }}</span>
    </div>
    <div v-show="showChildUnits" v-for="child in children">
      <CampaignInfoUnitsBaseComp v-bind="child"></CampaignInfoUnitsBaseComp>
    </div>
  </div>
</template>

<script>


export default {
  name: "CampaignInfoUnitsBaseComp",
  props: {
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
      showChildUnitsButtonText: "+"
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
    }
  },
 }
</script>

<style scoped>
 .mainContainer {
   margin: 2px 0px 2px 10px;
 }
</style>
