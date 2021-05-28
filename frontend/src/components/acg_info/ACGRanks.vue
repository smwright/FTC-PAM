<template>
  <div class="container">
    <h1 class="text-align-center">
      Ranks
    </h1>
    <p class="text-align-justify">
      ACG is not hung up on ranks or calling each other "Sir".
    </p>
    <p class="text-align-justify">
      The ranking system provides a framework for leadership and management
      and only has relevance in providing members with a guide to who should
      be in charge of any group at any given time. The system is based on
      what somebody brings to the group and demotion occurs as easily as
      promotion.
    </p>
    <p class="text-align-justify">
      All new pilots come in at the lowest grade applicable to their units faction and all ranks are decided
      and approved by their unit commander. They will stay at the lowest
      grade until they show that they are active with the group and all this
      involves is getting involved and being a regular participant.
    </p>
    <p class="text-align-justify">
      Officers’ ranks are reserved for members that contribute to the group
      apart from flying. ACG is an historical group and tries to maintain an
      historical balance in the ranking system. The importance of the rank
      structure should not be over-stated; it simply forms part of the group
      immersion and should give an indication of the member's ability and
      responsibility and contribution.
    </p>
    <p class="text-align-justify">
      Promotion is based on:
    </p>
    <ul>
      <li>Squadron involvement</li>
      <li>Campaign participation and attendance</li>
      <li>Flying experience</li>
      <li>Flight leadership</li>
      <li>Communication</li>
      <li>Skill (take-off, landings, navigation & formation)</li>
      <li>Combat tactics & situational awareness</li>
      <li>Contribution other than just attending campaigns</li>
      <li>Training (provision & instruction)</li>
    </ul>
    <p class="text-align-justify">
      The individual ranks of each faction are associated with a specific rank value. This helps with adjusting the ranks
      of single members or whole units when transferring to a new faction. Sometimes the rank in the new factino needs further
      adjustment, which is then performed manually by the responsible adjutant.
    </p>
    <p class="text-align-justify">
      Below is a list of all ranks currently used in ACG and their corresponding rank value.
    </p>
    <div>
      <table class="width-80 margin-auto">
        <tr>
          <th class="width-20"></th>
          <th class="width-20">{{factionStatus[1].long}}</th>
          <th class="width-20">{{factionStatus[2].long}}</th>
          <th class="width-20">{{factionStatus[3].long}}</th>
        </tr>

        <tr
          class=""
          v-for="rank_value in rank_values">
          <td class="heading">
            Rank value: {{ rank_value }}
          </td>

          <td>
            <UniformRankComp
              class=""
              v-bind:single_component="true"
              v-bind:rank_real_value="rank_value"
              v-bind:rank_lookup ="ranks"
              v-bind:faction="1"
              v-bind:show_portrait="false"
            ></UniformRankComp>
          </td>
          <td>
            <UniformRankComp
              class=""
              v-bind:single_component="true"
              v-bind:rank_real_value="rank_value"
              v-bind:rank_lookup ="ranks"
              v-bind:faction="2"
              v-bind:show_portrait="false"
            ></UniformRankComp>
          </td>
          <td>
            <UniformRankComp
              class=""
              v-bind:single_component="true"
              v-bind:rank_real_value="rank_value"
              v-bind:rank_lookup ="ranks"
              v-bind:faction="3"
              v-bind:show_portrait="false"
            ></UniformRankComp>
          </td>
        </tr>
      </table>
    </div>
  </div>

</template>

<script>
import statConv from "../../resource/statusConverter"
import UniformRankComp from "../acg_member/UniformRankComp"

export default {
  name: "ACGRanks",
  components: {
    UniformRankComp
  },
  mixins: [
    statConv
  ],
  mounted () {

    this.$dbCon.requestViewData(this.$options.name,
      {view: "rank_lookup"})
      .then(response => {
        this.ranks = response;
      })
      .catch(error => {
        console.log(error.message);
      });
  },
  data () {
    return {

      ranks: [],
    }
  },
  computed: {

    rank_values: function () {

      return [...new Set(this.ranks.map(item => item.real_value))];
    }

  },
  methods: {

    rank_data: function (real_value, faction) {

      return this.ranks.find(
        function (item) {
          return (item.faction == faction) && (item.disp_value == real_value);
        }
      )
    }
  }
}
</script>

<style scoped>

  ul {
    margin-left: 25px;
    list-style-type: circle;
  }

  table {
    border-collapse: separate;
    border-spacing: 0px 5px;
  }

  td, th {
    background: rgba(0, 0, 0, 0.1);
    border-radius: 15px;
  }

</style>
