<template>
  <div>
    <div>
      <div class="inline-block">
        <span class="heading">{{ name }}</span>
      </div>
      <div class="inline-block float-right">
        <span v-if="is_primary">Primary campaign</span>
        <span v-else>Side campaign</span>
        <span>{{ this.campaignStatus[campaign_status] }}</span>
      </div>
    </div>
    <div>
      <span>Platform: {{ this.simPlatform[platform] }}</span>
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
      <HideableDiv v-bind:changing-button="true">
        <template slot="buttonVisible">
          <button>Hide description</button>
        </template>
        <template slot="buttonHidden">
          <button>Show description</button>
        </template>
        <div>{{description}}</div>
      </HideableDiv>
    </div>
  </div>
</template>

<script>
  import statConv from '../../resource/statusConverter'
  import HideableDiv from '../basic_comp/HideableDiv'

  export default {
    name: "CampaignInfoBaseComp",
    components: {HideableDiv},
    mixins: [statConv],
    props: {
      name: String,
      is_primary: Number,
      campaign_status: Number,
      platform: Number,
      time: [String, Number],
      units: Number,
      missions: Number,
      sorties: Number,
      avg_attendance: Number,
      description: {
        type: String,
        default: null
      }
    },
  }
</script>

<style scoped>

</style>
