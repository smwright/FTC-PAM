<template>
  <div>
    <h1>Campaign attendance:</h1>
    <!--{"member_id":79,"campaign_id":2,"campaign_name":"Peace in our Time",
    "acg_unit_id":6,"acg_unit_name":"5th","hist_unit_id":6,"hist_unit_name":"5./JG26"}-->
    <div>
      <ul>
        <li v-for="attendance in campaign_attendance">
          Took part in {{ attendance.campaign_name }}
          flying for {{ attendance.hist_unit_name }}
          ( {{ attendance.acg_unit_name }} )</li>
      </ul>
    </div>


  </div>

</template>

<script>
import { mapState } from "vuex"

export default {
  name: "MemberCampaignAttendance",
  computed: {

    ...mapState("memberInfo", {

      campaign_attendance: state => state.member_campaign_attendance,
    }),

  }
}
</script>

<style scoped>

</style>
