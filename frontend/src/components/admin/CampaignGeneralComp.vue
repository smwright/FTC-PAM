<template>
  <div>
    <div class="clearfix container">
      <div class="inline-table float-left half-width">
        <label>Name</label>
        <input v-model="campaign_name">
      </div>
      <div class="inline-table float-right half-width">
        <span>Name of the campaign</span>
      </div>
    </div>

    <div class="clearfix container">
      <div class="inline-table float-left half-width">
        <label>Primary</label>
        <input type="checkbox" id="checkbox" v-model="primary" true-value="1" false-value="0">
      </div>
      <div class="inline-table float-right half-width">
            <span>Primary campaigns is used for the ACG's main historical Sunday campaign. Secondary campaigns are for all
            other campaigns. There can only be one active primary campaign at all time.</span>
      </div>
    </div>

    <div class="clearfix container">
      <div class="inline-table float-left half-width">
        <div>
          <label>Platform:</label>
          <select v-model="platform">
            <option v-for="(platform, index) in simPlatform" v-bind:value="index">
              {{ platform }}
            </option>
          </select>
        </div>
      </div>
      <div class="inline-table float-right half-width">
        <span>Choose one of the available simulation platforms. </span>
      </div>
    </div>

    <div class="clearfix container">
      <div class="inline-table float-left half-width">
        <label>Campaign status</label>
        <select v-model="campaign_status">
          <option v-for="(c_status, index) in campaignStatus" v-bind:value="index">
            {{ c_status }}
          </option>
        </select>
      </div>
      <div class="inline-table float-right half-width">
        <ul>
          <li><b>In preparation:</b> Used for future campaigns in the planning phase.</li>
          <li><b>Ongoing:</b> Used for active campaigns. There can only be on ongoing primary campaign at all
            time</li>
          <li><b>Finished:</b> Past and finished campaigns.</li>
        </ul>
      </div>
    </div>

    <div class="clearfix container">
      <div class="inline-table float-left half-width">
        <label>Time:</label>
        <input v-model="time">
      </div>
      <div class="inline-table float-right half-width">
        <span>Time the campaign missions take place, i.e. "Sunday's 1900 GMT". Please specify the time zone.</span>
      </div>
    </div>

    <div class="clearfix container">
      <div class="inline-table float-left half-width">
        <label>Open</label>
        <input type="checkbox" id="open" v-model="open" true-value="1" false-value="0">
      </div>
      <div class="inline-table float-right half-width">
        <span>Open campaigns are accessible for non-acg members.</span>
      </div>
    </div>

    <!--<div class="clearfix container">-->
      <!--<div class="inline-table float-left half-width">-->
        <!--<div>-->
          <!--<label>Campaign link:</label>-->
          <!--<select v-model="campaign_link">-->
            <!--<option v-bind:value="null"></option>-->
            <!--<option-->
              <!--v-for="(l_campaign) in $store.state.campaignAdmin.campaigns"-->
              <!--v-if="l_campaign.id !== campaign_id"-->
              <!--v-bind:value="l_campaign.id"-->
            <!--&gt;-->
              <!--{{ l_campaign.name }}-->
            <!--</option>-->
          <!--</select>-->
        <!--</div>-->
      <!--</div>-->
      <!--<div class="inline-table float-right half-width">-->
            <!--<span>Link the campaign to an existing campaign. This will allow members to reuse characters of the linked-->
            <!--campaign in this campaign.</span>-->
      <!--</div>-->
    <!--</div>-->

    <div class="clearfix container">
      <div class="inline-table float-left half-width">
        <div>
          <label>Description</label>

        </div>
        <textarea v-model="description" class="textarea-style"></textarea>
      </div>
      <div class="inline-table float-right half-width">
        <span>Describing the historical setting of the campaign and other relevant info.</span>
      </div>
    </div>

    <div class="clearfix container">
      <div class="inline-table float-left half-width">
        <label>Image</label>
        <input v-model="image">
        <div>
          <img class="img-container" :src="image"/>
        </div>
      </div>
      <div class="inline-table float-right half-width">
        <span>Set an image for the campaign.</span>
      </div>
    </div>

  </div>
</template>

<script>
import statConv from "../../resource/statusConverter"

