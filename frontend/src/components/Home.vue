<template>
  <div>
  <div class="header">
    <h1>Welcome to the Air Combat Group</h1>
  </div>
    <div class="home">
      <p>
      The Air Combat Group consists of both Allied and Axis squadrons under a single operational umbrella flying with full realism settings. We are an English and German speaking group located in Europe, the Americas and Australia and meet on our own Teamspeak 3 and Discord servers. Our pilots are interested in the history of World War II air combat on all fronts, seeking immersive air combat in the theatres of the time through historical campaign and other online activities. By supporting both sides of the conflict we can create parity in theatre and achieve common ground across the group, ultimately we seek to mirror the numbers flying on each side and support increasingly large campaigns.
    </p>
    <p>
      Our objective is to provide an unpressurised, non-competitive and friendly environment in which to enjoy combat operations, whichever side a pilot prefers, and all standards are welcome regardless of experience. The squadrons within the group are historically based and the missions we fly are selected for their historical accuracy whether on our public server or in campaign. Group and squadron objectives are to re-enact the history ahead of competition, to attempt to be a part of being there, to learn about some of the experiences that were faced by the young pilots who fought for their countries in World War II and to honour them by understanding more about what they faced.
    </p>
    <p>
      If this sounds of interest to you we are welcoming to new pilots of any standard or experience, even if you've never flown before - all you need is a decent PC with IL-2 Sturmovik: Cliffs of Dover or IL-2 Sturmovik: Battle of Stalingrad (depending on the campaign being run) and a headset/microphone. Just hop onto our TS3 comms at anytime, weekends are best, and join in the fun.
    </p>
    <iframe id="ytplayer" type="text/html" width="930" height="518" src="https://www.youtube.com/embed/v6u4JxgE2S4?autoplay=1&origin=http://aircombatgroup.co.uk"
            frameborder="0"></iframe>
  </div>
  </div>


</template>

<script>
import he from 'he'

export default {
  name: 'Home',
  async mounted () {

    console.log("Testing PHP connection")
    this.$store.commit('logger/addEntry', {message: "Testing PHP connection"})
    this.$dbCon.requestViewData(this.$options.name, {view: "campaign_list"})
      .then((response) => {
        console.log("PHP connection test, response received.");
        this.$store.commit('logger/addEntry', {message: "PHP connection test, response received."});
        console.log(response);
      })
      .catch((error) => {
        console.log("PHP connection test, error ");
        this.$store.commit('logger/addEntry', {message: "PHP connection test, error."});
        console.log(error.message);

      });

    console.log("Starting store testing");
    console.log("Calling getter: " + this.$store.getters['test/doubleCount'])
    console.log("Calling mutation: ")
    this.$store.commit('test/increment')
    console.log("Calling getter: " + this.$store.getters['test/doubleCount'])

    await this.$auth.syncSession(this.$options.name);
    console.log("he-version: "+he.version);

  },
  methods: {

  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

.home{
  width: 60%;
  text-align: justify;
  margin-left: auto;
  margin-right: auto;
}

.header{
  width: 60%;
  text-align: center;
  margin-left: auto;
  margin-right: auto;
}

</style>
