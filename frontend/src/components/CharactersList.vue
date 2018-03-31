<template>
  <div class="all-characters">
    <h1>ACG-Characters</h1>
    <p>These pages list all ACG characters with their corresponding names, callsigns, their status and their last active squadron. Click on any character to access a detailed profile.</p>
    <table>
      <tr>
        <th>Rank</th>
        <th>Name</th>
        <th>Callsign</th>
        <th>Status</th>
        <th>Squadron/Staffel</th>
        <th>Last mission</th>
      </tr>
      <tr class="link" v-for="character in characters" v-on:click="routeToCharacter(character.character_id)">
        <td>{{character.rank}}</td>
        <td>{{character.name}}</td>
        <td>{{character.callsign}}</td>
        <td>{{character.status}}</td>
        <td>{{character.squadron}}</td>
        <td>{{character.last_mission}}</td>
      </tr>
    </table>
 
  </div>
</template>

<script>
import Character from './../resource/character'
export default {
  name: 'CharactersList',
  created: function () {
    this.getCharacters()
  },
  data () {
    return {
      characters: []
    }
  },
  methods: {
    getCharacters: function () {
      Character.getAll().then((data) => {
        this.characters = data
      },(err) => {
        console.log(err)
      })
    },
    routeToCharacter: function (characterID) {
      this.$router.push({name: 'Character', params: {character_id: characterID}})
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
