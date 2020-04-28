<template>
  <div class="container">
    <select v-model="member_r_asset" class="full-width">
      <option
        v-bind:value=null
      ></option>
      <option
        v-for="r_asset in selectableRosterAssets"
        v-bind:value="r_asset.id"
      >
         {{r_asset.markings}} ( {{ r_asset.asset_name }} ) - {{r_asset.hist_unit_name}}
      </option>
    </select>

    <div class="roster-image">
      <img
        class="roster-image"
        v-if="roster_image !== undefined"
        :src="roster_image.image">
    </div>

  </div>
</template>

<script>
import { mapState, mapGetters } from "vuex"

export default {
  name: "UnitRosterSelectComp",
  props: {

    member_id: {
      type: [Number, String],
      default: 0
    },
    campaign_id: {
      type: [Number, String],
      default: 0
    },
    asset_id: {
      type: [Number, String],
      default: null
    }
  },
  data() {

    return {

      member_roster_asset_id: null

    }
  },
  computed: {

    roster_image: function () {

      return this.findByKey('r_assets', 'id', this.member_r_asset);
    },

    selectableRosterAssets: function () {

      if(this.asset_id){
        return this.filterByKey('r_assets', 'asset_id', this.asset_id);
      } else {
        return this.r_assets;
      }

    },

    member_r_asset: {
      get() {
        var asset = this.$store.getters['unitAdmin/filterByKeys']('member_r_assets',
          {
            member_id: this.member_id,
            campaign_id: this.campaign_id
          }
        );
        if(asset.length > 0) {
          this.member_roster_asset_id = asset[0].id;
          return asset[0].roster_asset_id;
        } else {
          this.member_roster_asset_id = null;
          return null;
        }

      },
      set(value) {

        if(this.member_roster_asset_id === null){
          this.$store.commit('unitAdmin/addToArray',
            {
              array_name: 'member_r_assets',
              array_data: {
                member_id: this.member_id,
                campaign_id: this.campaign_id,
                roster_asset_id: value
              }
            });
        } else {

          this.$store.commit('unitAdmin/updateValue',
            {
              array_name: "member_r_assets",
              id_column_name: "id",
              id_column_value: this.member_roster_asset_id,
              update_column_name: "roster_asset_id",
              update_column_value: value
            });

        }
      }
    },

    ...mapState('unitAdmin', {
      r_assets: state => state.r_assets,
    }),

    ...mapGetters("unitAdmin", [
      "findByKey",
      "filterByKey",
      "filterByKeys"
    ])
  }

}
</script>

<style scoped>

</style>
