<template>
  <div>
    <HideableDiv>
      <template
        v-if="membersByUnitId(id,showActive,showOnLeave,showDismissed,showPassedAway,searchString).length > 0"
        slot="buttonHidden">
        <div class="unit-buttons div-button clearfix">
          <span>
            {{ name }}
          </span>
          <DivLinkButton
            class="float-right admin-buttons"
            v-bind="{routeName: 'AdminUnit', routeParams: {unit_id: id}}"
          >
            Unit Administration

          </DivLinkButton>
        </div>
      </template>
        <!--<DivLinkButton-->
          <!--class="member-buttons"-->
          <!--v-bind="{routeName: 'AdminUnit', routeParams: {unit_id: id}}"-->
        <!--&gt;-->
          <!--Unit Administration-->

        <!--</DivLinkButton>-->
        <DivLinkButton
          class="member-buttons"
          v-for="member in membersByUnitId(id,showActive,showOnLeave,showDismissed,showPassedAway,searchString)"
          v-bind:class="{active: (member.member_status === 0), passedAway: (member.member_status === 3),
          dismissed: (member.member_status === 1), onleave: (member.member_status === 2)}"

          v-bind:key="member.id"
          v-bind="{routeName: 'AdminMember', routeParams: {member_id: member.member_id}}"
        >
          {{ member.callsign }}
        </DivLinkButton>
      <div>
      </div>
    </HideableDiv>
  </div>
</template>

<script>
import { mapState, mapGetters } from "vuex"
import HideableDiv from "../basic_comp/HideableDiv"
import DivLinkButton from "../basic_comp/DivLinkButton"

export default {
  name: "MemberAdminSideNavComp",
  components: {
    HideableDiv,
    DivLinkButton
  },
  props: {

    id: {
      type: Number,
      default: true
    },
    name: {
      type: [String, Number],
      default: true
    },
    showActive: {
      type: Boolean,
      default: true
    },
    showOnLeave: {
      type: Boolean,
      default: true
    },
    showDismissed: {
      type: Boolean,
      default: null
    },
    showPassedAway: {
      type: Boolean,
      default: null
    },
    searchString: {
      type: String,
      default: ""
    }

  },
  mounted () {

  },
  computed: {

    // ...mapState('memberAdmin', {
    //
    // }),

    ...mapGetters("memberAdmin", [
      "membersByUnitId",
    ])

  },
}
</script>

<style scoped>

.unit-buttons{
  color: #F28900;
  font-size: 1em;
  margin: 2px 0px 0px 15px;
  width: calc(100% - 15px - 26px);
}

.member-buttons{
  font-size: 1em;
  margin: 2px 0px 0px 20px;
  padding-top: 5px;
  padding-bottom: 5px;
  width: calc(100% - 20px - 26px);
}

.admin-buttons{
  width: 50%;
  min-width: 110px;
  margin: 0px;
  padding: 5px;
  color: white;
  text-align: center;
}

.active{
  background-color: rgba(0, 255, 0, 0.25);
}

.onleave{
  background-color: rgba(255, 255, 0, 0.25);
}

.dismissed{
  background-color: rgba(255, 0, 0, 0.25);
}

.passedAway{
  background-color: rgba(0, 0, 255, 0.25);
}


</style>
