<template>
  <div>
    <HideableDiv>
      <template
        v-if="membersByUnitId(id,showActive,showOnLeave,showDismissed,showActive,searchString).length > 0"
        slot="buttonHidden">
        <div class="unit-buttons div-button">{{ name }}</div>
      </template>
      <DivLinkButton
        class="member-buttons"
        v-for="member in membersByUnitId(id,showActive,showOnLeave,showDismissed,showActive,searchString)"
        v-bind:class="{active: (member.member_status === 0 || member.member_status === 3),
          dismissed: (member.member_status === 1), onleave: (member.member_status === 2)}"

        v-bind:key="member.id"
        v-bind="{routeName: 'MemberGeneral', routeParams: {member_id: member.member_id}}"
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
  name: "MemberInfoSideNavComp",
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
    searchString: {
      type: String,
      default: ""
    }

  },
  computed: {

    ...mapGetters("memberInfo", [
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

.active{
  background-color: rgba(0, 255, 0, 0.25);
}

.onleave{
  background-color: rgba(255, 255, 0, 0.25);
}

.dismissed{
  background-color: rgba(255, 0, 0, 0.25);
}


</style>
