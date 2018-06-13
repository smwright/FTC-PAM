<template>
  <div class="MembersList">
    <h1>Members</h1>
    <p>These pages list all registered ACG members with their corresponding names, callsigns, joining- and eventually discharge dates, their status and their current squadron. Click on any member to access a detailed profile.</p>
    <div class="link-list" v-for="(member, id) in members" v-on:click="routeToMember(member.id)">
      <div class="link-list-heading">
        {{ member.callsign}}
      </div>
      <div class="multi-line-link-button">
        <div>
          <span>Joining date: {{ member.jdate }}</span>
          <span>Current status: {{ currentStatus(member.cstatus) }}</span>
        </div>
        <div>
          <span>Length of service: {{ member.length_of_service}}</span>
          <span>Campaigns: {{ member.campaigns }}</span>
          <span>Sorties: {{ member.sorties }}</span>
        </div>
      </div>
      <div class="div-rank-value">
        {{ member.rank_value }}
      </div>
    </div>
  </div>
</template>

<script>
import Mockcom from './../resource/index'
import {memberStatus}  from '../resource/statusConverter'

export default {
  name: 'MembersList',
  mounted () {
    Mockcom.getByName('members')
      // .then(response => {
      //  return this.addCampaigns(response);
      // })
      .then(response => {
        this.members = response;
      })
      .catch(function (error) {
        console.log(error.message);
      })

  },
  data () {
    return {
      members: null,
      currentStatus: memberStatus
    }
  },
  methods: {
    // addCampaigns: async function (members) {
    //
    //   for(var i = 0; i < members.length; i++) {
    //     var m_id = members[i].id % 3 + 1;
    //     var campaign_call = Mockcom.getByName('members_c_info_' + m_id);
    //     try {
    //       members[i].campaigns = await campaign_call;
    //     } catch (err) {
    //       console.log(err.message)
    //     }
    //   }
    //   return members;
    // }

  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  .div-rank-value {
    float: right;
    display: inline-block;
    width: calc(10% - 4px); /* Whished widht in % minus 2x border size */
    text-align: center;
  }

</style>
