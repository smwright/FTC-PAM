<template>
  <div class="typed-on-paper">
    <template v-for="text_object in processed_text_array">
      <template v-if="text_object.type === 'text'">
        <p>
          {{ text_object.content }}
        </p>
      </template>
      <template v-else-if="text_object.type === 'img'">
        <img class="image-container" :src="text_object.content">
      </template>
    </template>
  </div>
</template>

<script>

export default {
  name: "TextWithImages",
  props: {
    original_text: {
      type: String,
      default: ""
    }
  },
  mounted() {

    this.parseText();
  },
  watch: {
    'original_text': function () {
      this.parseText();
    }
  },
  data () {
    return {

      processed_text_array: []
    }
  },
  methods: {

    parseText: function () {

      this.processed_text_array = [];
      var image_start_tag = "[img]";
      var image_stop_tag = "[/img]";
      var start_pos = 0;
      var string_to_search = this.original_text.substring(0);
      var stop_pos = string_to_search.indexOf(image_start_tag, start_pos);

      if(stop_pos === -1){
        this.addContent("text", string_to_search);
        // this.processed_text_array.push({type: "text", content: string_to_search, pos:[start_pos, stop_pos]});
      } else {

        while(stop_pos != -1) {//(var i = 0; i<50; i++) {

          this.addContent("text", string_to_search.substring(start_pos, stop_pos));
          // this.processed_text_array.push({type: "text", content: string_to_search.substring(start_pos, stop_pos), pos:[start_pos, stop_pos]});
          start_pos = stop_pos + image_start_tag.length;
          stop_pos = string_to_search.indexOf(image_stop_tag, start_pos);

          this.addContent("img", string_to_search.substring(start_pos, stop_pos));
          // this.processed_text_array.push({type: "img", context: string_to_search.substring(start_pos, stop_pos), pos:[start_pos, stop_pos]});
          start_pos = stop_pos + image_stop_tag.length;
          stop_pos = string_to_search.indexOf(image_start_tag, start_pos);
        }
        this.addContent("text", string_to_search.substring(start_pos));
        // this.processed_text_array.push({type: "text", context: string_to_search.substring(start_pos), pos:[start_pos, stop_pos]});
      }

    },

    addContent: function (content_type, content_text) {

      if(content_text.length > 0){
        this.processed_text_array.push({type: content_type, content: content_text});
      }
    }
  }

}
</script>

<style scoped>

.image-container{

  max-width: 100%;
}

</style>
