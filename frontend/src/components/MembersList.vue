<template>
  <div class="MembersList">
    <h1>Members</h1>
    <p>These pages list all registered ACG members with their corresponding names, callsigns, joining- and eventually discharge dates, their status and their current squadron. Click on any member to access a detailed profile.</p>
    <div class="link" v-for="(member, id) in members" v-on:click="routeToMember(member.id)">
      <div class="callsign">
        {{ member.callsign}}
      </div>
      <div class="two-line-link-button">
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

export default {
  name: 'MembersList',
  mounted () {
    Mockcom.getByName('members')
      // .then(response => {
      //  return this.addCampaigns(response);
      // })
      .then(response => {
        this.members = response;
        console.log(JSON.stringify(this.members))
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
    currentStatus: function(cstatus) {
      switch (cstatus) {
        case 0:
          return "Active";
        case 1:
          return "Dismissed";
        case 2:
          return "Relieved from duty";
        case 3:
          return "Passed away";
        default:
          return cstatus;
      }
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  .div-rank-value {
    display: inline-block;
    width: calc(10% - 4px); /* Whished widht in % minus 2x border size */
    text-align: center;
    vertical-align: center;
  }

  .two-line-link-button {
    width: calc(90% - 4px); /* Whished widht in % minus 2x border size */
    display: inline-block;
  }

  .two-line-link-button span {
    margin: 10px;
    width: auto;
  }

  .callsign{
    font-weight: bold;
    font-size: 1.2em;
  }
</style>
