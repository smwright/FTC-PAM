<template>
  <div>
    <div class="container">
      <button v-on:click="changeTab('general')">General</button>
      <button v-on:click="changeTab('characters')">Characters</button>
      <button v-on:click="sendData">Save member</button>
      <!--<button v-on:click="fetchData">Fetch member</button>-->
    </div>
    <div>
      <MemberGeneralComp
        v-show="tabToShow === 'general'"
        v-bind:member_id="member_id"
      ></MemberGeneralComp>
      <MemberCharacterComp

      >
      </MemberCharacterComp>
    </div>
  </div>

</template>

<script>
  import MemberGeneralComp from "./MemberGeneralComp"
  import MemberCharacterComp from "./MemberCharacterComp"

export default {
  name: "Member",
  components: {
    MemberCharacterComp,
    MemberGeneralComp,
  },
  mounted () {

    this.updateMemberID(this.$route.params.member_id);
  },
  data () {
    return {

      member_id: 0,
      tabToShow: "general"
    }
  },
  computed: {

  },

  beforeRouteUpdate (to, from, next) {
    // called when the route that renders this component has changed,
    // but this component is reused in the new route.
    // For example, for a route with dynamic params `/foo/:id`, when we
    // navigate between `/foo/1` and `/foo/2`, the same `Foo` component instance
    // will be reused, and this hook will be called when that happens.
    // has access to `this` component instance.
    this.updateMemberID(to.params.member_id);
    next();
  },

  methods: {

    changeTab: function (tab) {

      console.log("Change tab to: "+tab);
      this.tabToShow = tab;
    },

    updateMemberID: function (id) {
      // Set current date for status and rank datepicker
      var now = new Date();
      var year = now.getFullYear();
      var month = now.getMonth() + 1;
      var day = now.getDate();
      this.status_date = year+"-"+month+"-"+day;
      this.transfer_date = year+"-"+month+"-"+day;
      this.promotion_date = year+"-"+month+"-"+day;

      // Updating member id and loading status log
      this.member_id = Number(id);
      if(this.member_id >= 0){

        this.$store.dispatch('memberAdmin/loadStatusLog',
          {
            caller: this.$options.name,
            member_id: this.member_id
          }
        ).catch(error => {
          console.log(error.message);
        });
        this.$store.dispatch('memberAdmin/loadTransferLog',
          {
            caller: this.$options.name,
            member_id: this.member_id
          }
        ).catch(error => {
          console.log(error.message);
        });
        this.$store.dispatch('memberAdmin/loadRankLookup',
          {
            caller: this.$options.name,
          }
        ).then(response => {

            return this.$store.dispatch('memberAdmin/loadPromotionLog',
              {
                caller: this.$options.name,
                member_id: this.member_id
              }
            );
          }
        ).catch(error => {
          console.log(error.message);
        });
        this.$store.dispatch('characterStore/loadCharacters',
          {
            caller: this.$options.name,
            member_id: this.member_id
          }
        ).then(response => {

            return this.$store.dispatch('characterStore/loadDecorations',
              {
                caller: this.$options.name,
                member_id: this.member_id
              }
            );
          }
        ).catch(error => {
          console.log(error.message);
        });
      }
    },

    sendData: function () {

      this.$store.dispatch('memberAdmin/sendMemberInfo',
        {
          caller: this.$options.name,
          member_id: this.member_id
        }
      ).then(response => {

          this.$store.commit('logger/addEntry', {message: response.message});
          if(this.member_id < 0){

            var new_id = response.insert_id[0].new_id;
            console.log(this.$parent.$options.name+": Pushing to -> {name: AdminCampaign, params: campaign_id: "+this.campaign_id+"}");
            this.$router.push({name: "AdminMember", params: {member_id: new_id}});
            return this.$store.dispatch('memberAdmin/loadMember',
              {
                caller: this.$options.name,
                member_id: new_id
              });
          }
        }
      ).catch(error => {
        console.log(error.message);
      });
    },
  }
}
</script>

<style scoped>

</style>
