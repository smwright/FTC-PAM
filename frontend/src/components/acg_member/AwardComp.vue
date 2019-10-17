<template>
  <div>
    <template v-for="award in filterByKey('character_decorations', 'character_id', character_id)">
      <img
        v-bind:class="{ medalSmall: small_awards }"
        v-bind:src="awardImage(award.award_image)"
        v-bind:title="award.award_name"
      />
    </template>

  </div>
</template>

<script>
import { mapState, mapGetters } from "vuex"

export default {
  name: "AwardComp",
  props: {
    character_id: {
      type: Number,
      default: 0
    },
    small_awards: {
      type: Boolean,
      default: false
    }
  },
  computed: {

    // ...mapState("memberInfo", {
    //
    //   status_log: state => state.member_status_log,
    //   transfer_log: state => state.transfer_log,
    //   promotion_log: state => state.promotion_log
    // }),

    ...mapGetters("memberInfo", [
      "filterByKey"

    ])

  },
  methods: {

    awardImage: function (award_image) {

      var baseURL = "/assets/images/";
      if(
        award_image !== "MedalAB" &&
        award_image !== "MedalFBA.png" &&
        award_image !== "MedalFBAgd.png" &&
        award_image !== "Aviation_Badge.png")
      {
        return baseURL + "medals_big/" + award_image;
      }

    }
  }
}
</script>

<style scoped>

.medalSmall {
  padding:2px;
  max-height: 90px;
  max-width: 100px;
  vertical-align: middle;
}

</style>
