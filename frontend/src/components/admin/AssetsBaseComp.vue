<template>

    <div class="inline-block">

      <SwitchableDiv>
        <template slot="buttonStateA">
          <div>
            {{ c_name }}
          </div>
        </template>
        <template slot="contentStateA">
          <div>
            {{ this.factionStatus[faction].long }}
          </div>
          <div>
            <span v-if="controlable">Controllable</span>
          </div>
        </template>

        <template slot="buttonStateB">
          {{ c_name }}
        </template>
        <template slot="contentStateB">
          <div>
            <input v-model="c_name">
          </div>
          <div>
            <select v-model="faction">
              <option v-for="(faction, index) in this.factionStatus" v-bind:value="index">
                {{ faction.long }}
              </option>
            </select>
          </div>
          <div>
            <span>Controllable</span>
            <input type="checkbox" id="checkbox" v-model="controlable">
          </div>
          <div class="float-right">
            <button v-on:click="deleteAsset()">Delete</button>
          </div>
        </template>
      </SwitchableDiv>

    </div>
</template>

<script>
import statConv from "../../resource/statusConverter"
import SwitchableDiv from "../basic_comp/SwitchableDiv"

export default {
  name: "AssetsBaseComp",
  mixins: [statConv],
  components: {SwitchableDiv},
  props: {
    id: {
      type: Number,
      default: 0
    },
    name: {
      type: String,
      default: ""
    },
    faction: {
      type: Number,
      default: 0
    },
    controlable: {
      type: Number,
      default: 0
    }

  },
  // data () {
  //
  // },
  computed: {

    c_name: {
      get () {
        return this.name;
      },
      set (value) {
        this.$store.commit("assetAdmin/setName", {id:this.id, value:value});
      }

    }

  },
  methods: {

  }
}
</script>

<style scoped>

</style>
