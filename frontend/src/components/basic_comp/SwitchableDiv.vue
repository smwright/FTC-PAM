<template>
  <div>
    <div class="inline-block full-width" v-if="!divstate" >
      <div v-on:click.stop="toggleState()">
        <slot name="buttonStateA"></slot>
      </div>
      <div>
        <slot name="contentStateA"></slot>
      </div>
    </div>
    <div class="inline-block full-width" v-if="divstate" >
      <div v-on:click.stop="toggleState()">
        <slot name="buttonStateB"></slot>
      </div>
      <div>
        <slot name="contentStateB"></slot>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    name: "SwitchableDiv",
    props: {
      startstate: {
        type: [Number, Boolean],
        default: 0
      }

    },
    data () {
      return {
        divstate: this.startstate
      }
    },
    methods: {

      toggleState: function () {
        this.divstate = !this.divstate;
      }
    }
  }
</script>

<style scoped>
  .inline-block {
    display: inline-block;
  }
</style>
