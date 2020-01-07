<template>
  <div>
    <div class="clearfix container">
      <div class="inline-table float-left half-width">
        <label>Forum name</label>
        <input v-model="username">
      </div>
      <div class="inline-table float-right half-width">
        <span>The name of the member in the ACG forums. This name is needed to link the forum to the
        PAM account as well as for authentication.</span>
      </div>
    </div>

    <div class="clearfix container">
      <div class="inline-table float-left half-width">
        <label>Callsign</label>
        <input v-model="callsign">
      </div>
      <div class="inline-table float-right half-width">
        <span>The callsign of the member.</span>
      </div>
    </div>

    <div class="clearfix container">
      <div class="inline-table float-left half-width">
        <label>Admin</label>
        <input type="checkbox" id="checkbox" v-model="admin" true-value="1" false-value="0">
      </div>
      <div class="inline-table float-right half-width">
            <span>Admin rights enable the member to create and alter members, campaigns, historical units and assets.
            Additionally, they can accept or reject reports and claims. Admin rights should be granted to commanding
            officers, adjutants and ACG staff working with aspects controlled by the Pilot and Mission database.</span>
      </div>
    </div>

    <div v-if="member_id >= 0" class="container">
      <div>
        <p class="heading">Membership status:</p>
        <!--<p>Update the status of the member. The current date will be set as the update date if the date-fields are left-->
        <!--empty.</p>-->
        <p><b>Note:</b> Please add the estimated date of return in the comments when setting
          members to "Relieved from Duty".</p>

        <label><b>Update status to:</b></label>
        <select v-model="status">
          <option v-for="(status, index) in memberStatus" v-bind:value="index">
            {{ status }}
          </option>
        </select>

        <b>Date:</b>
        <date-picker
          v-model="status_date"
          lang="en"
          type="date"
          format="YYYY-MM-DD"
          value-type="format"
          v-bind:clearable="false">
        </date-picker>

        <div>
          <b>Status update comment:</b><br>
          <textarea
            v-model="status_comment"
            class="textarea-style"

          ></textarea>
        </div>

        <div>
          <button v-on:click="updateStatus">Update status</button>
        </div>

      </div>

      <div>
        <!--<p class="heading">Membership status</p>-->
        <p class="heading">Status updates:</p>
        <table>
          <tr>
            <th>ID:</th>
            <th>Status:</th>
            <th>Date in:</th>
            <th>Date out:</th>
            <th>Comment:</th>
          </tr>
          <tr v-for="status in status_log">
            <th>{{ status.id }}</th>
            <th>{{ memberStatus[status.member_status] }}</th>
            <th>{{ status.status_date_in }}</th>
            <th>{{ status.status_date_out }}</th>
            <th>{{ decodeHTML(status.comment) }}</th>
            <th>
              <button v-on:click="deleteStatus(status.id)">Delete</button>
            </th>
          </tr>
        </table>
      </div>
    </div>

    <div  v-if="member_id >= 0" class="container">
      <div>
        <p class="heading">Transfer member:</p>
        <!--<p>Transfer member to another unit. The current date will be set&ndash;&gt;-->
        <!--as the transfer date if the date-fields are left empty. For historical reasons-->
        <!--it is advised to dismiss any active character first before transferring a-->
        <!--member to a different faction. A new character should be created afterwards.-->
        <!--This will ensure that the new character bears the name fitting the new-->
        <!--units faction.</p>-->

        <label><b>Transfer to unit:</b></label>
        <select v-model="transfer_unit">
          <option v-for="(unit, index) in acg_units" v-bind:value="unit.id">
            {{ unit.name }}
          </option>
        </select>

        <b>Date:</b>
        <date-picker
          v-model="transfer_date"
          lang="en"
          type="date"
          format="YYYY-MM-DD"
          value-type="format"
          v-bind:clearable="false">
        </date-picker>

        <div>
          <button v-on:click="updateTransfer">Transfer member</button>
        </div>

      </div>

      <div>
        <p class="heading">Transfers:</p>
        <table>
          <tr>
            <th>ID:</th>
            <th>ACG-Unit:</th>
            <th>Date in:</th>
            <th>Date out:</th>
          </tr>
          <tr v-for="transfer in transfer_log">
            <th>{{ transfer.id }}</th>
            <th>{{ unitById(transfer.acg_unit_id).name }}</th>
            <th>{{ transfer.transfer_date_in }}</th>
            <th>{{ transfer.transfer_date_out }}</th>
            <th>
              <button v-on:click="deleteTransfer(transfer.id)">Delete</button>
            </th>
          </tr>
        </table>
      </div>
    </div>

    <div  v-if="member_id >= 0" class="container">
      <div class="clearfix">
        <p class="heading">Promote/Demote member:</p>

        <div>
          <p>Promote or demote a member by selecting the desired rank value. Each rank value corresponds to a specific
            rank depending on the faction. Select the faction of interest below to display how the ranks relate to the rank
            values. Not every rank value might be assigned a rank in each faction. The next higher rank will be shown for
            the member in cases where there is no corresponding rank value.</p>
          <template v-for="(faction, index) in factionStatus">
            <input v-if="index !== 0" type="radio" v-bind:value="index" v-model="rank_faction">
            <label>{{faction.long}}</label>
          </template>
        </div>

        <div class="inline-table float-left half-width">

          <div>
            <label><b>Promote/demote to rank value:</b></label>
            <select v-model="promotion_value">
              <option v-for="(value) in rankValues" v-bind:value="value">
                {{ value }} - {{ rankByValueFaction(value, rank_faction).rank_name }}
              </option>
            </select>
          </div>

          <div>
            <label>Date:</label>
            <date-picker
              v-model="promotion_date"
              lang="en"
              type="date"
              format="YYYY-MM-DD"
              value-type="format"
              v-bind:clearable="false">
            </date-picker>
          </div>

          <div>
            <label><b>Promotion/demotion comment:</b></label>
            <textarea
              v-model="promotion_comment"
              class="textarea-style"
            ></textarea>
          </div>

          <div>
            <button v-on:click="updatePromotion">Promote/Demote member</button>
          </div>

        </div>
        <div class="inline-table float-right half-width">
          <p class="heading">Ranks overview:</p>
          <table>
            <tr>
              <th>Rank value:</th>
              <th>Rank title:</th>
              <th>Abbreviation:</th>
            </tr>
            <tr v-for="value in rankValues">
              <th>{{value }}</th>
              <th>{{ rankByValueFaction(value, rank_faction).rank_name }}</th>
              <th>{{ rankByValueFaction(value, rank_faction).abreviation }}</th>
            </tr>
          </table>
        </div>
      </div>

      <div>
        <!--<p class="heading">Membership status</p>-->
        <p class="heading">Promotions/Demotions:</p>
        <table>
          <tr>
            <th>ID:</th>
            <th>Rank value:</th>
            <th>Rank title:</th>
            <th>Date:</th>
            <th>Comment:</th>
          </tr>
          <tr v-for="promotion in promotion_log">
            <th>{{ promotion.id }}</th>
            <th>{{ promotion.rank_value }}</th>
            <th>{{ rankByValueFaction(promotion.rank_value, rank_faction).rank_name }}</th>
            <th>{{ promotion.promotion_date }}</th>
            <th>{{ decodeHTML(promotion.comment) }}</th>
            <th>
              <button v-on:click="deletePromotion(promotion.id)">Delete</button>
            </th>
          </tr>
        </table>
      </div>
    </div>

  </div>
