<!--
  HideableDiv:

  Usage:
  <template>
    ...
    <HideableDiv
      v-bind:changing-button="true|false default:false"
      v-bind:startVisible="true|false default:false"
     >
      <template slot="buttonVisible">
        BUTTON ELEMENT WHEN VISIBLE
      </template>
      <template slot="buttonHidden">
        BUTTON ELEMENT WHEN HIDDEN
      </template>
      DIV INHOLD
    </HideableDiv>

  </template>
-->

<template>
  <div>
    <div v-if="this.changingButton" v-show="this.isVisible" v-on:click.stop="toggleVisible()">
      <slot name="buttonVisible"></slot>
    </div>
    <div v-show="!this.changingButton || !this.isVisible" v-on:click.stop="toggleVisible()">
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

</style>
