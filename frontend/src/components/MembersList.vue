<template>
  <div class="all-members">
    <h1>Members</h1>
    <p>These pages list all registered ACG members with their corresponding names, callsigns, joining- and eventually discharge dates, their status and their current squadron. Click on any member to access a detailed profile.</p>
    <table>
      <tr>
        <th>Rank</th>
        <th>Callsign</th>
        <th>Joining Date</th>
        <th>Last status change</th>
        <th>Current Status</th>
        <th>Current Squadron/Staffel</th>
      </tr>
      <tr class="link" v-for="member in members" v-on:click="routeToMember(member.member_id)">
        <td>{{member.rank}}</td>
        <td>{{member.callsign}}</td>
        <td>{{member.joining_date}}</td>
        <td>{{member.last_status_change}}</td>
        <td>{{member.current_status}}</td>
        <td>{{member.current_squadron}}</td>
      </tr>
    </table>
  </div>
</template>

<script>
import Member from './../resource/member'

export default {
  name: 'AllMembers',
  created: function () {
    this.getMembers()
  },
  data () {
    return {
      members: []
    }
  },
  methods: {
    getMembers: function () {
      Member.getAll().then((data) => {
        this.members = data;
      }, (err) => {
        console.log(err)
      })
    },
    routeToMember: function (memberID) {
      this.$router.push({name: 'Member', params: {member_id: memberID}})
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
