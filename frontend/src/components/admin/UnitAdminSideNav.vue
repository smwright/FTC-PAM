<template>
  <div>
    <DivLinkButton
      class="unit-buttons"
      v-bind:key=-1
      v-bind="{routeName: 'UnitOverview'}"
    >
      Unit Overview
    </DivLinkButton>
    <DivLinkButton
      class="unit-buttons"
      v-for="unit in acg_units"
      v-bind:key="unit.id"
      v-bind="{routeName: 'AdminUnit', routeParams: {unit_id: unit.id}}"
    >
      {{ unit.name }}
    </DivLinkButton>
  </div>
</template>

<script>
  import { mapState } from "vuex"
  import DivLinkButton from "../basic_comp/DivLinkButton"

  export default {
    name: "UnitAdminSideNav",
    components: {
      DivLinkButton
    },
    mounted () {

      if (this.$store.state.memberAdmin.acg_units.length == 0){
        this.$store.dispatch('memberAdmin/loadACGUnits', {caller: this.$options.name});
      }

    },
    computed: {

      ...mapState('memberAdmin', {
        acg_units: state => state.acg_units
      })
    }
  }
</script>

<style scoped>

  .unit-buttons{
    font-size: 1em;
    margin: 2px 0px 0px 20px;
    padding-top: 5px;
    padding-bottom: 5px;
    width: calc(100% - 20px - 26px);
  }

</style>
