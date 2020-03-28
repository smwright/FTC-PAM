<template>
  <div class="clearfix">
    <div class="float-left width-10">
      <img
        v-if="award_image != ''"
        class="medalSmall"
        v-bind:src="awardImage(award_image)"
        v-bind:title="award_name"
      />
    </div>
    <div class="float-right width-90">
      <div>
        <span class="inline-block width-5">{{ decoration_id }}</span>
        <span class="inline-block width-60">{{ award_name }}</span>
        <span class="inline-block width-20">
          <date-picker
            v-model="decoration_date"
            lang="en"
            type="date"
            format="YYYY-MM-DD"
            value-type="format"
            v-bind:clearable="false">
          </date-picker>
        </span>
        <span class="inline-block width-5" >
          <button v-if="awarded" v-on:click="awardRevokeDecoration(0)">Revoke</button>
          <button v-else v-on:click="awardRevokeDecoration(1)">Award</button>
        </span>
      </div>
      <div>
        <span class="full-width">
          <textarea v-model="decoration_comment" class="textarea-style full-width"></textarea>
        </span>
      </div>
    </div>
  </div>
</template>

<script>
  import DatePicker from 'vue2-datepicker'

  export default {
    name: "MemberCharacterComp",
    components: {
      DatePicker
    },
    props: {
      decoration_id: {
        type: Number,
        default: 0
      },
      award_name: {
        type: String,
        default: ""
      },
      awarded: {
        type: Number,
        default: 0
      },
      award_image: {
        type: String,
        default: ""
      },
      rank_disp_value: {
        type: Number,
        default: 0
      }
    },
    computed: {

      decoration_date: {
        get () {

          var decoration = this.$store.getters['characterStore/decorationsById'](this.decoration_id);
          return (decoration !== undefined) ? decoration.decoration_date : "";
        },
        set (value) {

          this.$store.commit('characterStore/updateValue',
            {
              array_name: "decorations",
              id_column_name: "decoration_id",
              id_column_value: this.decoration_id,
              update_column_name: "decoration_date",
              update_column_value: value
            });
        }
      },

      decoration_comment: {
        get () {

          var decoration = this.$store.getters['characterStore/decorationsById'](this.decoration_id);
          return (decoration !== undefined) ? decoration.decoration_comment : "";
        },
        set (value) {

          this.$store.commit('characterStore/updateValue',
            {
              array_name: "decorations",
              id_column_name: "decoration_id",
              id_column_value: this.decoration_id,
              update_column_name: "decoration_comment",
              update_column_value: value
            });
        }
      },
    },
    methods: {

      awardRevokeDecoration: async function (awarded) {

        this.$store.dispatch('characterStore/awardRevokeDecoration',
          {
            caller: this.$options.name,
            id: this.decoration_id,
            member_id: await this.$auth.getUserId(),
            awarded: awarded
          });
      },

      awardImage: function (award_image) {

        var baseURL = "/assets/images/";
        if(award_image === "MedalAB") {
          if(this.rank_disp_value < 8){

            award_image = "MedalABFabric.png";
          } else {

            award_image = "MedalABBrass.png";
          }
        }
        return baseURL + "medals_big/" + award_image;
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