</template>

<script>
  import { mapState, mapGetters } from "vuex"
  import DatePicker from 'vue2-datepicker'
  import statConv from "../../resource/statusConverter"
  import stringConv from "../../resource/stringConverter"

  export default {
    name: "MemberGeneralComp",
    mixins: [
      stringConv,
      statConv
    ],
    props: {
      member_id: {
        type: Number,
        default: 0
      }
    },
    components: {
      DatePicker,
    },

    data () {

      return {

        // member_id: 0,

        status: 0,
        status_date: "",
        status_comment: "",

        transfer_unit: null,
        transfer_date: "",

        promotion_value: 1,
        promotion_date: "",
        promotion_comment: "",

        rank_faction: 1,
      }
    },
    computed: {

      username: {
        get () {
          var member = this.$store.getters['memberAdmin/memberById']( this.member_id);
          return (member !== undefined) ? member.username : "";
        },
        set (value) {
          this.$store.commit('memberAdmin/updateValue',
            {
              array_name: "members",
              id_column_name: "member_id",
              id_column_value: this.member_id,
              update_column_name: "username",
              update_column_value: value
            });
        }
      },

      callsign: {
        get () {
          var member = this.$store.getters['memberAdmin/memberById']( this.member_id);
          return (member !== undefined) ? member.callsign : "";
        },
        set (value) {
          this.$store.commit('memberAdmin/updateValue',
            {
              array_name: "members",
              id_column_name: "member_id",
              id_column_value: this.member_id,
              update_column_name: "callsign",
              update_column_value: value
            });
        }
      },

      admin: {
        get () {
          var member = this.$store.getters['memberAdmin/memberById']( this.member_id);
          return (member !== undefined) ? member.admin : "";
        },
        set (value) {
          this.$store.commit('memberAdmin/updateValue',
            {
              array_name: "members",
              id_column_name: "member_id",
              id_column_value: this.member_id,
              update_column_name: "admin",
              update_column_value: value
            });
        }
      },

      ...mapState('memberAdmin', {

        status_log: state => state.member_status_log,
        transfer_log: state => state.transfer_log,
        acg_units: state => state.acg_units,
        promotion_log: state => state.promotion_log
      }),

      ...mapGetters("memberAdmin", [
        "unitById",
        "memberById",
        "rankByValueFaction",
        "rankValues"
      ])
    },

    methods: {


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

      updateStatus: function () {

        this.$store.dispatch('memberAdmin/updateStatus',
          {
            caller: this.$options.name,
            member_id: this.member_id,
            status: this.status,
            status_date: this.status_date,
            status_comment: this.status_comment
          }
        ).then(response => {

            this.$store.commit('logger/addEntry', {message: response.message});
            return this.$store.dispatch('memberAdmin/loadMember',
              {
                caller: this.$options.name,
                member_id: this.member_id
              });
          }
        ).then(response => {

            return this.$store.dispatch('memberAdmin/loadStatusLog',
              {
                caller: this.$options.name,
                member_id: this.member_id
              });
          }
        ).catch(error => {
          console.log(error.message);

        });
      },

      deleteStatus: function (id) {

        this.$store.dispatch('memberAdmin/deleteStatus',
          {
            caller: this.$options.name,
            status_id: id,
          }
        ).then(response => {

            this.$store.commit('logger/addEntry', {message: response.message});
            return this.$store.dispatch('memberAdmin/loadMember',
              {
                caller: this.$options.name,
                member_id: this.member_id
              });
          }
        ).then(response => {

            return this.$store.dispatch('memberAdmin/loadStatusLog',
              {
                caller: this.$options.name,
                member_id: this.member_id
              });
          }
        ).catch(error => {
          console.log(error.message);

        });
      },

      updateTransfer: function () {

        this.$store.dispatch('memberAdmin/updateTransfer',
          {
            caller: this.$options.name,
            member_id: this.member_id,
            transfer_unit: this.transfer_unit,
            transfer_date: this.transfer_date,
          }
        ).then(response => {

            this.$store.commit('logger/addEntry', {message: response.message});
            return this.$store.dispatch('memberAdmin/loadMember',
              {
                caller: this.$options.name,
                member_id: this.member_id
              });
          }
        ).then(response => {

            return this.$store.dispatch('memberAdmin/loadTransferLog',
              {
                caller: this.$options.name,
                member_id: this.member_id
              });
          }
        ).catch(error => {
          console.log(error.message);

        });
      },

      deleteTransfer: function (id) {

        this.$store.dispatch('memberAdmin/deleteTransfer',
          {
            caller: this.$options.name,
            transfer_id: id,
          }
        ).then(response => {

            this.$store.commit('logger/addEntry', {message: response.message});
            return this.$store.dispatch('memberAdmin/loadMember',
              {
                caller: this.$options.name,
                member_id: this.member_id
              });
          }
        ).then(response => {

            return this.$store.dispatch('memberAdmin/loadTransferLog',
              {
                caller: this.$options.name,
                member_id: this.member_id
              });
          }
        ).catch(error => {
          console.log(error.message);

        });
      },

      updatePromotion: function () {

        this.$store.dispatch('memberAdmin/updatePromotion',
          {
            caller: this.$options.name,
            member_id: this.member_id,
            promotion_value: this.promotion_value,
            promotion_date: this.promotion_date,
            promotion_comment: this.promotion_comment
          }
        ).then(response => {

            this.$store.commit('logger/addEntry', {message: response.message});
            return this.$store.dispatch('memberAdmin/loadPromotionLog',
              {
                caller: this.$options.name,
                member_id: this.member_id
              });
          }
        ).catch(error => {
          console.log(error.message);

        });
      },

      deletePromotion: function (id) {

        this.$store.dispatch('memberAdmin/deletePromotion',
          {
            caller: this.$options.name,
            promotion_id: id,
            member_id: this.member_id
          }
        ).then(response => {

            return this.$store.dispatch('memberAdmin/loadPromotionLog',
              {
                caller: this.$options.name,
                member_id: this.member_id
              });
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

