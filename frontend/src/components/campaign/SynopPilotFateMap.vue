<template>
  <div class="typed-on-paper">

    <div class="heading" v-if="fate_data.length > 0">
      Walk home map for {{ fate_data[0].username }}
    </div>

    <div class="text-align-justify padding-2-10" v-if="fate_data.length > 0" >
      <template v-if="has_map_data">
        The map below displays the walk home route and events for {{ fate_data[0].username }}. Use the mouse-wheel to scroll
        the map vertically, hold SHIFT and use the mouse wheel to scroll the map horizontally.
      </template>
      <template v-else>
        There is no available information regarding the walk home route and events for {{ fate_data[0].username }}.
      </template>
    </div>

    <PilotFateDescription class="padding-2-10"></PilotFateDescription>

    <div id="canvas-div">
      <Canvas
        v-if="this.fate_data.length > 0"
        v-bind:c_width="canvas_div_width"
        v-bind:c_height="canvas_div_height"
        v-bind:c_components="draw_comp"
      ></Canvas>
    </div>
  </div>
</template>

<script>
import {mapState, mapGetters} from "vuex"
import Canvas from "../basic_comp/Canvas"
import PilotFateDescription from "./PilotFateDescription"

export default {
  name: "SynopPilotFateMap",
  components:{
    Canvas,
    PilotFateDescription
  },
  mounted () {

    // this.canvas_div_width = document.getElementById("canvas-div").offsetWidth;
    // this.canvas_div_height = document.getElementById("canvas-div").offsetHeight;
  },
  data () {
    return {

      // member_id: 397, // for a test
      // flight_id: 3,
      canvas_div_width: 4157,
      canvas_div_height: 2878,
      map_width: 4157,
      map_height: 2878
    }
  },
  computed: {

    has_map_data: function () {

      return this.fate_data.length > 0 && (this.fate_data[0].path_points != null
        || this.fate_data[0].last_point != null);
    },

    fate_data: function () {

      return this.filterByKeys("pilot_fates",
        {
          member_id: this.$route.params.member_id,
          FlightNumber: this.$route.params.flight_number
        })
    },

    walk_coord: function () {

      let coord = [];
      let buff = [];
      let item;
      if(this.fate_data.length > 0 && this.fate_data[0].path_points != null){
        buff = this.fate_data[0].path_points.match(/\[(.+?)\]/g);
        for(item of buff){
          coord.push(item.substring(1, item.length-1).split(",").map(Number));
        }
      }
      return coord;
    },

    last_coord: function () {

      let coord = [];
      if(this.fate_data.length > 0 && this.fate_data[0].last_point != null){
        coord = this.fate_data[0].last_point;
        coord = coord.substring(1, coord.length-1).split(",").map(Number)
      }
      return coord;
    },

    draw_comp: function () {

      //Get scaling ratio
      let x_ratio = this.canvas_div_width/this.map_width;
      let y_ratio = this.canvas_div_height/this.map_height;
      let scaling_factor;

      if(x_ratio >= y_ratio){
        scaling_factor = y_ratio;
      } else {
        scaling_factor = x_ratio;
      }


      let comp = [];
      comp.push({
        type: "image",
        url: "/assets/images/kuban_base.png",
        x: 0,
        y: 0,
        width: this.map_width*scaling_factor,
        height: this.map_height*scaling_factor
      });

      if(this.walk_coord.length > 0){

        for(let i = 0; i < this.walk_coord.length-1; i++){
          comp.push({
            type: "line",
            x_start: this.walk_coord[i][0]*scaling_factor,
            y_start: this.walk_coord[i][1]*scaling_factor,
            x_end: this.walk_coord[i+1][0]*scaling_factor,
            y_end: this.walk_coord[i+1][1]*scaling_factor,
            lineWidth: 2,
            color: "#333333"
          })
        }


        comp.push({
          type: "circle",
          x: this.walk_coord[0][0]*scaling_factor,
          y: this.walk_coord[0][1]*scaling_factor,
          radius: 5,
          start_angle: 0,
          end_angle: 2*Math.PI,
          lineWidth: 2,
          color: "#333333"
        });

        comp.push({
          type: "text",
          txt: "Crash/Parachute site",
          x: this.walk_coord[0][0]*scaling_factor + 10,
          y: this.walk_coord[0][1]*scaling_factor,
          font: "22pt Dawning of a New Day",
          color: "#000F55"
        })

        comp.push({
          type: "circle",
          x: this.walk_coord[this.walk_coord.length-1][0]*scaling_factor,
          y: this.walk_coord[this.walk_coord.length-1][1]*scaling_factor,
          radius: 1,
          start_angle: 0,
          end_angle: 2*Math.PI,
          lineWidth: 2,
          color: "#333333"
        });

      }

      if(this.last_coord.length > 0){

       if(this.last_coord != null){
          comp.push({
            type: "circle",
            x: this.last_coord[0],
            y: this.last_coord[1],
            radius: 20,
            start_angle: 0,
            end_angle: 2*Math.PI,
            lineWidth: 2,
            color: "#333333"
          });
          comp.push({
            type: "text",
            txt: this.fate_data[0].o_outcome,
            x: this.last_coord[0],
            y: this.last_coord[1],
            font: "22pt Dawning of a New Day",
            color: "#000F55"
          });

        }
      }

      return comp;
    },

    ...mapGetters("missionStore", [
      "filterByKeys"
    ])
  },
}
</script>

<style scoped>

#canvas-div {
  color: #333333;
  width: 100%;
  height: 700px;
  overflow: scroll;
}

</style>
