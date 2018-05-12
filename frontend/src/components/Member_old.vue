<template>
  <div class="member">
    <h1>Member profile</h1>
    <p>This page shows the profile for {{member.name}}. The displayed information is based on submitted and approved After Action Reports.</p>
    <h2>General information</h2>
    <table>
       <tr>
        <td>Name: </td><td>{{member.name}}</td>
      </tr>
      <tr>
        <td>Status: </td><td>{{member.status}}</td>
      </tr>
      <tr>
        <td>Length of service: </td><td>{{member.length_of_service}}</td>
      </tr>
   </table>
   <h2>Sorties overview</h2>
    <table>
      <tr>
        <td>Pilot status</td><td></td><td>Aircraft status</td><td></td><td>Victories LW</td><td></td>
      </tr>
      <tr>
        <td>OK:</td><td>{{member.pilot_status_ok}}</td>
        <td>OK:</td><td>{{member.aircraft_status_ok}}</td>
        <td>unconfirmed:</td><td>{{member.victories_lw_unconfirmed}}</td>
      </tr>
      <tr>
        <td>KIA:</td><td>{{member.pilot_status_kia}}</td>
        <td>Damaged:</td><td>{{member.aircraft_status_damaged}}</td>
        <td>confirmed:</td><td>{{member.victories_lw_confirmed}}</td>
      </tr>
      <tr>
        <td></td><td></td>
        <td>Lost:</td><td>{{member.aircraft_status_lost}}</td>
        <td></td><td></td>
      </tr>
    </table>
    <h2>Status updates</h2>
    <table>
      <tr>
        <th>Status</th>
        <th>Date</th>
      </tr>
      <tr v-for="status_update in member.status_updates">
        <td>{{status_update.status}}</td>
        <td>{{status_update.date}}</td>
      </tr>
    </table>
    <h2>Transfer overview</h2>
    <table>
      <tr>
        <th>Date</th>
        <th>To Squadron/Staffel</th>
      </tr>
      <tr v-for="transfer in member.transfers">
        <td>{{transfer.date}}</td><td>{{transfer.to}}</td>
      </tr>
    </table>
    <h2>Promotion/Demotion overview</h2>
    <table>
      <tr>
        <th>Date</th>
        <th>To rank</th>
        <th>Comment</th>
      </tr>
      <tr v-for="rank_change in member.rank_changes">
        <td>{{rank_change.date}}</td>
        <td>{{rank_change.rank}}</td>
        <td>{{rank_change.comment}}</td>
      </tr>
    </table>
  </div>
</template>

<script>
import Member from './../resource/member'

export default {
  name: 'Member',
  created () {
    this.getMember()
  },
  data () {
    return {
      member: {}
    }
  },
  methods: {
    getMember () {
      Member.get(this.$route.params.member_id).then((data) => {
        this.member = data
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
