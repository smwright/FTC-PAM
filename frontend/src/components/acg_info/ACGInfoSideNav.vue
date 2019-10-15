<template>
  <div>
    <!--       -->
    <!--MEMBERS-->
    <!--       -->
    <HideableDiv>
      <template slot="buttonHidden">
        <div class="div-button heading">Members</div>
    </template>
      <MemberInfoSideNav></MemberInfoSideNav>
    </HideableDiv>
  </div>

</template>

<script>
import HideableDiv from "../basic_comp/HideableDiv"
import MemberInfoSideNav from "./MemberInfoSideNav"
export default {
  name: "ACGInfoSideNav",
  components: {
    HideableDiv,
    MemberInfoSideNav
  }

}
</script>

<style scoped>

</style>
