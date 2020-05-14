<template>
  <iframe :width="width" :height="height" :src="video_url" allowfullscreen></iframe>
</template>

<script>
export default {
  name: "YoutubeWrapper",
  props: {
    video_id: {
      type: String,
      default: null
    },
    youtube_url: {
      type: String,
      default: "//www.youtube-nocookie.com/embed/"
    },
    width: {
      type: Number,
      default: 640
    },
    height: {
      type: Number,
      default: 320
    }
  },
  computed: {
    video_url: function () {
      return this.youtube_url + this.video_id;
    }
  }
}
</script>

<style scoped>

</style>
