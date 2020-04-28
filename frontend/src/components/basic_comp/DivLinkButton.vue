<template>
  <div v-if="active" class="div-button" v-on:click.stop="routeTo()">
    <slot></slot>
  </div>
  <div v-else class="div-button-inactive">
    <slot></slot>
  </div>
</template>

<script>
export default {
  name: "DivLinkButton",
  props: {
    routeName: {
      type: String,
      default: "/"
    },
    routeParams: {
      type: Object,
      default: function () {
        // An empty object has to be set as the params if no params are provided.
        // Null will cause $route.push to crash during params matching.
        return {};
      }
    },
    active: {
      type: Boolean,
      default: true
    }
  },
  methods: {
    routeTo: function () {

      console.log(this.$parent.$options.name+": Pushing to -> {name: "+this.routeName+", params: "+JSON.stringify(this.routeParams)+"}");
      this.$router.push({name: this.routeName, params: this.routeParams});
      //DEBUG
    }
  }
}
</script>

<style scoped>

</style>
