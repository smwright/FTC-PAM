<template>
  <div class="container">
    <h2>Add media:</h2>
    <div class="clearfix">
      <div class="float-left split-div-60">
        <div>
          <span class="heading">Media type:</span>
          <select v-model="media_type">
            <option v-for="(type, index) in mediaType" v-bind:value="index">
              {{ type }}
            </option>
          </select>
        </div>

        <div>
          <span class="heading">Media URL:</span>
          <input v-model="media_url">
        </div>

        <div class="container" v-if="media_type === 0">
          <img class="image_icon" :src="media_url"/>
        </div>
        <div class="container" v-else-if="media_type === 1">
          <div class="">
            <YoutubeWrapper v-bind:video_id="media_url"></YoutubeWrapper>
          </div>
        </div>

        <div>
          <span class="heading">Description:</span>
          <textarea class="textarea-style" v-model="description"></textarea>
        </div>

        <div>
          <div class="heading">Tags:</div>
          <div class="clearfix">
            <div class="float-left width-40">
              <div class="heading">Campaign</div>
              <vSelect
                v-model="campaign_tags"
                v-bind:options="campaigns"
                label="name"
                multiple
              ></vSelect>
            </div>

            <div class="float-left width-60">
              <div class="heading">Mission</div>
              <vSelect
                v-model="mission_tags"
                v-bind:options="filtered_missions"
                label="name"
                multiple
              ></vSelect>
            </div>
          </div>

          <div class="clearfix">
            <div class="float-left width-20">
              <div class="heading">ACG unit</div>
              <vSelect
                v-model="acg_unit_tags"
                v-bind:options="acg_units"
                label="name"
                multiple
              ></vSelect>
            </div>

            <div class="float-left width-40">
              <div class="heading">Historical unit</div>
              <vSelect
                v-model="hist_unit_tags"
                v-bind:options="filtered_hist_units"
                label="name"
                multiple
              ></vSelect>
            </div>

            <div class="float-left width-40">
              <div class="heading">Asset</div>
              <vSelect
                v-model="asset_tags"
                v-bind:options="assets"
                label="name"
                multiple
              ></vSelect>
            </div>
          </div>

          <div class="clearfix">
            <div class="float-left width-20">
              <div class="heading">ACG member</div>
              <vSelect
                v-model="acg_member_tags"
                v-bind:options="acg_members"
                label="callsign"
                multiple
              ></vSelect>
            </div>

            <div class="float-left width-40">
              <div class="heading">Characters</div>
              <vSelect
                v-model="character_tags"
                v-bind:options="filtered_characters"
                label="name"
                multiple
              ></vSelect>
            </div>
          </div>

        </div>

      </div>

      <div class="float-right split-div-40">


          HELPO TEST'

        <div>
          {{ campaign_tags }}
        </div>
        <div>
          {{ mission_tags }}
        </div>
        <div>
          {{ acg_unit_tags }}
        </div>
        <div>
          {{ hist_unit_tags }}
        </div>
        <div>
          {{ acg_member_tags }}
        </div>
        <div>
          {{ character_tags }}
        </div>

      </div>


    </div>


  </div>

</template>

<script>
import { mapState, mapGetters } from "vuex"
import vSelect from 'vue-select'
import statConv from "../../resource/statusConverter"
import YoutubeWrapper from "../basic_comp/YoutubeWrapper"

export default {
  name: "AddMediaComp",
  mixins: [statConv],
  components: {
    YoutubeWrapper,
    vSelect
  },
  mounted ()  {

    this.$store.dispatch('mediaStore/loadStoreData',
      {
        caller: this.$options.name,
        call_object: {
          view: "campaign",
        },
        data_array_name: "campaigns"
      }
    ).catch(error => {
      console.log(error.message);
    });

    this.$store.dispatch('mediaStore/loadStoreData',
      {
        caller: this.$options.name,
        call_object: {
          view: "campaign_mission_info",
        },
        data_array_name: "missions"
      }
    ).catch(error => {
      console.log(error.message);
    });

    this.$store.dispatch('mediaStore/loadStoreData',
      {
        caller: this.$options.name,
        call_object: {
          view: "acg_unit",
        },
        data_array_name: "acg_units"
      }
    ).catch(error => {
      console.log(error.message);
    });

    this.$store.dispatch('mediaStore/loadStoreData',
      {
        caller: this.$options.name,
        call_object: {
          view: "hist_unit_info",
        },
        data_array_name: "hist_units"
      }
    ).catch(error => {
      console.log(error.message);
    });

    this.$store.dispatch('mediaStore/loadStoreData',
      {
        caller: this.$options.name,
        call_object: {
          view: "depl_unit_info",
        },
        data_array_name: "depl_units"
      }
    ).catch(error => {
      console.log(error.message);
    });

    this.$store.dispatch('mediaStore/loadStoreData',
      {
        caller: this.$options.name,
        call_object: {
          view: "acg_member",
        },
        data_array_name: "acg_members"
      }
    ).catch(error => {
      console.log(error.message);
    });

    this.$store.dispatch('mediaStore/loadStoreData',
      {
        caller: this.$options.name,
        call_object: {
          view: "career_character_info",
        },
        data_array_name: "characters"
      }
    ).catch(error => {
      console.log(error.message);
    });

    this.$store.dispatch('mediaStore/loadStoreData',
      {
        caller: this.$options.name,
        call_object: {
          view: "asset_info",
        },
        data_array_name: "assets"
      }
    ).catch(error => {
      console.log(error.message);
    });

  },
  data() {
    return {
      media_type: null,
      media_url: null,
      description: null,
      campaign_tags: [],
      mission_tags: [],
      acg_unit_tags: [],
      hist_unit_tags: [],
      acg_member_tags: [],
      character_tags: [],
      asset_tags: []
    }
  },
  computed: {

    filtered_missions: function () {

      if(this.campaign_tags.length > 0){
        let c_array = this.campaign_tags.map(item => item.id);
        return this.missions.filter(
          function (item) {
            return c_array.includes(item.campaign_id);
          }
        )
      } else {
        return this.missions;
      }

    },

    filtered_hist_units: function () {


      if(this.campaign_tags.length > 0){
        let c_array = this.campaign_tags.map(item => item.id);
        let du_array = this.depl_units.filter(
          function (item) {
            return c_array.includes(item.campaign_id);
          }
        ).map(item => item.hist_unit_id);
        return this.hist_units.filter(
          function (item) {
            return du_array.includes(item.id);
          }
        )
      } else {
        return this.hist_units;
      }
    },

    filtered_characters: function () {


      if(this.acg_member_tags.length > 0){
        let m_array = this.acg_member_tags.map(item => item.id);
        return this.characters.filter(
          function (item) {
            return m_array.includes(item.member_id);
          }
        )
      } else {
        return this.characters;
      }
    },


    ...mapState('mediaStore', {
      campaigns: state => state.campaigns,
      missions: state => state.missions,
      acg_units: state => state.acg_units,
      hist_units: state => state.hist_units,
      depl_units: state => state.depl_units,
      acg_members: state => state.acg_members,
      characters: state => state.characters,
      assets: state => state.assets
    }),

    ...mapGetters("mediaStore", [

    ])
  },
}
</script>

<style scoped>

.image_icon {
  max-width: 640px;
  max-height: 320px;
}

.textarea-style{
  width: 98%;
  height: 10em;
}


</style>
