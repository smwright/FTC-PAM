<template>
  <div>
    <div class="container">
      <LinkButton
        v-bind="{routeName: 'MemberGeneral', routeParams: {member_id: this.member_id}}">
        General Info
      </LinkButton>
      <LinkButton
        v-bind="{routeName: 'MemberCharacters', routeParams: {member_id: this.member_id}}">
        Characters
      </LinkButton>

    </div>

    <router-view name="subcontent"></router-view>

  </div>
</template>

<script>
import LinkButton from "../basic_comp/LinkButton"

export default {
  name: "MemberProfile",
  components: {
    LinkButton
  },
  mounted () {

    this.updateMemberID(this.$route.params.member_id);
  },
  data () {
    return {

      member_id: 0,
      // tabToShow: "general"
    }
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

      // Updating member id and loading status log
      this.member_id = Number(id);
      if(this.member_id >= 0){

        this.$store.dispatch('memberInfo/loadStoreData',
          {
            caller: this.$options.name,
            call_object: {
              view: "member_status_log_info",
              member_id: this.member_id,
              order: "ORDER by status_date_in DESC"
            },
            data_array_name: "member_status_log"
          }
        ).catch(error => {
          console.log(error.message);
        });
        this.$store.dispatch('memberInfo/loadStoreData',
          {
            caller: this.$options.name,
            call_object: {
              view: "transfer_info",
              member_id: this.member_id,
              order: "ORDER by transfer_date_in DESC"
            },
            data_array_name: "transfer_log"
          }
        ).catch(error => {
          console.log(error.message);
        });
        this.$store.dispatch('memberInfo/loadStoreData',
          {
            caller: this.$options.name,
            call_object: {
              view: "member_promotion_info",
              member_id: this.member_id,
              order: "ORDER BY promotion_date DESC"
            },
            data_array_name: "promotion_log"
          }
        ).catch(error => {
          console.log(error.message);
        });
        this.$store.dispatch('memberInfo/loadStoreData',
          {
            caller: this.$options.name,
            call_object: {
              view: "member_campaign_attendance",
              member_id: this.member_id,
              order: "ORDER by campaign_id",
            },
            data_array_name: "member_campaign_attendance"
          }
        ).catch(error => {
          console.log(error.message);
        });
        this.$store.dispatch('memberInfo/loadStoreData',
          {
            caller: this.$options.name,
            call_object: {
              view: "report_info",
              member_id: this.member_id
            },
            data_array_name: "reports"
          }
        ).catch(error => {
          console.log(error.message);
        });
        this.$store.dispatch('memberInfo/loadStoreData',
          {
            caller: this.$options.name,
            call_object: {
              view: "report_response_info",
              author_id: this.member_id
            },
            data_array_name: "report_response"
          }
        ).catch(error => {
          console.log(error.message);
        });
        this.$store.dispatch('memberInfo/loadStoreData',
          {
            caller: this.$options.name,
            call_object: {
              view: "character_claim_raf",
              member_id: this.member_id
            },
            data_array_name: "character_claim_raf"
          }
        ).catch(error => {
          console.log(error.message);
        });
        this.$store.dispatch('memberInfo/loadStoreData',
          {
            caller: this.$options.name,
            call_object: {
              view: "character_claim_lw",
              member_id: this.member_id
            },
            data_array_name: "character_claim_lw"
          }
        ).catch(error => {
          console.log(error.message);
        });
        this.$store.dispatch('memberInfo/loadStoreData',
          {
            caller: this.$options.name,
            call_object: {
              view: "character_claim_vvs_group",
              member_id: this.member_id
            },
            data_array_name: "character_claim_vvs_group"
          }
        ).catch(error => {
          console.log(error.message);
        });
        this.$store.dispatch('memberInfo/loadStoreData',
          {
            caller: this.$options.name,
            call_object: {
              view: "character_claim_vvs_pers",
              member_id: this.member_id
            },
            data_array_name: "character_claim_vvs_pers"
          }
        ).catch(error => {
          console.log(error.message);
        });
        this.$store.dispatch('memberInfo/loadStoreData',
          {
            caller: this.$options.name,
            call_object: {
              view: "character_claim_ra",
              member_id: this.member_id
            },
            data_array_name: "character_claim_ra"
          }
        ).catch(error => {
          console.log(error.message);
        });
        this.$store.dispatch('memberInfo/loadStoreData',
          {
            caller: this.$options.name,
            call_object: {
              view: "character_claim_ground",
              member_id: this.member_id
            },
            data_array_name: "character_claim_ground"
          }
        ).catch(error => {
          console.log(error.message);
        });
        this.$store.dispatch('memberInfo/loadStoreData',
          {
            caller: this.$options.name,
            call_object: {
              view: "character_latest_report",
              member_id: this.member_id,
              order: "ORDER BY character_id"
            },
            data_array_name: "member_characters"
          }
        ).catch(error => {
          console.log(error.message);
        });
        this.$store.dispatch('memberInfo/loadStoreData',
          {
            caller: this.$options.name,
            call_object: {
              view: "decoration_info",
              member_id: this.member_id
            },
            data_array_name: "character_decorations"
          }
        ).catch(error => {
          console.log(error.message);
        });

      }
    }
  }
}
</script>

<style scoped>

</style>
