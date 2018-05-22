<template>
  <div class="CampaignInfoMissions">
    <p>Here you find a list of all missions of the campaign {{campaign_id}}.</p>
    <table>
      <tr>
        <th>ID:</th>
        <th>Name:</th>
        <th>Date:</th>
        <th>Historic Date:</th>
        <th>Status:</th>
      </tr>
      <tr class="link" v-for="mission in missions" v-on:click="">
        <td>{{mission.id}}</td>
        <td>{{mission.name}}</td>
        <td>{{mission.real_date}}</td>
        <td>{{mission.hist_date}}</td>
        <td>{{mission.mission_status}}</td>
      </tr>
    </table>
  </div>
</template>

<script>
import Missions from './../resource/missions'

export default {
  name: 'CampaignInfoMissions',
  created () {
    this.getMissions()
  },
  data () {
    return {
      missions: {},
      campaign_id: this.$route.params.campaign_id
    }
  },
  methods: {
    getMissions () {
      Missions.get(this.$route.params.campaign_id).then((data) => {
        this.missions = data
      }, (err) => {
        console.log(err)
      })
    }
  }
}


</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style>

</style>
