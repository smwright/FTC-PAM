<template >
<div>
  <DivLinkButton class="heading" v-bind="{routeName: 'RecommendedReports'}">
    Recommended reports
  </DivLinkButton>
</div>
</template>

<script>

import DivLinkButton from "./basic_comp/DivLinkButton"

export default {
  name: 'MainSideNav',
  components: {
    DivLinkButton
  },
  data () {
    return {

    }
  },
}


</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style>

</style>
