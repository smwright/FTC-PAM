<template>
  <div class="members">
    <nav>
      <ul>
        <li><a href="#/members/members-list">All Members</a></li>
        <li><a href="#/members/characters-list">All Characters</a></li>
      </ul>
      <ul>
        <li v-for="squadron in squadrons"><a v-bind:href="'#/members/members-list/'+squadron.squadron_id">{{squadron.name}}</a></li>
      </ul>
    </nav>
    <router-view></router-view>
  </div>
</template>

<script>
import Squadron from './../resource/squadron'

let membersComponent = {
  name: 'Members',
  created: function () {
    this.getSquadrons()
  },
  data: function () {
    return {
      squadrons: []
    }
  },
  methods: {
    getSquadrons: function () {
      Squadron.getAll().then((data) => {
        this.squadrons = data
      }, (err) => {
        console.log(err)
      })
    }
  }
}

export default membersComponent
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
