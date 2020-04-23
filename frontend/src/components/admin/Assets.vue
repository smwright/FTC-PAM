<template>
  <div class="clearfix">
    <div class="container">
      <button v-on:click="addAsset">Add asset</button>
      <button v-on:click="loadAsset">Fetch data</button>
      <button v-on:click="sendData">Save changes</button>
      <div>{{ dbStatus }}</div>
    </div>

    <AssetGeneralDescription class="container"></AssetGeneralDescription>

    <div class="float-left container split-div">

      <TreeWrapper ref="tree" v-bind:treedata="assets">
        <template slot-scope="tree">
          <div
            class="typed-on-paper tree-card"
            v-on:click="setActiveNode(tree.data)"
          >
            <div class="inline-block float-left">
              <button v-if="tree.data.children && tree.data.children.length"
                      v-on:click="tree.store.toggleOpen(tree.data)" >
                {{tree.data.open ? '-' : '+'}}
              </button>
            </div>
            <div class="inline-block">

              <SwitchableDiv>
                <template slot="buttonStateA">
                  <button>
                    {{ tree.data.name }}
                  </button>
                </template>
                <template slot="contentStateA">
                  <div>
                    {{ factionStatus[tree.data.faction].long }}
                  </div>
                  <div>
                    <span v-if="tree.data.controlable">Controllable</span>
                    <span v-if="tree.data.claimable">Claimable</span>
                  </div>
                </template>

                <template slot="buttonStateB">
                  <button>
                    {{ tree.data.name }}
                  </button>
                </template>
                <template slot="contentStateB">
                  <div>
                    <input v-model="tree.data.name">
                  </div>
                  <div>
                    <select v-model="tree.data.faction">
                      <option v-for="(faction, index) in factionStatus" v-bind:value="index">
                        {{ faction.long }}
                      </option>
                    </select>
                  </div>
                  <div>
                    <span>Controllable</span>
                    <input type="checkbox" id="checkbox-contr" v-model="tree.data.controlable" true-value=1 false-value=0>
                  </div>
                  <div>
                    <span>Claimable</span>
                    <input type="checkbox" id="checkbox-claim" v-model="tree.data.claimable" true-value=1 false-value=0>
                  </div>
                  <div class="float-right">
                    <button v-on:click="deleteAsset(tree.data)">Delete</button>
                  </div>
                </template>
              </SwitchableDiv>

            </div>
          </div>
        </template>
      </TreeWrapper>

    </div>

    <div class="float-left split-div">

        <AssetEditInstructions class="container"></AssetEditInstructions>

    </div>
  </div>
</template>

<script>
import TreeWrapper from "../basic_comp/TreeWrapper"
import statConv from "../../resource/statusConverter"
import SwitchableDiv from "../basic_comp/SwitchableDiv"
import AssetGeneralDescription from "./AssetGeneralDescriptionComp"
import AssetEditInstructions from "./AssetEditInstructions"

export default {
  name: "Assets",
  components: {
    TreeWrapper,
    SwitchableDiv,
    AssetGeneralDescription,
    AssetEditInstructions,
  },
  mixins: [statConv],
  mounted () {

    this.loadAsset();

  },
  data () {
    return {
      assets: null,
      assets_display: null,
      assets_for_delete: [],
      dbStatus: "",
      active_node: {
        id: null,
        x: ""
      },

    }
  },

  methods: {

    setActiveNode: function (node) {

      this.active_node.id = node.id;
      this.active_node.name = node.name;
    },

    addAsset: function () {
      var node =
        {
          id: -1,
          name: "New Asset",
          faction: 0,
          controlable: 0,
          claimable: 0
        };

      this.$refs.tree.addNode(node);

    },

    loadAsset: function () {

      this.$dbCon.requestViewData(this.$options.name, {view: "asset_info"})
        .then(response => {
          this.assets = this.$dbCon.nestData(response);
          this.assets_display = response;
        })
        .catch(error => {
          console.log(error.message);
        });


    },

    deleteAsset: function (node) {

      if(node.id > 0){
        this.assets_for_delete.push({id:node.id, name:node.name, faction:node.faction, controlable:node.controlable});
      }

      this.$refs.tree.deleteNode(node);

    },

    sendData: async function () {

      // this.assets.forEach(function (value) { console.log(value.name)})
      this.assets_display = this.$dbCon.flatData(this.$refs.tree.getRawData());
      var flatData = this.$dbCon.flatData(this.$refs.tree.getRawData());

      this.dbStatus = "";
      await this.$dbCon.insertUpdateData(this.$options.name, {table:"asset", payload:flatData})
        .then(response => {
          this.dbStatus += response.message;
        })
        .catch(error => {
          console.log(error.message);
        });
      await this.$dbCon.deleteData(this.$options.name, {table:"asset", payload:this.assets_for_delete})
        .then(response => {
          this.dbStatus += response;
          this.assets_for_delete = [];
        })
        .catch(error => {
          console.log(error.message);
        });
      this.loadAsset();
    },

  }
}
</script>

<style scoped>

.split-div{
  width: calc(50% - 24px);
}

.tree-card{
  width: 400px;
  padding: 10px;
}

.tree-card div{
  margin: 2px;
}

.tree-card-placeholder {
  height: 1px;
  border-bottom-color: yellow;
}

</style>
