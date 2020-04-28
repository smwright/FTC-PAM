<template>
  <div
    class="root"
    v-on:click="launchFilePicker()"
    v-on:mouseover="changeFocus(true)"
    v-on:mouseleave="changeFocus(false)"
  >
    <img
      v-if="value"
      class="size-100"
      :src="value.getAll('imageURL')"
    >
    <div
      class="centered heading"
      v-show="showText"
    >
      {{ buttonText }}
    </div>
    <input
      type="file"
      ref="file"
      v-on:change="onFileChange($event.target.name, $event.target.files)"
      style="display:none"
    >
  </div>

</template>

<script>


export default {
  name: "ImageUpload",
  props: {
    // Use "value" here to enable compatibility with v-model
    value: FormData,
    buttonText: {
      type: String,
      default: "Select Image"
    },
    savePath: {
      type: String,
      default: "/assets/images/",
    }
  },
  data () {
    return {

      hasFocus: false,
    }
  },
  computed: {
    showText: function () {

      return this.hasFocus || !this.value;
    }
  },
  methods: {

    changeFocus: function (isOver) {

      this.hasFocus = isOver;
    },

    launchFilePicker: function () {
      this.$refs.file.click();
    },

    onFileChange: function (fieldName, file) {
      let imageFile = file[0];
      if (file.length>0) {

        if (!(imageFile && imageFile['type'].split('/')[0] === 'image')) {
          // check whether the upload is an image

          alert('Please choose an image file');
        } else {

          // Append file into FormData and turn file into image URL
          let formData = new FormData();
          let imageURL = URL.createObjectURL(imageFile);

          formData.append("file", imageFile);
          formData.append("imageURL", imageURL);
          formData.append("path", this.savePath);
          // Emit the FormData and image URL to the parent component
          this.$emit('input',  formData );
        }
      }
    }

  }
}
</script>

<style scoped>

.size-100{

  height: 100%;
  width: 100%;
}

.root{

  position: relative;
  text-align: center;
  background: rgba(0, 0, 0, 0.1);
}

.root:hover{
  cursor: pointer;
}

.centered {
  height: 20%;
  width: 100%;
  position: absolute;
  top: 40%;
  background: rgba(0, 0, 0, 0.3);

}


</style>
