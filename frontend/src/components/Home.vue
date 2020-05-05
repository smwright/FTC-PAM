<template>
  <div class="padding-10">
    <div>
      <h1 class="text-align-center">Welcome to the Air Combat Group</h1>

      <p class="text-align-justify">
        We are an English and German speaking group with members all over the world. Our pilots are interested in the history
        of  air combat on all fronts, seeking an immersive experience through our historical campaigns. Our objective is
        to provide an unpressurised, non-competitive and friendly environment in which to enjoy combat operations, whichever
        side a pilot prefers, and all standards are welcome regardless of experience.
      </p>
      <p class="text-align-justify">
        Feel welcome and have a look around. On this page you’ll find a lot of information about what ACG is and what we
        do. Don’t be shy and get into contact with us if you have any more questions.
      </p>

      <DivLinkButton
        class="padding-0-10"
        route-name="AboutACG"
      >
        <h4>About ACG</h4>
        <p class="text-align-justify">Here you’ll find detailed information about how ACG is organized and how we operate, as well as information about
          ACG’s history. You’ll find as well information on how to join ACG and how to get into contact with us.</p>
      </DivLinkButton>

      <div class="div-button padding-0">
        <a href="http://www.aircombatgroup.co.uk/forum" >
          <h4 class="heading">Forums</h4>
          <p class="text-align-justify">
            The forums are our main communication channel. It’s used to discuss all things ACG and more. There’s a section
            for technical help and a reception for interested persons to introduce themselves. Do not hesitate to register
            and take part in the conversation, or ask us any questions you have about the group.
          </p>
          <p class="text-align-justify">
            ACG members: Go here to access the submission forms for their after action reports.
          </p>
        </a>
      </div>

      <DivLinkButton
        class="padding-0-10"
        route-name="CampaignList"
      >
        <h4 class="heading">Campaigns</h4>
        <p class="text-align-justify">
          The historical campaigns are the heart and soul of ACG. In this part of the page you can explore ACG’s past, present
          and future campaigns. Look at the units that took part in each campaign, read the mission briefings and enjoy
          the after action reports written by our members.
        </p>
      </DivLinkButton>

      <DivLinkButton
        class="padding-0-10"
        route-name="Units"
      >
        <h4 class="heading">Units</h4>
        <p class="text-align-justify">
          What are ACG’s units and who’s in them? There’s two types of units in ACG: Base units and Historical units. In
          this part of the page you’ll find information about both types. What are they? Who’s in them? And in which campaigns
          were they flying?
        </p>
      </DivLinkButton>

      <DivLinkButton
        class="padding-0-10"
        route-name="Members"
      >
        <h4 class="heading">Members</h4>
        <p class="text-align-justify">
          There’s currently {{ number_members }} active members in ACG. The members part of the page gives you a list of all present and former
          members and their pilot characters. Here you can browse through the stats of each members based on the submitted
          after action reports.
        </p>
      </DivLinkButton>
    </div>



    <!--<iframe id="ytplayer" type="text/html" width="100%" height="400px" src="https://www.youtube.com/embed/v6u4JxgE2S4?autoplay=0&origin=http://aircombatgroup.co.uk"-->
            <!--frameborder="0"></iframe>-->
  </div>
</template>

<script>
import he from 'he'
import DivLinkButton from './basic_comp/DivLinkButton'

export default {
  name: 'Home',
  components: {
    DivLinkButton
  },
  async mounted () {

    console.log("Testing PHP connection")
    // this.$store.commit('logger/addEntry', {message: "Testing PHP connection"})
    this.$dbCon.requestViewData(this.$options.name, {view: "member_info_with_last_status", member_status: 0})
      .then((response) => {
        console.log("PHP connection test, response received.");
        // this.$store.commit('logger/addEntry', {message: "PHP connection test, response received."});
        console.log(response);
        this.number_members = response.length;
      })
      .catch((error) => {
        console.log("PHP connection test, error ");
        // this.$store.commit('logger/addEntry', {message: "PHP connection test, error."});
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
  data () {

    return {

      number_members: null
    }
  },
  methods: {

  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>


</style>
