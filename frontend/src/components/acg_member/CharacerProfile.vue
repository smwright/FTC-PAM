<template>
  <div class="typed-on-paper">

    UNDER CONSTRUCTION

    <!--<div class="padding-10">-->
      <!--<table>-->
        <!--<tr><td>Name:</td><td>{{ memberById(member_id).callsign }}</td></tr>-->
        <!--<tr><td>Status:</td><td>{{ memberStatus[memberById(member_id).member_status] }}</td></tr>-->
        <!--<tr><td>Length of service:</td><td>{{ lengthOfService }}</td></tr>-->
        <!--<tr><td>Current unit:</td><td>{{ currentACGUnitById(member_id).name }}</td></tr>-->
      <!--</table>-->
    <!--</div>-->

    <!--<div class="clearfix">-->
      <!--&lt;!&ndash;<div class="inline-table float-left half-width">&ndash;&gt;-->
      <!--<SortiePilotAssetStats></SortiePilotAssetStats>-->
      <!--<ClaimStats></ClaimStats>-->
      <!--&lt;!&ndash;</div>&ndash;&gt;-->

      <!--&lt;!&ndash;<div class="inline-table float-left half-width">&ndash;&gt;-->
      <!--&lt;!&ndash;<MemberCampaignAttendance></MemberCampaignAttendance>&ndash;&gt;-->
      <!--&lt;!&ndash;</div>&ndash;&gt;-->
    <!--</div>-->

    <!--<div class="padding-10">-->
      <!--<h1>Status updates:</h1>-->
      <!--<table>-->
        <!--<tr>-->
          <!--<th>Status:</th>-->
          <!--<th>Date:</th>-->
        <!--</tr>-->
        <!--<tr v-for="status in status_log">-->
          <!--<td>{{ memberStatus[status.member_status] }}</td>-->
          <!--<td>{{ status.status_date_in }}</td>-->
        <!--</tr>-->
      <!--</table>-->
    <!--</div>-->

    <!--<div class="padding-10">-->
      <!--<h1>Transfer overview:</h1>-->
      <!--<table>-->
        <!--<tr>-->
          <!--<th>Date:</th>-->
          <!--<th>To unit:</th>-->
        <!--</tr>-->
        <!--<tr v-for="transfer in transfer_log">-->
          <!--<td>{{ transfer.transfer_date_in }}</td>-->
          <!--<td>{{ unitById(transfer.acg_unit_id).name }}</td>-->
        <!--</tr>-->
      <!--</table>-->
    <!--</div>-->

    <!--<div class="padding-10">-->
      <!--<h1>Promotion/Demotion overview:</h1>-->
      <!--<table>-->
        <!--<tr>-->
          <!--<th>Date:</th>-->
          <!--<th>To rank:</th>-->
          <!--<th>Comment:</th>-->
        <!--</tr>-->
        <!--<tr v-for="promotion in promotion_log">-->
          <!--<td>{{ promotion.promotion_date }}</td>-->
          <!--<td>{{ promotion.rank_name }} ( {{ promotion.rank_value }} )</td>-->
          <!--<td>{{ decodeHTML(promotion.comment) }}</td>-->
        <!--</tr>-->
      <!--</table>-->
    <!--</div>-->

  </div>
</template>

<script>

export default {
  name: "CharacerProfile",
  mounted () {

    this.updateCharacterID(this.$route.params.character_id, this.$route.params.member_id);
  },
  data () {
    return {

      member_id: 0,
      character_id: 0,
    }
  },
  beforeRouteUpdate (to, from, next) {
    // called when the route that renders this component has changed,
    // but this component is reused in the new route.
    // For example, for a route with dynamic params `/foo/:id`, when we
    // navigate between `/foo/1` and `/foo/2`, the same `Foo` component instance
    // will be reused, and this hook will be called when that happens.
    // has access to `this` component instance.
    this.updateCharacterID(this.$route.params.character_id, this.$route.params.member_id);
    next();
  },
  methods: {

    updateCharacterID: function (c_id, m_id) {

      // Updating member id and loading status log
      this.character_id = Number(c_id);
      this.member_id = Number(m_id);
      if(this.member_id >= 0) {

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
      }

      if(this.character_id >= 0){
        this.$store.dispatch('memberInfo/loadStoreData',
          {
            caller: this.$options.name,
            call_object: {
              view: "character_latest_report",
              character_id: this.character_id,
            },
            data_array_name: "member_characters"
          }
        ).then(response => {

          console.log("RESPONSE"+JSON.stringify(response))
        })
        .catch(error => {
          console.log(error.message);
        });
        this.$store.dispatch('memberInfo/loadStoreData',
          {
            caller: this.$options.name,
            call_object: {
              view: "character_campaign_sorties_pilot_asset_status",
              member_id: this.member_id
            },
            data_array_name: "character_sorties_stats"
          }
        ).catch(error => {
          console.log(error.message);
        });


        // this.$store.dispatch('memberInfo/loadStoreData',
        //   {
        //     caller: this.$options.name,
        //     call_object: {
        //       view: "character_campaign_claim_raf",
        //       member_id: this.member_id
        //     },
        //     data_array_name: "character_claim_raf"
        //   }
        // ).catch(error => {
        //   console.log(error.message);
        // });
        // this.$store.dispatch('memberInfo/loadStoreData',
        //   {
        //     caller: this.$options.name,
        //     call_object: {
        //       view: "character_campaign_claim_lw",
        //       member_id: this.member_id
        //     },
        //     data_array_name: "character_claim_lw"
        //   }
        // ).catch(error => {
        //   console.log(error.message);
        // });
        // this.$store.dispatch('memberInfo/loadStoreData',
        //   {
        //     caller: this.$options.name,
        //     call_object: {
        //       view: "character_campaign_claim_vvs_group",
        //       member_id: this.member_id
        //     },
        //     data_array_name: "character_claim_vvs_group"
        //   }
        // ).catch(error => {
        //   console.log(error.message);
        // });
        // this.$store.dispatch('memberInfo/loadStoreData',
        //   {
        //     caller: this.$options.name,
        //     call_object: {
        //       view: "character_campaign_claim_vvs_pers",
        //       member_id: this.member_id
        //     },
        //     data_array_name: "character_claim_vvs_pers"
        //   }
        // ).catch(error => {
        //   console.log(error.message);
        // });
        // this.$store.dispatch('memberInfo/loadStoreData',
        //   {
        //     caller: this.$options.name,
        //     call_object: {
        //       view: "character_campaign_claim_ground",
        //       member_id: this.member_id
        //     },
        //     data_array_name: "character_claim_ground"
        //   }
        // ).catch(error => {
        //   console.log(error.message);
        // });
        // this.$store.dispatch('memberInfo/loadStoreData',
        //   {
        //     caller: this.$options.name,
        //     call_object: {
        //       view: "decoration_info",
        //       member_id: this.member_id
        //     },
        //     data_array_name: "character_decorations"
        //   }
        // ).catch(error => {
        //   console.log(error.message);
        // });
      }
    }
  }
}
</script>

<style scoped>

</style>
