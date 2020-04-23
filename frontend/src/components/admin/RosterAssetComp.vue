<template>

  <div>
    <div>
      <label class="heading">Markings:</label>
      <span><input v-model="markings"></span>
    </div>
    <div class="clearfix">
      <label class="float-left heading">Reasing asset type:</label>
      <vSelect
        class="float-left width-70"
        v-model="asset_type_id"
        v-bind:options="assets"
        v-bind:clearable="false"
        label="name"
      ></vSelect>
    </div>
    <div>
      <label class="heading">Image:</label>
      <div class="clearfix">
        <ImageUpload
          class="imageLoader float-left"
          v-model="roster_image"
          savePath="/assets/images/roster_images/"
        >
        </ImageUpload>
        <button class="float-left" v-on:click="clearImage">Clear image</button>
      </div>
    </div>
    <div class="clearfix">
      <button class="float-right" v-on:click="deleteAsset">Delete</button>
    </div>

  </div>

</template>

<script>
import { mapState, mapGetters } from "vuex"
import ImageUpload from "../basic_comp/ImageUpload"
import vSelect from 'vue-select'

export default {
  name: "RosterAssetComp",
  components: {
    ImageUpload,
    vSelect
  },
  props:{
    r_asset_id: {
      type: Number,
      default: 0
    }
  },
  data(){
    return {
      selectedAsset: 0
    }
  },
  computed: {

    markings: {
      get() {
        var asset = this.$store.getters['assetAdmin/findByKey']('r_assets', 'id', this.r_asset_id );
        return (asset !== undefined) ? asset.markings : "";
      },
      set(value) {
        this.$store.commit('assetAdmin/updateValue',
          {
            array_name: "r_assets",
            id_column_name: "id",
            id_column_value: this.r_asset_id,
            update_column_name: "markings",
            update_column_value: value
          });
      }
    },

    asset_type_id: {
      get() {
        var asset = this.$store.getters['assetAdmin/findByKey']('r_assets', 'id', this.r_asset_id );
        if(asset !== undefined) {
          return this.findByKey("assets", "id", asset.asset_id);
        } else {
          return {};
        }

        // return (asset !== undefined) ? asset : "";
      },
      set(value) {
        this.$store.commit('assetAdmin/updateValue',
          {
            array_name: "r_assets",
            id_column_name: "id",
            id_column_value: this.r_asset_id,
            update_column_name: "asset_id",
            update_column_value: value.id
          });
      }
    },

    roster_image: {
      get() {
        var asset = this.$store.getters['assetAdmin/findByKey']('r_assets', 'id', this.r_asset_id );
        if(asset.image instanceof FormData) {

          return asset.image;
        } else {
          if(!asset.image){
            return null;
          } else {
            let formData = new FormData();
            formData.append("imageURL", asset.image);
            return formData;
          }
        }
      },
      set(value) {
        this.$store.commit('assetAdmin/updateValue',
          {
            array_name: "r_assets",
            id_column_name: "id",
            id_column_value: this.r_asset_id,
            update_column_name: "image",
            update_column_value: value
          });
      }
    },

    ...mapState('assetAdmin', {
      assets: state => state.assets,
    }),

    ...mapGetters("assetAdmin", [
      "findByKey"
    ])
  },
  methods: {

    deleteAsset: function () {
      this.$store.commit('assetAdmin/deleteValue',
        {
          array_name: "r_assets",
          id_column_name: "id",
          id_column_value: this.r_asset_id,
          array_name_delete: "r_assets_for_delete"
        });
    },

    clearImage: function () {
      this.$store.commit('assetAdmin/updateValue',
        {
          array_name: "r_assets",
          id_column_name: "id",
          id_column_value: this.r_asset_id,
          update_column_name: "image",
          update_column_value: null
        });
    }
  }
}
</script>

<style scoped>

.imageLoader {

  width: 425px;
  height: 163px;
}

div{
  margin: 2px;
}

</style>
