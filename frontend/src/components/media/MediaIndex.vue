<template>
  <div>
    <div class="container clearfix">
      <button class="float-left" v-if="show_add_media_button" v-on:click="">Add media</button>
    </div>
    <AddMediaComp></AddMediaComp>
    NEDIA
  </div>

</template>

<script>
import AddMediaComp from "./AddMediaComp"

export default {
  name: "MediaIndex",
  components: {
    AddMediaComp
  },
  mounted () {

    this.check_add_media_button();

  },
  data () {

    return {

      show_add_media_button: false,
    }
  },
  methods: {

    check_add_media_button: async function() {

      var user_status = false;
      await this.$auth.getUserStatus(this.$options.name)
        .then(response => {
          //Member is active (status = 0)
          user_status = response === 0;
        })
        .catch(error => {
          console.log(error.message);
        });
      this.show_add_media_button = user_status;

    },
  }
}
</script>

<style scoped>

</style>
