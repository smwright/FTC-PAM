<template>
  <div class="div-button" v-on:click="routeTo()">
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
      default: null
    }
  },
  methods: {
    routeTo: function () {
      this.$router.push({name: this.routeName, params: this.routeParams});
      //DEBUG
      console.log(this.$parent.$options.name+": Pushing to -> {name: "+this.routeName+", params: "+JSON.stringify(this.routeParams)+"}");
    }
  }
}
</script>

<style scoped>

.div-button{
  margin: 10px 2px 10px 2px;
  cursor: pointer;
}

.div-button:hover {
  background: gray;
}

</style>
