<template>
  <div class="members">
   <h1>Members</h1>
    <p>These pages list all registered ACG members.</p>
    <table>
      <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Callsign</th>
        <th>Admin</th>
        <th>Map Viewer</th>
        <th>Mission Builder</th>
      </tr>
      <tr class="link" v-for="member in members" v-on:click="routeToMember(member.member_id)">
        <td>{{member.id}}</td>
        <td>{{member.username}}</td>
        <td>{{member.callsign}}</td>
        <td>{{member.admin}}</td>
        <td>{{member.map_viewer}}</td>
        <td>{{member.mission_builder}}</td>
      </tr>
    </table>
  </div>
</template>

<script>
import Member from './../resource/member'

export default {
  name: 'Members',
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
    // routeToMember: function (memberID) {
    //   this.$router.push({name: 'Member', params: {member_id: memberID}})
    // }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
