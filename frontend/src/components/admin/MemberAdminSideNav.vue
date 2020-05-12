<template>
  <div>
    <DivLinkButton
      class="member-buttons narrow"
      v-bind:key=-1
      v-bind="{routeName: 'AdminMember', routeParams: {member_id: -1}}"
    >
      Add member
    </DivLinkButton>
    <div class="container narrow">
      <label>Search member:</label>
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
    <div
      class="div-button narrow"
      v-on:click="switchShowPassedAway()"
      v-bind:class="{passedAway: showPassedAway}"
    >{{ showPassedAwayButtonText }}</div>
    <DivLinkButton
      class="unit-buttons"
      v-bind="{routeName: 'UnitOverview'}"
    >
      Unit overview
    </DivLinkButton>
    <MemberAdminSideNavComp
      v-for="unit in acg_units"
      v-bind:key="unit.id"
      v-bind:id="unit.id"
      v-bind:name="unit.name"
      v-bind:showActive="showActive"
      v-bind:showOnLeave="showOnLeave"
      v-bind:showDismissed="showDismissed"
      v-bind:showPassedAway="showPassedAway"
      v-bind:searchString="searchString"
    ></MemberAdminSideNavComp>
  </div>
</template>

<script>
import { mapState } from "vuex"
import MemberAdminSideNavComp from "./MemberAdminSideNavComp"
import DivLinkButton from "../basic_comp/DivLinkButton"

export default {
  name: "MemberAdminSideNav",
  components: {
    MemberAdminSideNavComp,
    DivLinkButton
  },
  mounted () {

    if (this.$store.state.memberAdmin.acg_units.length == 0){
      this.$store.dispatch('memberAdmin/loadACGUnits', {caller: this.$options.name});
    }

    if (this.$store.state.memberAdmin.members.length == 1){
      this.$store.dispatch('memberAdmin/loadMembers', {caller: this.$options.name});
    }

  },
  data() {
    return {

      showActive: true,
      showOnLeave: true,
      showDismissed: true,
      showPassedAway: true,
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

    showPassedAwayButtonText: function () {

      return this.showPassedAway ? "Hide passed away" : "Show passed away"
    },

    ...mapState('memberAdmin', {
      acg_units: state => state.acg_units
    })
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

    switchShowPassedAway: function () {
      this.showPassedAway = !this.showPassedAway;
    }
  }
}
</script>

<style scoped>

.unit-buttons{
  color: #F28900;
  font-size: 1em;
  margin: 2px 0px 0px 15px;
  width: calc(100% - 15px - 26px);
}

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
