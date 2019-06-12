<template>
  <div class="left-10px-margin">
    <HideableDiv>
      <template slot="buttonHidden">
        <div class="inline-block full-width div-button">
          <div class="float-left">
            <button v-if="children.length >0" v-on:click.stop="toggleChildUnits">{{showChildUnitsButtonText}}</button>
            <span>{{ id }}</span>
            <span class="heading">{{ name }}</span>
          </div>
          <div class="float-right">
            <span class="heading">{{ unit_code }}</span>
          </div>
        </div>
      </template>
      <UnitMembersComp
        v-bind:id="id"
        v-bind:acg_unit_id="acg_unit_id"
      >
      </UnitMembersComp>
    </HideableDiv>
    <div v-if="showChildUnits" v-for="child in children">
      <UnitBaseComp v-bind="child"></UnitBaseComp>
    </div>
  </div>
</template>

<script>
import UnitMembersComp from "./UnitMembersComp";
import HideableDiv from "../basic_comp/HideableDiv"

export default {
  name: "UnitBaseComp",
  components: {
    UnitMembersComp,
    HideableDiv
  },
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
  },
 }
</script>

<style scoped>

.left-10px-margin {
 margin: 0px 0px 0px 10px;
}

.div-button{

  width: calc(100% - 26px);
  margin: 10px 2px 10px 2px;
  padding: 10px;
  cursor: pointer;
  border-style: solid;
  border-width: 1px;
  border-radius: 15px;
  border-color: rgba(0, 0, 0, 0.0);
  background: rgba(0, 0, 0, 0.1);
}

.div-button:hover {
  border-style: solid;
  border-width: 1px;
  border-radius: 15px;
  border-color: #F28900;
  background: rgba(0, 0, 0, 0.4);


.info-container {
  margin: 0px 2px 10px 2px;
  padding: 0px 10px 10px 10px;
  border-style: solid;
  border-width: 1px;
  border-bottom-left-radius: 15px;
  border-bottom-right-radius: 15px;
  border-color: #F28900;
  background: rgba(0, 0, 0, 0.1);
}
}
</style>
