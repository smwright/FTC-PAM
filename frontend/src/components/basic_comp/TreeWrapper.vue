<template>
  <DraggableTree ref="tree" v-if="treedata != null" v-bind:data="treedata" draggable="true">
    <div slot-scope="{data, store, vm}" class="clearfix">
      <template v-if="!data.isDragPlaceHolder">
        <slot
          v-bind:data="data"
          v-bind:store="store"
        >
        </slot>
      </template>
    </div>
  </DraggableTree>
</template>

<script>
  import {DraggableTree} from 'vue-draggable-nested-tree'

  export default {
    name: "TreeWrapper",
    components: {
      DraggableTree
    },
    props: {
      treedata: {
        type: Array,
        default: function () {
          return [];
        }
      }
    },
    methods: {

      getRawData: function () {

        if(this.$refs.tree !== undefined){
          return this.$refs.tree.getPureData();
        } else {
          return undefined;
        }
      },

      addNode: function (node) {

        this.$refs.tree.data.unshift(node);
      },

      deleteNode: function (node) {

        var parentNode = node.parent;
        var nodeChildren = [];
        if (node.children && node.children.length){
          nodeChildren = this.$refs.tree.pure(node, true).children;
        }

        var newChildren = [];
        while(parentNode.children.length > 0){
          var i = 0;
          var c_child = parentNode.children[i]
          if(c_child._id != node._id) {
            newChildren.push(this.$refs.tree.pure(c_child, true));

          } else {

            for(var j = 0; j < nodeChildren.length; j++){
              newChildren.push(nodeChildren[j]);
            }
          }
          this.$refs.tree.deleteNode(c_child);
        }

        for(var i = 0; i < newChildren.length; i++){
          parentNode.children.push(newChildren[i]);
        }

      },
    }
  }
</script>

<style scoped>


</style>
