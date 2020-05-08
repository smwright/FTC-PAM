<template>

  <div>
    <div class="container clearfix">
      <label class="float-left heading">Select asset type:</label>
      <vSelect
        class="float-left width-30"
        v-model="selectedAsset"
        v-bind:options="assets"
        label="name"
      ></vSelect>
      <button class="float-left" v-on:click="addAsset">Add roster asset</button>
      <button class="float-left" v-on:click="sendAssets">Save assets</button>
      <button class="float-left" v-on:click="loadAssets">Fetch assets</button>
    </div>

    <div class="float-left split-div min-width-500">
      <HideableDiv
        class="margin-5-2"
        v-for="asset in assetsWithRosterAssets"
        v-bind:key="asset.id"
        v-bind:start-visible="false"
      >
        <template slot="buttonHidden">
          <div class="div-button heading margin-2-0">
            {{ asset.name }}
          </div>
        </template>
        <div class="margin-2-0">
          <RosterAssetComp
            class="container margin-2-0"
            v-for="r_asset in filterByKey('r_assets', 'asset_id', asset.id)"
            v-bind:key="r_asset.id"
            v-bind:r_asset_id="r_asset.id"
          >
          </RosterAssetComp>
        </div>
      </HideableDiv>
    </div>

    <div class="float-left container split-div text-align-justify">
      <h3>
        Editing roster assets:
      </h3>
      <p>
        Roster assets are individual entities of a particular asset type
        as defined in assets, i.e. a particular aircraft. As the name suggests, the roster assets can be assigned to ACG
        members, one asset per member per unit per campaign, and will show up on the roster pages for the member.
      </p>

      <p>
        <b>Adding roster assets:</b>
        Select the asset type in the dropdown menu. You can search a particular asset by typing its name or simply search
        it in the dropdown menu. The available asset types can be edited in the asset part of the administration. Click "Add
        roster asset" after selecting the asset type. A new roster asset will be added to the list below. The list is ordered
        by asset type. Click on the name of the asset type to fold or unfold the list.
      </p>

      <p>
        <b>Saving assets:</b>
        This will save the assets in the database, upload new image files and delete roster assets marked for deletion.
        Any changes not saved in the database until this button is clicked.
      </p>

      <p>
        <b>Fetch assets:</b>
        Clicking this button will reload all roster assets from the database and also refresh the list of available asset
        types. All unsaved changes will be lost when clicking this button.
      </p>

      <p>
        Each roster asset has 4 properties: Markings, asset type, historical unit and image.
      </p>
      <p>
        <b>Markings:</b> Here you can edit the markings of the asset.
      </p>
      <p>
        <b>Asset type:</b> Here you can reasign the roster asset to a different asset type. The roster asset will be moved
        to the list entries of it's new asset type immediately.
      </p>
      <p>
        <b>Historical unit:</b> Each roster asset is assigned to a historical unit. The assets can only be assigned for campaigns
        that field the specified unit. The roster asset doesn't need to be assigned to a member of said unit though.
      </p>
      <p>
        <b>Image:</b> Here you can set the image that will show up on the roster pages. Click on the image area to select
        an image file. The image file will be uploaded to the server once you save the assets. Click on clear image to remove
        the image from the asset. This will only clear the assigned image in the database, however the image is not deleted
        on the server. The images are shown in a box of width: 425px and height 163px. Uploaded images should fit the
        ratio of 425:163 to be displayed as large as possible.
      </p>
      <p>
        <b>Delete:</b> This will put the roster asset on the list for assets to be deleted. The roster asset is not deleted
        immediately but first once the roster assets are saved.
      </p>


    </div>




  </div>

</template>

<script>
import { mapState, mapGetters } from "vuex"
import RosterAssetComp from "./RosterAssetComp"
import HideableDiv from "../basic_comp/HideableDiv"
import vSelect from 'vue-select'

export default {
  name: "RosterAsset",
  components: {
    RosterAssetComp,
    HideableDiv,
    vSelect
  },
  props: {
    asset_id: {
      type: Number,
      default: 0
    },
    asset_name: {
      type: String,
      default: ""
    }
  },
  mounted () {

    this.loadAssets();
  },
  data () {
    return{

      selectedAsset: 0
    }
  },
  computed: {


    assetsWithRosterAssets: function () {

      let asset_ids = [...new Set(this.r_assets.map(item => item.asset_id))];
      return this.assets.filter(
        function (item) {
          if(asset_ids.includes(item.id)){

          }
          return asset_ids.includes(item.id);
        });
    },

    ...mapState('assetAdmin', {
      assets: state => state.assets,
      r_assets: state => state.r_assets
    }),

    ...mapGetters("assetAdmin", [
      "filterByKey",
      "nestedData"
    ])
  },
  methods: {

    addAsset: function () {

      if(this.selectedAsset.id !== undefined){
        this.$store.commit('assetAdmin/addRosterAsset',
          {
            asset_id: this.selectedAsset.id,
            markings: null,
            hist_unit_id: null,
            image: null
          });
      }
    },

    sendAssets: function () {

      this.$store.dispatch('assetAdmin/sendRAssets',
        {
          caller: this.$options.name,
        }
      ).catch(error => {
          console.log(error.message);
      });
    },

    loadAssets: function () {

      this.$store.dispatch('assetAdmin/loadStoreData',
        {
          caller: this.$options.name,
          call_object: {
            view: "asset_info",
          },
          data_array_name: "assets"
        }
      ).catch(error => {
        console.log(error.message);
      });

      this.$store.dispatch('assetAdmin/loadStoreData',
        {
          caller: this.$options.name,
          call_object: {
            view: "roster_asset",
          },
          data_array_name: "r_assets"
        }
      ).catch(error => {
        console.log(error.message);
      });

      this.$store.dispatch('assetAdmin/loadStoreData',
        {
          caller: this.$options.name,
          call_object: {
            view: "hist_unit",
          },
          data_array_name: "hist_units"
        }
      ).catch(error => {
        console.log(error.message);
      });
    }
  }
}
</script>

<style scoped>

.min-width-500 {
  min-width: 500px;
}

.margin-2-0 {
  margin: 2px 2px;
}

.margin-5-2 {
  margin: 5px 2px;
}

</style>
