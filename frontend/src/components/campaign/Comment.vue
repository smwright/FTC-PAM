<template>
  <div>
    <template v-if="isAdmin">
      <div class="top-bottom-margin">
        <button
          v-bind:disabled="this.button_disabled"
          v-on:click="sendComment"
        >Send comment</button>
      </div>
      <div class="top-bottom-margin">
        <textarea v-model="comment" class="textarea-style"></textarea>
      </div>
    </template>
    <div class="top-bottom-margin" v-for="comment in comment_info">
      <span>{{ comment.comment_date }}:</span>
      <span>Comment by {{ comment.commentator }}</span>
      <button
        v-if="isAdmin"
        class="float-right"
        v-on:click="deleteComment(comment.comment_id)"
      >Delete</button>
      <p>{{ decodeHTML(comment.comment_text) }}</p>
      <hr>
    </div>
  </div>
</template>

<script>
import stringConv from "../../resource/stringConverter"
import { mapState } from "vuex"

export default {
  name: "Comment",
  mixins: [stringConv],
  mounted () {

  },
  data () {
    return {
      // comment_info: null
      comment: null,
      isAdmin: this.$auth.isAdmin(this.$options.name)
    }
  },
  computed: {

    button_disabled() {

      return this.comment === null || this.comment.length === 0;
    },

    ...mapState("missionStore", {
      comment_info: state => state.comments
    }),
  },
  methods: {

    sendComment: async function() {

      var now = new Date();
      var year = now.getFullYear();
      var month = now.getMonth() + 1;
      var day = now.getDate();
      this.$store.dispatch('missionStore/sendComment',
        {
          caller: this.$options.name,
          member_id: await this.$auth.getUserId(),
          comment_date: year+"-"+month+"-"+day,
          comment_text: this.comment,
          path: this.$route.path
        })
        .then(response => {
          this.comment = "";
        })
    },

    deleteComment: function (id) {

      this.$store.dispatch('missionStore/deleteComment',
        {
          caller: this.$options.name,
          id: id
        });
    }
  }
}
</script>

<style scoped>

.textarea-style{
  width: 98%;
  height: 10em;
}

.top-bottom-margin{
  margin: 5px 0px;
}

</style>
