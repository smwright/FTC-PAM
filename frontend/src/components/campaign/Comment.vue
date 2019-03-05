<template>
  <div>
    <div v-if="comment_info != null" v-for="comment in comment_info">
      <span>Comment by {{ comment.commentator }}</span>
      <span class="float-right">{{ comment.comment_date }}</span>
      <p>{{ decodeHTML(comment.comment_text) }}</p>
      <hr>
    </div>
  </div>
</template>

<script>
import stringConv from "../../resource/stringConverter"

export default {
  name: "Comment",
  mixins: [stringConv],
  mounted () {

    this.$dbCon.requestViewData(this.$options.name, {view:"comment_info", report_id:this.$route.params.report_id})
      .then(response => {
        this.comment_info = response;
      })
      .catch(error => {
        console.log(error.message);
      });
  },
  data () {
    return {
      comment_info: null
    }
  }
}
</script>

<style scoped>

</style>
