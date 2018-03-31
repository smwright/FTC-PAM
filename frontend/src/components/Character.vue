<template>
  <div class="character">
    <h1>Character</h1>
    <p>This page shows the profile for {{character.fullname}}. The displayed information is based on submitted and approved After Action Reports.</p>
    <h2>General information</h2>
    <table>
      <tr>
        <td>Name:</td><td>{{character.fullname}}</td>
      </tr>
      <tr>
        <td>Callsign:</td><td>{{character.callsign}}</td>
      </tr>
      <tr>
        <td>Status:</td><td>{{character.kia}}</td>
      </tr>
    </table>
    <table v-for="campaign in character.campaigns">
      <tr>
        <td>Campaign:</td><td>{{campaign.campaign_name}}</td>
      </tr>
      <tr>
        <td>Service period:</td><td>{{campaign.service_period}}</td>
      </tr>
      <tr>
        <td>Length of service:</td><td>{{campaign.length_of_service}}</td>
      </tr>
    </table>
    <h2>Sorties overview</h2>
    <span>Sorties: {{character.sorties}}</span>
    <table>
      <tr>
        <th>Pilot status</th><th></th>
        <th>Aircraft status</th><th></th>
        <th>Victories LW</th><th></th>
        <th>Ground victories</th>
      </tr>
      <tr>
        <td>OK:</td><td>{{character.pilot_status_ok}}</td>
        <td>OK:</td><td>{{character.aircraft_status_ok}}</td>
        <td>unconfirmed:</td><td>{{character.victories_lw_unconfirmed}}</td>
      </tr>
      <tr>
        <td>Wounded:</td><td>{{character.pilot_status_wounded}}</td>
        <td>Damaged:</td><td>{{character.aircraft_status_damaged}}</td>
        <td>confirmed:</td><td>{{character.victories_lw_confirmed}}</td>
      </tr>
      <tr>
        <td>KIA:</td><td>{{character.pilot_status_kia}}</td>
        <td>Lost:</td><td>{{character.aircraft_status_lost}}</td>
        <td></td><td></td>
      </tr>
    </table>
    <h2>Transfer overview</h2>
    <table>
      <tr>
        <th>Date</th>
        <th>To Squadron/Staffel</th>
      </tr>
      <tr v-for="transfer in character.transfers">
        <td>{{transfer.date}}</td>
        <td>{{transfer.to}}</td>
      </tr>
    </table>
    <h2>Promotion/Demotion overview</h2>
    <table>
      <tr>
        <th>Date</th>
        <th>To rank</th>
        <th>Comment</th>
      </tr>
      <tr v-for="rank_change in character.rank_changes">
        <td>{{rank_change.date}}</td>
        <td>{{rank_change.rank}}</td>
        <td>{{rank_change.comment}}</td>
      </tr>
    </table>
  </div>
</template>

<script>
import Character from './../resource/character'

export default {
  name: 'Character',
  created () {
    this.getCharacter()
  },
  data () {
    return {
      character: {}
    }
  },
  methods: {
    getCharacter () {
      Character.get(this.$route.params.character_id).then((data) => {
        this.character = data
        this.character.fullname = data.firstname + " " + data.lastname
      }, (err) => {
        console.log(err)
      })
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
