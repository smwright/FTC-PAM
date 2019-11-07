<template>
  <button v-on:click="routeTo">
    <slot></slot>
  </button>
</template>

<script>

export default {
  name: "LinkButton",
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
