<template>
  <div>
    <template v-if="extended_info">
      <table>
        <tr v-for="award in character_decorations">
          <td v-if="award.awarded && awardImage(award.award_image)">
            <img
              v-bind:class="{ medalSmall: small_awards }"
              v-bind:src="awardImage(award.award_image)"
              v-bind:title="award.award_name"
            />
          </td>
          <td>
            {{ award.decoration_date }}
          </td>
        </tr>
      </table>

    </template>
    <template v-else v-for="award in character_decorations">
      <img
        v-if="award.awarded && awardImage(award.award_image)"
        v-bind:class="{ medalSmall: small_awards }"
        v-bind:src="awardImage(award.award_image)"
        v-bind:title="award.award_name"
      />
    </template>

  </div>
</template>

<script>

export default {
  name: "AwardComp",
  props: {
    character_id: {
      type: [Number, String],
      default: 0
    },
    small_awards: {
      type: Boolean,
      default: false
    },
    extended_info: {
      type: Boolean,
      default: false
    },
    character_decorations: {
      type: Array,
      default: function () {
        return [];
      }
    },
  },
  computed: {

  },
  methods: {

    awardImage: function (award_image) {

      var baseURL = "/assets/images/";
      if(
        award_image != "MedalAB" &&
        award_image != "MedalFBA.png" &&
        award_image != "MedalFBAgd.png" &&
        award_image != "MedalAB_VVS.png")
      {
        return baseURL + "medals_big/" + award_image;
      } else {
        return false;
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
