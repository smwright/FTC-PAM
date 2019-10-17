<template>
  <div>
    <div class="container narrow">
      <label>Search:</label>
      <input v-model="searchString">
    </div>
    <div
      class="div-button narrow"
      v-on:click="switchShowActive()"
      v-bind:class="{active: showActive}"
    >{{ showActiveButtonText }}</div>
    <div
      class="div-button narrow"
      v-on:click="switchShowOnLeave()"
      v-bind:class="{onleave: showOnLeave}"
    >{{ showOnLeaveButtonText }}</div>
    <div
      class="div-button narrow"
      v-on:click="switchShowDismissed()"
      v-bind:class="{dismissed: showDismissed}"
    >{{ showDismissedButtonText }}</div>
    <MemberInfoSideNavComp
      v-for="unit in acg_units"
      v-bind:key="unit.id"
      v-bind:id="unit.id"
      v-bind:name="unit.name"
      v-bind:showActive="showActive"
      v-bind:showOnLeave="showOnLeave"
      v-bind:showDismissed="showDismissed"
      v-bind:searchString="searchString"
    ></MemberInfoSideNavComp>
  </div>

</template>

<script>
import { mapState, mapGetters } from "vuex"
import DivLinkButton from "../basic_comp/DivLinkButton"
import MemberInfoSideNavComp from "./MemberInfoSideNavComp"

export default {
  name: "MemberInfoSideNav",
  components: {
    DivLinkButton,
    MemberInfoSideNavComp
  },
  mounted () {

    this.$store.dispatch('memberInfo/loadACGUnits', {caller: this.$options.name});
    this.$store.dispatch('memberInfo/loadMembers', {caller: this.$options.name});

  },
  data() {
    return {

      showActive: true,
      showOnLeave: true,
      showDismissed: true,
      searchString: "",
    }
  },
  computed: {

    showActiveButtonText: function () {

      return this.showActive ? "Hide active" : "Show active"
    },

    showOnLeaveButtonText: function () {

      return this.showOnLeave ? "Hide on leave" : "Show on leave"
    },

    showDismissedButtonText: function () {

      return this.showDismissed ? "Hide dismissed" : "Show dismissed"
    },

    ...mapState('memberInfo', {
      acg_units: state => state.acg_units
    }),
  },
  methods: {

    switchShowActive: function () {
      this.showActive = !this.showActive;
    },

    switchShowOnLeave: function () {
      this.showOnLeave = !this.showOnLeave;
    },

    switchShowDismissed: function () {
      this.showDismissed = !this.showDismissed;
    },
  }
}
</script>

<style scoped>

.narrow{
  font-size: 1em;
  margin: 2px 0px 0px 20px;
  padding-top: 5px;
  padding-bottom: 5px;
  width: calc(100% - 20px - 26px);
}

.active{
  background-color: rgba(0, 255, 0, 0.25);
}

.onleave{
  background-color: rgba(255, 255, 0, 0.25);
}

.dismissed{
  background-color: rgba(255, 0, 0, 0.25);
}

.passedAway{
  background-color: rgba(0, 0, 255, 0.25);
}

</style>
