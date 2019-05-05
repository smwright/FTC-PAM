<template>
  <div>
    <div class="heading">Briefing</div>
      <div class="white-space-pre-line">
        {{ this.decodeHTML(briefing_info.text) }}
        <!--{{ // this.encryptBriefing(briefing_info.text, 5) }}-->
      </div>
  </div>
</template>

<script>
import stringConv from "../../resource/stringConverter"

export default {
  name: "Briefing",
  mixins: [stringConv],
  mounted () {

    this.loadBriefing();
  },
  watch: {
    '$route.params.briefing_faction': function () {
      this.loadBriefing();
    }
  },
  methods: {

    loadBriefing: function () {
      this.$dbCon.requestViewData(this.$options.name,
        {view:"briefing", mission_id:this.$route.params.mission_id, faction:this.$route.params.briefing_faction})
        .then(response => {
          this.briefing_info = response[0];
        })
        .catch(error => {
          console.log(error.message);
        });
    },

    encryptBriefing: function (plainText, group_length) {

      var encryptedText = "";
      var chars = [..."ABCDEFGHIJKLMNOPQRSTUVWXYZ"];
      var lettergroups = Math.floor(plainText.length/group_length);
      var lettergroups_remainder = plainText.length % group_length;
      for (var i = 0; i < lettergroups; i++) {
        for (var j = 0; j < group_length; j++) {
          encryptedText += chars[Math.random()*chars.length|0];
        }
        encryptedText += " "
      }
      for (var i = 0; i < lettergroups_remainder; i++) {
        encryptedText += chars[Math.random()*chars.length|0];
      }

      return encryptedText;
    }

  },
  data () {
    return {
      briefing_info: {}
    }
  },
}
</script>

<style scoped>

</style>
