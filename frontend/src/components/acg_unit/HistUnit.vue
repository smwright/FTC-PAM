<template>
  <div>
    <div class="container">
      <!--<LinkButton-->
      <!--v-bind="{routeName: 'UnitGeneral', routeParams: {unit_id: this.$route.params.unit_id}}">-->
      <!--General Info-->
      <!--</LinkButton>-->
    </div>

    <!--<router-view name="subcontent"></router-view>-->
    <div
      class="typed-on-paper"
      v-if="data_loaded"
    >

      <p class="text-align-justify">
        Use the dropdown to display the roster of {{ this.histName }} during a particular campaign. Only campaigns that {{ this.histName }}
        took part in are available. The list for the current  roster is divided into two lists, one for currently active
        members and one for members on leave (R&R). The rosters show the members and any transfer- or membership status events
        that happened during the campaign.</p>
      <p>Select any of the displayed members in the roster to navigate to the members profile page for more detailed information.</p>

      <select v-model="campaign_to_show">
        <option
          v-for="campaign in participated_campaigns"
          v-bind:value="campaign.campaign_id"
        >{{campaign.campaign_name}} - {{ campaign.hist_unit_name }} represented by {{ campaign.acg_unit_name }}</option>
      </select>

      <Roster
        v-bind:unit_id="this.acg_unit_id"
        v-bind:campaign_id="this.campaign_to_show"
      >
      </Roster>
    </div>

  </div>

</template>

<script>
import { mapState, mapGetters } from "vuex"
import LinkButton from "../basic_comp/LinkButton"
import Roster from "./UnitRoster"

export default {
  name: "HistUnit",
  components: {
    LinkButton,
    Roster
  },
  mounted () {

    this.updateUnitID(this.$route.params.unit_id);
  },
  beforeRouteUpdate (to, from, next) {
    // called when the route that renders this component has changed,
    // but this component is reused in the new route.
    // For example, for a route with dynamic params `/foo/:id`, when we
    // navigate between `/foo/1` and `/foo/2`, the same `Foo` component instance
    // will be reused, and this hook will be called when that happens.
    // has access to `this` component instance.
    this.updateUnitID(to.params.unit_id);
    next();
  },
  data() {

    return {

      unit_id: 0,
      campaign_to_show: 0,
      data_loaded: false,

    }
  },
  computed: {

    acg_unit_id: function () {

      let unit_Array = this.filterByKeys("campaign_units",
          {
            campaign_id: this.campaign_to_show,
            hist_unit_id: this.unit_id
          }
        );
      if(unit_Array.length > 0){
        return unit_Array[0].acg_unit_id;
      } else {
        return 0;
      }
    },

    histName: function () {

      let unit_Array = this.filterByKey("campaign_units", "hist_unit_id", this.unit_id);
      if(unit_Array.length > 0){
        return unit_Array[0].hist_unit_name;
      } else {
        return "";
      }
    },

    participated_campaigns: function () {

      let return_array =  this.filterByKey("campaign_units", "hist_unit_id", this.unit_id);
      return_array.sort(function(a,b){
        return b.campaign_id - a.campaign_id;
      })
      return return_array;
    },

    ...mapState('unitInfo', {

    }),

    ...mapGetters("unitInfo", [
      "findByKey",
      "filterByKey",
      "filterByKeys"
    ])

  },
  methods: {
    updateUnitID: async function (id) {


      this.unit_id = id;
      if(id > 0){

        await this.$store.dispatch('unitInfo/loadUnitInfo',
          {
            caller: this.$options.name,
            unit_type: "hist_unit",
            unit_id: id

          }
        ).then(response => {


          this.data_loaded = true;
        }).catch(error => {
          console.log(error.message);
        });

      }
    }
  },
}
</script>

<style scoped>

</style>
