<template>
  <img
    class=""
    v-if="img_str.length > 0"
    v-bind:src="this.img_str"
  >
</template>

<script>
import statConv from "../../resource/statusConverter"
import mergeImages from 'merge-images';

export default {
  name: "CharacterPotraitComp",
  mixins: [statConv],
  props: {
    faction: {
      type: Number,
      default: 1
    },
    seed: {
      type: String,
      default: ""
    }
  },
  mounted (){

    if(this.seed !== null){
      this.getImage();
    }

  },
  watch: {
    faction: function(newVal, oldVal) {
      if(this.seed !== null){
        this.getImage();
      }
    },
    seed: function(newVal, oldVal) {
      if(this.seed !== null){
        this.getImage();
      }
    },

  },
  data () {
    return {

      baseURL: "/assets/images/portraits/",
      img_str: "/assets/images/portraits/frame.png"

    }
  },
  computed: {

    img_array: function () {

      if(this.faction === 1) return this.lw_images;
      if(this.faction === 2) return this.raf_images;
      if(this.faction === 3) return this.vvs_images;
      if(this.faction === 4) return this.lw_images;
      return null;
    },

    img_path: function () {

      if(this.faction === 1) return "lw";
      if(this.faction === 2) return "raf";
      if(this.faction === 3) return "vvs";
      if(this.faction === 4) return "lw";
      return null;
    },

    background_image: function () {

      let img_array = this.img_array.background;
      let background_id = this.iseed[0];
      if(img_array.includes(background_id)){
        return this.baseURL + this.img_path + "/background/" + background_id + ".png";
      } else {
        return this.baseURL + this.img_path + "/background/" + img_array[0] + ".png";
      }

    },
    ears_image: function () {

      let img_array = this.img_array.ears;
      let ears_id = this.iseed[1];
      if(img_array.includes(ears_id)){
        return this.baseURL + this.img_path + "/ears/" + ears_id + ".png";
      } else {
        return this.baseURL + this.img_path + "/ears/" + img_array[0] + ".png";
      }

    },
    eyes_image: function () {

      let img_array = this.img_array.eyes;
      let eyes_id = this.iseed[2];
      if(img_array.includes(eyes_id)){
        return this.baseURL + this.img_path + "/eyes/" + eyes_id + ".png";
      } else {
        return this.baseURL + this.img_path + "/eyes/" + img_array[0] + ".png";
      }

    },
    hair_image: function () {

      let img_array = this.img_array.hair;
      let hair_id = this.iseed[3];
      if(img_array.includes(hair_id)){
        return this.baseURL + this.img_path + "/hair/" + hair_id + ".png";
      } else {
        return this.baseURL + this.img_path + "/hair/" + img_array[0] + ".png";
      }

    },
    head_image: function () {

      let img_array = this.img_array.head;
      let head_id = this.iseed[4];
      if(img_array.includes(head_id)){
        return this.baseURL + this.img_path + "/head/" + head_id + ".png";
      } else {
        return this.baseURL + this.img_path + "/head/" + img_array[0] + ".png";
      }

    },
    mouth_image: function () {

      let img_array = this.img_array.mouth;
      let mouth_id = this.iseed[5];
      if(img_array.includes(mouth_id)){
        return this.baseURL + this.img_path + "/mouth/" + mouth_id + ".png";
      } else {
        return this.baseURL + this.img_path + "/mouth/" + img_array[0] + ".png";
      }

    },
    nose_image: function () {

      let img_array = this.img_array.nose;
      let nose_id = this.iseed[6];
      if(img_array.includes(nose_id)){
        return this.baseURL + this.img_path + "/nose/" + nose_id + ".png";
      } else {
        return this.baseURL + this.img_path + "/nose/" + img_array[0] + ".png";
      }

    },

    iseed: function () {
      return this.seed.split("-").map(x=>+x);
    }

  },
  methods: {

    getImage: function () {

      if(this.seed !== null | this.seed !== ""){

        let frame_offset = {x: 38, y:40};
        mergeImages([
          {src: this.background_image, x:frame_offset.x, y:frame_offset.y },
          {src: this.head_image, x:frame_offset.x, y:frame_offset.y },
          {src: this.eyes_image, x:frame_offset.x, y:frame_offset.y },
          {src: this.nose_image, x:frame_offset.x, y:frame_offset.y },
          {src: this.mouth_image, x:frame_offset.x, y:frame_offset.y },
          {src: this.hair_image, x:frame_offset.x, y:frame_offset.y },
          {src: this.ears_image, x:frame_offset.x, y:frame_offset.y },
          {src: this.baseURL + "frame.png" },
        ])
          .then(response => {

            this.img_str = response;
          })
          .catch(error => {

            console.log(error.message);
            return undefined;
          });
      }
    }

  }
}
</script>

<style scoped>

  .sepia {
    filter: sepia(.75);
  }

</style>
