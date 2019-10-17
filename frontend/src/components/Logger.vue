<template>
  <div>
    <table  class="full-width small-font">
      <tr>
        <td class="width20">{{ getEntry(-1).datetime }}</td>
        <td class="width70 text-align-left">{{ getEntry(-1).message }}</td>
        <td class="width10"><button class="no-padding" v-on:click="showPrevious">▲</button></td>
      </tr>
      <tr>
        <td class="width20">{{ getEntry(0).datetime }}</td>
        <td class="width70 text-align-left">{{ getEntry(0).message }}</td>
        <td class="width10"><button  class="no-padding" v-on:click="showNext">▼</button></td>
      </tr>
    </table>
  </div>
</template>

<script>
  import {mapGetters, mapMutations} from "vuex"

  export default {
    name: "Logger",
    computed: {

      ...mapGetters("logger", [
        "getEntry"
      ]),

    },
    methods: {

      ...mapMutations("logger", [
        "showPrevious",
        "showNext"
      ])
    }
  }
</script>

<style scoped>

.small-font {
  font-size: 90%;
}

.no-padding {
  padding: 0px;
}

.width10 {
  width: 10%;
}

.width20 {
  width: 20%;
}

.width70 {
  width: 70%;
}

</style>
