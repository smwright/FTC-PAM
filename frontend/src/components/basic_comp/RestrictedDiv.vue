<template>
  <div>
    <template v-if="this.$session.get('admin') == 1">
      <slot name="restricted"></slot>
    </template>
    <template v-else>
      <slot name="public"></slot>
    </template>
  </div>
</template>

<script>
export default {
  name: "RestrictedDiv",
  mounted() {
    if(!this.$session.exists()){
      this.$session.start();
    }
    if(!this.$session.has("admin")){
      this.syncSession();
    }
  },
  data () {
    return {
      hasAccess: false
    }
  }

}
</script>

<style scoped>

</style>
