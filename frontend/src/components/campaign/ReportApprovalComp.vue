<template>
  <div
    class="approval-area"
    v-on:mouseover="mouseover"
    v-on:mouseleave="mouseleave"
  >

    <template v-if="isAdmin">
      <div
        class="bigSignature"
        v-if="report_info.accepted && report_info.accepted_by !== null"
      >
        <img class="stamp" v-bind:src="this.stampImage"/>
        <button
          v-if="isMouseOver"
          class="approve-button"
          v-on:click="acceptRejectReport"
        >Revoke</button>
        <span v-else class="signature">{{ memberById(report_info.accepted_by).callsign }}</span>
      </div>
      <div v-else>
        <button class="approve-button" v-on:click="acceptRejectReport">Approve</button>
      </div>
    </template>

    <template v-else>
      <div
        class="bigSignature"
        v-if="report_info.accepted && report_info.accepted_by !== null"
      >
        <img class="stamp" v-bind:src="this.stampImage"/>
        <span class="signature">{{ memberById(report_info.accepted_by).callsign }}</span>
      </div>
    </template>

  </div>
</template>

<script>

  import { mapState, mapGetters } from "vuex"

  export default {
    name: "ReportApprovalComp",
    props: {
      stampImage: {
        type: String,
        default: null
      }
    },
    mounted ()  {

      this.checkAdmin();
    },
    data () {
      return {

        isAdmin: false,
        isMouseOver: false,
      }
    },
    computed: {

      acceptButtonText() {

        if(this.report_info.accepted){
          return "Revoke report acceptance";
        } else {
          return "Approve report";
        }
      },

      ...mapState("missionStore", {
        report_info: state => state.report,
      }),

      ...mapGetters("missionStore", [
        "memberById"
      ])
    },
    methods: {

      mouseover: function() {
        this.isMouseOver = true;
      },

      mouseleave: function() {
        this.isMouseOver = false;
      },

      checkAdmin: async function () {

        this.isAdmin = await this.$auth.isAdmin(this.$options.name);
      },

      acceptRejectReport: async function () {

        this.$store.dispatch('missionStore/acceptRejectReport',
          {
            caller: this.$options.name,
            member_id: await this.$auth.getUserId(),
          });
      }
    }

  }
</script>

<style scoped>

.approval-area{
  position: relative;
  width: 200px;
  height: 200px;
}

.signature {
  position: absolute;
  left: 10%;
  top: 40%;
  width: 100%;
  text-align: center;
}

.approve-button{
  position: absolute;
  left: 0%;
  top: 50%;
  width: 100%;
  text-align: center;
}

.stamp{
  max-width: 200px;
  max-height: 200px;
}
</style>
