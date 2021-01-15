<template>
  <div>
    <div class="heading">Briefing</div>
      <div v-if="briefing_info !== undefined" class="white-space-pre-line">
        <template v-if="is_authorized | briefing_info.faction == 0 | briefing_info.mission_status == 2">
          <TextWithImage
            class="typed-on-paper"
            v-bind:original_text="this.decodeHTML(briefing_info.text)"
            v-bind:allow_markdown="true"
          ></TextWithImage>
          <!--{{ this.decodeHTML(briefing_info.text) }}-->
        </template>
        <template v-else>
          <TextWithImage
            class="typed-on-paper"
            v-bind:original_text="this.decodeHTML(this.encryptBriefing(briefing_info.text, 5))"
          ></TextWithImage>
          <!--{{ this.encryptBriefing(briefing_info.text, 5) }}-->
        </template>
      </div>
  </div>
</template>

<script>
import { mapState, mapGetters } from "vuex"
import stringConv from "../../resource/stringConverter"
import TextWithImage from "../basic_comp/TextWithImages"

export default {
  name: "Briefing",
  components: {
    TextWithImage
  },
  mixins: [stringConv],
  mounted () {

    this.checkAuthentication();
  },
  beforeRouteUpdate (to, from, next) {
    // called when the route that renders this component has changed,
    // but this component is reused in the new route.
    // For example, for a route with dynamic params `/foo/:id`, when we
    // navigate between `/foo/1` and `/foo/2`, the same `Foo` component instance
    // will be reused, and this hook will be called when that happens.
    // has access to `this` component instance.
    this.checkAuthentication();
    next();
  },

  data () {
    return {
      is_authorized: false,
    }
  },
  computed: {

    briefing_info: function () {

      let briefing = this.filterByKeys("briefings",
        {
          mission_id: this.$route.params.mission_id,
          faction: this.$route.params.briefing_faction
        }
      );
      return briefing[0];
    },

    ...mapGetters("missionStore", [
      "filterByKeys",
    ])
  },
  methods: {

    checkAuthentication: function () {

      this.$auth.getFaction(this.$options.name, this.$route.params.mission_id)
        .then(response => {
          this.is_authorized = response[0].faction == this.$route.params.briefing_faction;
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
}
</script>

<style scoped>

</style>