export default {
  name: "CampaignGeneralComp",
  mixins: [statConv],
  props: {
    campaign_id: {
      type: Number,
      default: 0
    }
  },

  computed: {

    campaign_name: {
      get () {
          var campaign = this.$store.getters['campaignAdmin/campaignById']( this.$props.campaign_id );
          return (campaign !== undefined) ? campaign.name : "";
      },
      set (value) {
        // this.$store.commit('campaignAdmin/updateName', {id: this.$route.params.campaign_id, value: value});
        this.$store.commit('campaignAdmin/updateValue',
          {
            array_name: "campaigns",
            id_column_name: "id",
            id_column_value: this.$props.campaign_id,
            update_column_name: "name",
            update_column_value: value
          });
      }
    },

    primary: {
      get () {
          var campaign = this.$store.getters['campaignAdmin/campaignById']( this.$props.campaign_id );
          return (campaign !== undefined) ? campaign.is_primary : 0;
      },
      set (value) {
        this.$store.commit('campaignAdmin/updateValue',
          {
            array_name: "campaigns",
            id_column_name: "id",
            id_column_value: this.$props.campaign_id,
            update_column_name: "is_primary",
            update_column_value: value
          });
      }
    },

    platform: {
      get () {
          var campaign = this.$store.getters['campaignAdmin/campaignById']( this.$props.campaign_id );
          return (campaign !== undefined) ? campaign.platform : 0;
      },
      set (value) {
        this.$store.commit('campaignAdmin/updateValue',
          {
            array_name: "campaigns",
            id_column_name: "id",
            id_column_value: this.$props.campaign_id,
            update_column_name: "platform",
            update_column_value: value
          });
      }
    },

    campaign_status: {
      get () {
          var campaign = this.$store.getters['campaignAdmin/campaignById']( this.$props.campaign_id );
          return (campaign !== undefined) ? campaign.campaign_status : 0;
      },
      set (value) {
        this.$store.commit('campaignAdmin/updateValue',
          {
            array_name: "campaigns",
            id_column_name: "id",
            id_column_value: this.$props.campaign_id,
            update_column_name: "campaign_status",
            update_column_value: value
          });
      }
    },

    time: {
      get () {
          var campaign = this.$store.getters['campaignAdmin/campaignById']( this.$props.campaign_id );
          return (campaign !== undefined) ? campaign.time : "";
        // }
      },
      set (value) {
        this.$store.commit('campaignAdmin/updateValue',
          {
            array_name: "campaigns",
            id_column_name: "id",
            id_column_value: this.$props.campaign_id,
            update_column_name: "time",
            update_column_value: value
          });
      }
    },

    open: {
      get () {
          var campaign = this.$store.getters['campaignAdmin/campaignById']( this.$props.campaign_id );
          return (campaign !== undefined) ? campaign.open : 0;
      },
      set (value) {
        this.$store.commit('campaignAdmin/updateValue',
          {
            array_name: "campaigns",
            id_column_name: "id",
            id_column_value: this.$props.campaign_id,
            update_column_name: "open",
            update_column_value: value
          });
      }
    },

    campaign_link: {
      get () {
          var campaign = this.$store.getters['campaignAdmin/campaignById']( this.$props.campaign_id );
          return (campaign !== undefined) ? campaign.campaign_link : 0;
      },
      set (value) {
        this.$store.commit('campaignAdmin/updateValue',
          {
            array_name: "campaigns",
            id_column_name: "id",
            id_column_value: this.$props.campaign_id,
            update_column_name: "campaign_link",
            update_column_value: value
          });
      }
    },

    description: {
      get () {
          var campaign = this.$store.getters['campaignAdmin/campaignById']( this.$props.campaign_id );
          return (campaign !== undefined) ? campaign.description : null;
      },
      set (value) {
        this.$store.commit('campaignAdmin/updateValue',
          {
            array_name: "campaigns",
            id_column_name: "id",
            id_column_value: this.$props.campaign_id,
            update_column_name: "description",
            update_column_value: value
          });
      }
    },

    image: {
      get () {
          var campaign = this.$store.getters['campaignAdmin/campaignById']( this.$props.campaign_id );
          return (campaign !== undefined) ? campaign.image : null;
      },
      set (value) {
        this.$store.commit('campaignAdmin/updateValue',
          {
            array_name: "campaigns",
            id_column_name: "id",
            id_column_value: this.$props.campaign_id,
            update_column_name: "image",
            update_column_value: value
          });
      }
    },

  }

}
</script>

<style scoped>
.textarea-style{
  width: 98%;
  height: 10em;
}

.img-container{
  max-width: 100%;
}

</style>
