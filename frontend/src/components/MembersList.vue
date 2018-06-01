<template>
  <div class="MembersList">
    <h1>Members</h1>
    <p>These pages list all registered ACG members with their corresponding names, callsigns, joining- and eventually discharge dates, their status and their current squadron. Click on any member to access a detailed profile.</p>
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
import Mockcom from './../resource/index'

export default {
  name: 'MembersList',
  mounted () {
    Mockcom.getByName('members')
      .then(response => {
       return this.addCampaigns(response);
      })
      .then(response => {
        this.members = response;
      })
      .catch(function (error) {
        console.log(error.message);
      })

  },
  data () {
    return {
      members: null
    }
  },
  methods: {
    addCampaigns: async function (members) {

      for(var i = 0; i < members.length; i++) {
        var m_id = members[i].id % 3 + 1;
        var campaign_call = Mockcom.getByName('members_c_info_' + m_id);
        try {
          members[i].campaigns = await campaign_call;
        } catch (err) {
          console.log(err.message)
        }
      }
      return members;
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
