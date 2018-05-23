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
        <td>{{member.mapViewer}}</td>
        <td>{{member.missionBuilder}}</td>
      </tr>
    </table>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'Members',
  mounted () {
    axios.get("pam/acgMembers")
      .then(response => {
        this.members = response.data._embedded.acgMembers;
      })
      .catch(err => {
        console.log("call: "+call+" error: "+err)
      })
  },
  data () {
    return {
      members: null
    }
  },
  methods: {

  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
