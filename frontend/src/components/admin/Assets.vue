<template>
  <div class="clearfix">
    <div>
      <button v-on:click="addAsset">Add asset</button>
      <button v-on:click="loadAsset">Fetch data</button>
      <button v-on:click="sendData">Save changes</button>
      <div>{{ dbStatus }}</div>
    </div>
    <div class="inline-block float-left">

      <TreeWrapper ref="tree" v-bind:treedata="assets">
        <template slot-scope="tree">
          <div class="inline-block float-left">
            <button v-if="tree.data.children && tree.data.children.length"
                    v-on:click="tree.store.toggleOpen(tree.data)" >
              {{tree.data.open ? '-' : '+'}}
            </button>
          </div>
          <div class="inline-block">

            <SwitchableDiv>
              <template slot="buttonStateA">
                <div>
                  {{ tree.data.name }}
                </div>
              </template>
              <template slot="contentStateA">
                <div>
                  {{ factionStatus[tree.data.faction].long }}
                </div>
                <div>
                  <span v-if="tree.data.controlable">Controllable</span>
                </div>
              </template>

              <template slot="buttonStateB">
                {{ tree.data.name }}
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
                  <input type="checkbox" id="checkbox" v-model="tree.data.controlable">
                </div>
                <div class="float-right">
                  <button v-on:click="deleteAsset(tree.data)">Delete</button>
                </div>
              </template>
            </SwitchableDiv>

          </div>
        </template>
      </TreeWrapper>

    </div>
    <div class="table">

      <h3>
        Assets:
      </h3>
      <p>
        Assets include all objects that are used in campaigns, for example plains that can be chosen in reports, or
        ground targets like tanks, ships and structures. They can be organized in groups and subgroups, thereby each group
        is an asset itself.
      </p>

      <h3>
        Editing assets:
      </h3>
      <p>
        Use the tree on the left to organize ACG assets. Assets can be dragged and dropped to form groups. Click on the
        name of each asset to edit it. Each asset can be given a name and faction. Each asset can be marked as
        controllable, which means it will be available as the pilots aircraft in the After Action Reports.
      </p>

      <p>
        <b>The available factions are:</b>
      </p>

      <ul>
        <li v-for="(faction, index) in factionStatus">
          <template v-if="index == 0">
            Neutral / No faction
          </template>
          <template v-else>
            {{ faction.long }}
          </template>
        </li>
      </ul>

      <p>
        <b>Adding assets:</b>
        Use the button on top of the page to add an asset.
      </p>

      <p>
        <b>Fetch data:</b>
        Use this button to reload the assets from the database. All changes will be lost.
      </p>

      <p>
        <b>Deleting assets:</b>
        Assets or assets-groups can be deleted by using the corresponding button. When an asset-group is deleted, all
        assets in that group will be moved into the parent group.
      </p>

      <p>
        <b>Save changes:</b>
        Use this button to save the changes and send them to the database. Deleted assets or asset-groups are still stored
        in the database until the changes are send to the database.
      </p>




    </div>
  </div>
</template>

<script>
import TreeWrapper from "../basic_comp/TreeWrapper"
import statConv from "../../resource/statusConverter"
import SwitchableDiv from "../basic_comp/SwitchableDiv"

export default {
  name: "Assets",
  components: {
    TreeWrapper,
    SwitchableDiv,
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
    }
  },

  methods: {

    addAsset: function () {
      var node =
        {
          id: -1,
          name: "New Asset",
          faction: 0,
          controlable: 0
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


</style>
