<template>
  <div>
    <div>
      <div class="inline">
        <span class="link-list-heading">{{ name }}</span>
      </div>
      <div class="inline float-right">
        <span v-if="primary">Primary campaign</span>
        <span v-else>Side campaign</span>
        <span>{{ campaignStatus(campaign_status) }}</span>
      </div>
    </div>
    <div>
      <span>Platform: {{ platformTxt(platform) }}</span>
      <span>Time: {{ time }}</span>
    </div>
    <div>
      <span>Number of participating units: {{ units }}</span>
      <span>Missions completed: {{ missions }}</span>
      <span>Sorties flown: {{ sorties }}</span>
    </div>
    <div>
      <span>Average participants per mission: {{ avg_attendance }}</span>
    </div>
    <div v-if="description !== null">
      <button v-on:click.stop="toggleDescription">{{showDescriptionButtonText}}</button>
      <div v-show="showDescription">{{description}}</div>
    </div>
  </div>
</template>

<script>
  import {platform, campaignStatus} from './../resource/statusConverter'
  export default {
    name: "CampaignInfoBaseComp",
    props: {
      name: String,
      primary: Number,
      campaign_status: Number,
      platform: Number,
      time: String,
      units: Number,
      missions: Number,
      sorties: Number,
      avg_attendance: Number,
      description: {
        type: String,
        default: null
      }
    },
    data () {
      return {
        platformTxt: platform,
        campaignStatus: campaignStatus,
        showDescription: false,
        showDescriptionButtonText: "Show description"
      }
    },
    methods: {

      toggleDescription: function () {
        this.showDescription = !this.showDescription
        if(this.showDescription) {
          this.showDescriptionButtonText = "Hide description"
        } else {
          this.showDescriptionButtonText = "Show description"
        }
      }
    },
  }
</script>

<style scoped>

</style>
