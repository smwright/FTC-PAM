<template>
  <div>
    <div class="container">
      <button v-on:click="">Save unit</button>
      <button v-on:click="">Fetch unit</button>
    </div>

    <div class="clearfix container">
      <div class="inline-table float-left half-width">
        <label>Name</label>
        <input v-model="unit_name">
      </div>
      <div class="inline-table float-right half-width">
        <span>Name of the historical unit</span>
      </div>
    </div>

    <div class="clearfix container">
      <div class="inline-table float-left half-width">
        <label>Code</label>
        <input v-model="unit_code">
      </div>
      <div class="inline-table float-right half-width">
        <span>Code of the historical unit</span>
      </div>
    </div>

    <div class="clearfix container">
      <div class="inline-table float-left half-width">
        <label>Faction</label>
        <select v-model="unit_faction">
          <option
            v-for="(faction, index) in factionStatus"
            v-bind:value="index"
          >
            {{ faction.long }}
          </option>
        </select>
      </div>
      <div class="inline-table float-right half-width">
        <span>The faction of the historical unit</span>
      </div>
    </div>

    <div class="clearfix container">
      <div class="inline-table float-left half-width">
        <p>Description:</p>
        <textarea class="textarea-style" v-model="unit_description"></textarea>
      </div>
      <div class="inline-table float-right half-width">
        <span>A description for the historical unit.</span>
      </div>
    </div>

    <div class="clearfix container">
      <div class="padding-10">
        <label>Unit emblem images</label>
        <p>
          The webpage and forum need various images for the unit emblems.
          The file names should follow the same naming convention for clarity. Only use numbers, letters and underscore.
          i.e. 6jg5.png, no32.png or 35giap.png. The emblem images should be stored in PNG format. The following images are
          needed:
        </p>
        <ul>
          <li><b>Unit emblem</b> for use on webpage, width: ca 257 px, height: ca 300 px</li>
          <li><b>Unit forum emblem</b> for use in the forum, width: ca 40 px, height: ca 40 px</li>
        </ul>
      </div>
      <div class="inline-table float-left half-width">
        <label>Unit emblem:</label>
        <p>Image URL:
          <template v-if="unit_emblem != null">{{ unit_emblem.getAll('imageURL')[0] }}</template>
        </p>
        <ImageUpload
          class="img-container"
          v-model="unit_emblem"
          savePath="/assets/images/unit_emblems/"
        >
        </ImageUpload>
        <button class="float-left" v-on:click="clearImage">Clear image</button>
      </div>
      <div class="inline-table float-left half-width">
        <label>Unit forum emblem:</label>
        <p>Image URL:
          <template v-if="unit_f_emblem != null">{{ unit_f_emblem.getAll('imageURL')[0] }}</template>
        </p>        <ImageUpload
          class="img-container"
          v-model="unit_f_emblem"
          savePath="/assets/images/unit_emblems/"
        >
        </ImageUpload>
        <button class="float-left" v-on:click="clearImage">Clear image</button>
      </div>
    </div>
  </div>

</template>

<script>
import { mapGetters} from "vuex"
import statConv from "../../resource/statusConverter"
import ImageUpload from "../basic_comp/ImageUpload"

export default {
  name: "HistUnit",
  mixins: [statConv],
  components: {
    ImageUpload
  },
  mounted () {

    this.updateUnitID(this.$route.params.unit_id);
  },
  data () {
    return {

      unit_id: 0
    }
  },
  computed: {

    unit_name: {
      get () {
        var unit = this.$store.getters['unitAdmin/findByKey']('hist_units', 'id', this.unit_id);
        return (unit !== undefined) ? unit.name : "";
      },
      set(value) {
        this.$store.commit('unitAdmin/updateValue',
          {
            array_name: "hist_units",
            id_column_name: "id",
            id_column_value: this.unit_id,
            update_column_name: "name",
            update_column_value: value
          });
      }
    },
    unit_code: {
      get () {
        var unit = this.$store.getters['unitAdmin/findByKey']('hist_units', 'id', this.unit_id);
        return (unit !== undefined) ? unit.code : "";
      },
      set(value) {
        this.$store.commit('unitAdmin/updateValue',
          {
            array_name: "hist_units",
            id_column_name: "id",
            id_column_value: this.unit_id,
            update_column_name: "code",
            update_column_value: value
          });
      }
    },
    unit_faction: {
      get () {
        var unit = this.$store.getters['unitAdmin/findByKey']('hist_units', 'id', this.unit_id);
        return (unit !== undefined) ? unit.faction : 0;
      },
      set(value) {
        this.$store.commit('unitAdmin/updateValue',
          {
            array_name: "hist_units",
            id_column_name: "id",
            id_column_value: this.unit_id,
            update_column_name: "faction",
            update_column_value: value
          });
      }
    },
    unit_description: {
      get () {
        var unit = this.$store.getters['unitAdmin/findByKey']('hist_units', 'id', this.unit_id);
        return (unit !== undefined) ? unit.description : "";
      },
      set(value) {
        this.$store.commit('unitAdmin/updateValue',
          {
            array_name: "hist_units",
            id_column_name: "id",
            id_column_value: this.unit_id,
            update_column_name: "description",
            update_column_value: value
          });
      }
    },
    unit_emblem: {
      get() {
        var unit = this.$store.getters['unitAdmin/findByKey']('hist_units', 'id', this.unit_id );
        if(unit === undefined) return null;
        if(unit !== undefined && unit.image instanceof FormData) {

          return unit.image;
        } else {
          if(!unit.image){
            return null;
          } else {
            let formData = new FormData();
            formData.append("imageURL", unit.image);
            return formData;
          }
        }
      },
      set(value) {
        this.$store.commit('assetAdmin/updateValue',
          {
            array_name: "hist_units",
            id_column_name: "id",
            id_column_value: this.unit_id,
            update_column_name: "image",
            update_column_value: value
          });
      }
    },
    unit_f_emblem: {
      get() {
        var unit = this.$store.getters['unitAdmin/findByKey']('hist_units', 'id', this.unit_id );
        if(unit === undefined) return null;
        if(unit !== undefined && unit.f_image instanceof FormData) {

          return unit.f_image;
        } else {
          if(!unit.f_image){
            return null;
          } else {
            let formData = new FormData();
            formData.append("imageURL", unit.f_image);
            return formData;
          }
        }
      },
      set(value) {
        this.$store.commit('assetAdmin/updateValue',
          {
            array_name: "hist_units",
            id_column_name: "id",
            id_column_value: this.unit_id,
            update_column_name: "f_image",
            update_column_value: value
          });
      }
    },
  },
  beforeRouteUpdate (to, from, next) {

    this.updateUnitID(to.params.unit_id);
     next();
  },
  methods: {

    updateUnitID: function (id) {

      this.unit_id = Number(id);
    },

    clearImage: function () {
      this.$store.commit('unitAdmin/updateValue',
        {
          array_name: "hist_units",
          id_column_name: "id",
          id_column_value: this.unit_id,
          update_column_name: "image",
          update_column_value: null
        });
    }

  }

}
</script>

<style scoped>

.textarea-style{
    width: 100%;
    height: 20em;
}

.img-container {

  width: 120px;
  min-height: 120px;
}

</style>
