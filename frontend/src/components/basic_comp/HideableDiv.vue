<template>
  <div>
    <div class="inline-block full-width" v-if="this.changingButton" v-show="this.isVisible" v-on:click.stop="toggleVisible()">
      <slot name="buttonVisible"></slot>
    </div>
    <div class="inline-block full-width" v-show="!this.changingButton || !this.isVisible" v-on:click.stop="toggleVisible()">
      <slot name="buttonHidden"></slot>
    </div>
    <div class="inline-block full-width" v-show="this.isVisible">
      <slot></slot>
    </div>
  </div>
</template>

<script>
export default {
  name: "HideableDiv",
  props: {
    startVisible: {
      type: Boolean,
      default: false
    },
    changingButton: {
      type: Boolean,
      default: false
    }
  },
  data () {
    return {
      isVisible: this.startVisible
    }
  },
  methods: {

    toggleVisible: function () {
      this.isVisible = !this.isVisible;
    }
  }
}
</script>

<style scoped>
.inline-block {
  display: inline-block;
}

.div-button{
  margin: 10px 2px 10px 2px;
  cursor: pointer;
}

.div-button:hover {
  background: gray;
}

</style>
