<template>
  <div class="container">
    <!--Part for display-->
    <SwitchableDiv>
      <template slot="buttonStateA">
        <div class="clearfix">
          <div class="inline-block float-left">{{ dbStatus }}</div>
          <button class="float-right">Edit</button>
        </div>
      </template>
      <template slot="contentStateA">
        <div class="clearfix">
          <div class="img-container inline-block float-left">
            <img :src="image"/>
          </div>

          <div class="inline-block">

            <div class="clearfix">
              <div class="inline-block float-left">
                <div>
                  <span class="heading">Name:</span>
                  <span>{{ name }}</span>
                </div>
                <div>
                  <span class="heading">Code:</span>
                  <span>{{ code }}</span>
                </div>
              </div>

              <div class="inline-block">
                <div>
                  <span class="heading">Faction:</span>
                  <span>{{ factionStatus[faction].long }}</span>
                </div>
              </div>
            </div>

            <div>
              <span class="heading">Description:</span>
              <p>{{ description }}</p>
            </div>

          </div>
        </div>
      </template>

      <template slot="buttonStateB">
        <div class="clearfix">
          <div class="inline-block float-left">{{ dbStatus }}</div>
          <button class="float-right" v-on:click.stop="deleteUnit">Delete unit</button>
          <button class="float-right" v-on:click.stop="sendData">Save changes</button>
          <button class="float-right">Exit edit</button>
        </div>
      </template>
      <template slot="contentStateB">
        <div class="clearfix">
          <div class="img-container inline-block float-left">
            <img :src="e_data.image"/>
          </div>

          <div class="inline-block">

            <div class="clearfix">
              <div class="inline-block float-left">
                <div>
                  <span class="heading">Name:</span>
                  <input v-model="e_data.name" v-on:input="checkForUnsaved()">
                </div>
                <div>
                  <span class="heading">Code:</span>
                  <input v-model="e_data.code" v-on:input="checkForUnsaved()">
                </div>
              </div>

              <div class="inline-block">
                <div>
                  <span class="heading">Faction:</span>
                  <select v-model="e_data.faction" v-on:change="checkForUnsaved()">
                    <option v-for="(faction, index) in factionStatus" v-bind:value="index">
                      {{ faction.long }}
                    </option>
                  </select>
                </div>
                <div>
                  <span class="heading">Image:</span>
                  <input v-model="e_data.image" v-on:input="checkForUnsaved()">
                </div>
              </div>
            </div>

            <div>
              <span class="heading">Description:</span>
              <textarea class="textarea-style" v-model="e_data.description" v-on:input="checkForUnsaved()"></textarea>
            </div>

          </div>
        </div>
      </template>
    </SwitchableDiv>
  </div>
</template>

<script>
import statConv from '../../resource/statusConverter'
import SwitchableDiv from '../basic_comp/SwitchableDiv'

export default {
  name: "HistUnitsBaseComp",
  components: {SwitchableDiv},
  mixins: [statConv],
  props: {
    id: {
      type: Number,
      default: null
    },
    name: {
      type: String,
      default: null
    },
    code: {
      type: String,
      default: null
    },
    faction: {
      type: Number,
      default: null,
    },
    description: {
      type: String,
      default: null
    },
    image: {
      type: String,
      default: null
    }
  },
  data () {
    return {
      dirty_data: false,
      e_data: {
        id: this.id,
        name: this.name,
        code: this.code,
        faction: this.faction,
        description: this.description,
        image: this.image
      },
      dbStatus: ""

    }
  },
  methods: {

    checkForUnsaved: function() {
      this.dirty_data = !(this.e_data.id === this.id
        && this.e_data.name === this.name
        && this.e_data.code === this.code
        && this.e_data.faction === this.faction
        && this.e_data.type === this.type
        && this.e_data.description === this.description
        && this.e_data.image === this.image);
    },

    sendData: function () {

      this.dbStatus = "";
       this.$dbCon.insertUpdateData(this.$options.name, {table:"hist_unit", payload:[this.e_data]})
        .then(response => {
          console.log("Response: " + JSON.stringify(response));
          this.dbStatus += response;
        })
        .catch(error => {
          console.log(error.message);
        });
    },

    deleteUnit: function () {

      if(!confirm("Do you want to delete "+this.e_data.name+"?")) {
        return;
      }

      this.dbStatus = "";
      if(this.e_data.id >= 0){
        //Only delete from database if id >= 0, meaining the unit exists in the database
        this.$dbCon.deleteData(this.$options.name, {table:"hist_unit", payload:[{id: this.e_data.id}]})
          .then(response => {
            console.log("Response: " + JSON.stringify(response));
            this.dbStatus += response;
          })
          .then(
            // call the parent component to remove the unit from hist_unit array
            this.$emit("deleteUnit", this.e_data.id)
          )
          .catch(error => {
            console.log(error.message);
          });
      } else {
        // call the parent component to remove the unit from hist_unit array
        this.$emit("deleteUnit", this.e_data.id)
      }
    }
  },
}
</script>

<style scoped>

div{
  margin: 2px;
}

button {
  margin: 2px;
}

.img-container {
  min-width: 100px;
  min-height: 100px;
}

img {
  max-width: 100px;
  max-height: 100px;
}

.textarea-style{
  width: 98%;
  height: 10em;
}

</style>
