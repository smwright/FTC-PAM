<template>
    <canvas
      id="canvas_id"
      v-bind:width = "this.c_width"
      v-bind:height = "this.c_height"
    >
    </canvas>
</template>

<script>
export default {
  name: "Canvas",
  props: {
    c_width: {
      type: Number,
      default: 200
    },
    c_height: {
      type: Number,
      default: 200
    },
    c_components: {
      type: Array,
      default: function () {
        return [];
      }
    }
  },
  async mounted () {

    let c = document.getElementById("canvas_id");
    let ctx = c.getContext("2d");
    ctx.filter = "sepia(65%)"
    this.vueCanvas = ctx;

    let item;
    for(item of this.c_components){

      switch (item.type) {
        case "image":
          await this.drawImage(item.url, item.x, item.y, item.width, item.height)
            .catch((e) => { console.log(e); });
          break;

        case "line":
          this.drawLine(item.x_start, item.y_start, item.x_end, item.y_end, item.lineWidth, item.color);
          break;

        case "circle":
          this.drawCircle(item.x, item.y, item.radius, item.start_angle, item.end_angle, item.lineWidth, item.color);
          break;

        case "text":
          this.drawText(item.txt, item.x, item.y, item.font, item.color);
          break;

        default:

      }
    }

  },
  data () {
    return {

      vueCanvas: null
    }
  },
  methods: {

    drawLine: function (x_start, y_start, x_end, y_end, lineWidth, color) {

      let lwbuffer = this.vueCanvas.lineWidth;
      let colbuffer = this.vueCanvas.strokeStyle;
      this.vueCanvas.lineWidth = lineWidth;
      this.vueCanvas.strokeStyle = color;
      this.vueCanvas.moveTo(x_start, y_start);
      this.vueCanvas.lineTo(x_end, y_end);
      this.vueCanvas.stroke();
      this.vueCanvas.lineWidth = lwbuffer;
      this.vueCanvas.strokeStyle = colbuffer;
    },

    drawRect: function (x_start, y_start, x_end, y_end) {

      this.vueCanvas.beginPath();
      this.vueCanvas.rect(x_start, y_start, x_end, y_end);
      this.vueCanvas.stroke();
    },

    drawCircle: function (x, y, radius, start_angle, end_angle, lineWidth, color) {

      let lwbuffer = this.vueCanvas.lineWidth;
      let colbuffer = this.vueCanvas.strokeStyle;
      this.vueCanvas.lineWidth = lineWidth;
      this.vueCanvas.strokeStyle = color;
      this.vueCanvas.beginPath();
      this.vueCanvas.arc(x, y, radius, start_angle, end_angle);
      this.vueCanvas.stroke();
      this.vueCanvas.lineWidth = lwbuffer;
      this.vueCanvas.strokeStyle = colbuffer;
    },

    drawText: function (text, x, y, font, color) {

      this.vueCanvas.font = font;
      let colbuffer = this.vueCanvas.fillStyle;
      this.vueCanvas.fillStyle = color;
      this.vueCanvas.fillText(text, x, y);
      this.vueCanvas.fillStyle = colbuffer;
    },

    drawImage: function (url, x, y, width, height) {

      let c = this.vueCanvas;
      return new Promise(function(resolve, reject) {

        let img = new Image();
        img.onload = function () {
          console.log("Drawing image");
          c.drawImage(img, x, y, width, height);
          resolve();
        };
        img.onerror = function () {
          reject("Error loading image, src="+url);
        };
        img.src = url;
      });

    },

  }
}
</script>

<style scoped>

</style>
