<template>
  <div>

    <div class="container">
      <p class="text-align-justify">
        Each member can be assigned one roster asset per unit per campaign. Use the "Select campaign" dropdown to select the
        campaign you want to set member rosters assets for. You will see a list of all members that flew in the unit during the
        selected campaign. Use the dropdown on each members info stripe to select a roster asset or to select no roster asset.
        One can further narrow down the list of each roster asset dropdown by selecting a particular asset type in the "Filter
        asset type" dropdown.
        The assigned assets are not stored in the database instantly. Click the "Save roster assets" button to save the assigned
        roster assets in the database. Click the "Fetch roster assets" button to reload all relevant info from the database.
        All unsaved info is lost when fetching the data anew.
      </p>

    </div>
    <div class="container">

      <div class="clearfix">
        <table>
          <tr>
            <td>
              <label>Select campaign:</label>
            </td>
            <td>
              <select v-model="campaign_to_show">
                <option
                  v-for="campaign in participated_campaigns"
                  v-bind:value="campaign.campaign_id"
                >{{campaign.campaign_name}} - {{ campaign.acg_unit_name }} flew as {{ campaign.hist_unit_name }}</option>
              </select>
            </td>
            <td>
              <button v-on:click="fetchRAssets">Fetch roster assets</button>
            </td>
          </tr>
          <tr>
            <td>
              <label>Filter asset type:</label>
            </td>
            <td>
              <vSelect
                v-model="selectedAsset"
                v-bind:options="assets"
                label="name"
                :reduce="assets => assets.id"
              ></vSelect>
            </td>
            <td>
              <button v-on:click="sendRAssets">Save roster assets</button>
            </td>

          </tr>

        </table>

      </div>

      <Roster
        v-if="campaign_to_show !== 0"
        v-bind:unit_id="this.acg_unit_id"
        v-bind:campaign_id="this.campaign_to_show"
        store_module='unitAdmin'
        v-bind:sepia_images='false'
        v-bind:active_button='false'
        route_name="AdminMember"

      >
        <template
          slot="roster_image"
          slot-scope="{ member }"
        >

          <UnitRosterSelect
            v-bind:member_id="member.member.member_id"
            v-bind:campaign_id="campaign_to_show"
            v-bind:asset_id="selectedAsset"
            v-bind:acg_unit_id="acg_unit_id"
          >
          </UnitRosterSelect>

        </template>
      </Roster>
    </div>
  </div>


</template>

<script>
import { mapState, mapGetters } from "vuex"
import Roster from "../acg_unit/UnitRoster"
import UnitRosterSelect from "./UnitRosterSelectComp"
import vSelect from 'vue-select'

export default {
  name: "UnitRosterComp",
  components: {
    Roster,
    UnitRosterSelect,
    vSelect
  },
  props: {

    acg_unit_id: {
      type: [Number, String],
      default: 0
    }
  },
  data() {

    return {

      campaign_to_show: 0,
      selectedAsset: 0

    }
  },
  computed: {

    participated_campaigns: function () {

      let return_array =  this.filterByKey("campaign_units", "acg_unit_id", this.acg_unit_id);
      return_array.sort(function(a,b){
        return b.campaign_id - a.campaign_id;
      })
      return return_array;
    },

    ...mapState('unitAdmin', {
      assets: state => state.assets,
      r_assets: state => state.r_assets,
    }),

    ...mapGetters("unitAdmin", [
      "filterByKey"
    ])
  },
  methods: {

    sendRAssets: function () {

      this.$store.dispatch('unitAdmin/sendMemberRosterAssets',
        {
          caller: this.$options.name,
        }
      ).then(reponse => {
        this.fetchRAssets();
      })
      .catch(error => {
        console.log(error.message);
      });
    },

    fetchRAssets: function () {

      this.$store.dispatch('unitAdmin/loadStoreData',
        {
          caller: this.$options.name,
          call_object: {
            view: "rank_lookup"
          },
          data_array_name: "rank_lookup"
        });

      this.$store.dispatch('unitAdmin/loadStoreData',
        {
          caller: this.$options.name,
          call_object: {
            view: "campaign_info_unit",
            acg_unit_id: this.acg_unit_id,
          },
          data_array_name: "campaign_units"
        });

      this.$store.dispatch('unitAdmin/loadStoreData',
        {
          caller: this.$options.name,
          call_object: {
            view: "campaign_unit_member_info",
            acg_unit_id: this.acg_unit_id,
          },
          data_array_name: "member_info"
        });

      this.$store.dispatch('unitAdmin/loadStoreData',
        {
          caller: this.$options.name,
          call_object: {
            view: "asset_info",
          },
          data_array_name: "assets"
        });

      this.$store.dispatch('unitAdmin/loadStoreData',
        {
          caller: this.$options.name,
          call_object: {
            view: "roster_asset_info",
          },
          data_array_name: "r_assets"
        });

      this.$store.dispatch('unitAdmin/loadStoreData',
        {
          caller: this.$options.name,
          call_object: {
            view: "member_roster_asset",
            acg_unit_id: this.acg_unit_id
          },
          data_array_name: "member_r_assets"
        });
    }
  }
}
</script>

<style scoped>

</style>
