<template>
  <HideableDiv
    v-bind:changing-button="true"
  >
    <template slot="buttonVisible">
      <button>Hide description</button>
    </template>
    <template slot="buttonHidden">
      <button>Walk home description</button>
    </template>
    <p class="text-align-justify">
      When a pilot ditches/crashes/ends up alive with no altitude a script checks to see if the pilot is in friendly, enemy or "No Man's Land"
      territory ... Or indeed in water. This is determined from a Red/Blue map the mission team provides every week that the front
      line changes, and a coastline/water map.
    </p>
    <p class="text-align-justify">
      If the pilot is in friendly land territory, nothing happens. He is assumed to have made it back safely.
    </p>
    <p class="text-align-justify">
      Otherwise: First a check is performed to see if the pilot is over water. If the pilot is there is an instantaneous
      check to see if he avoids drowning in the crash.
    </p>
    <p class="text-align-justify">
      If the pilot survives the crash the script does a quick ASR roll. If he is in "Friendly Water" (i.e. on his side
      of the front that extends over the water) he has a set percentage chance of success. This drops off with distance
      (using the "distance probability method" - DPM, explained below) from the front if he is in enemy water. Note if
      the pilot is in a lake as opposed to open water, as defined by a lake map, he won't get no ASR.
    </p>
    <p class="text-align-justify">
      The script then calculates the closest land point, irrespective of whether it is friendly or not. This distance
      allows the script to use the DPM to calculate the probability of reaching that point by swimming, and the pilot passes
      that probability roll he makes landfall.
    </p>
    <p class="text-align-justify">
      Once on land (or if the pilot crashes on land as opposed to water) the script determines the shortest route to the
      nearest point that is either a friendly coastline -OR- a land-based frontline. When determining shortest route, the
      script takes into consideration whether a route crosses water or towns. Water and towns are considered more "expensive"
      than open land - so a route of 10Km that crosses some water will be considered "longer" than a route of 10km that
      only covers open land. The path with the shortest "terrain adjusted distance" is the one chosen, and it is this
      "terrain adjusted distance" that is used when calculating the pilots probability of success. Note the chance of
      crossing water here is much better than the initial swim. This is justified on the basis that when a pilot first
      lands in the water he is shocked, possibly injured etc... and has no choice - whereas when he walks home he may
      steal a boat, wait until nightfall, choose when to go over water etc... i.e. he is going in prepared when he thinks
      it is "best" as opposed to because he has to.
    </p>
    <p class="text-align-justify">
      Assuming the pilot covers that distance, he then has a one-off roll to cross the front. If he fails this roll, his
      chance of being captured as opposed to dying is directly based on his health - i.e. if he has 80% health he is 80%
      likely to be captured. But either way ... He's not coming home.
    </p>
    <p class="text-align-justify">
      If the pilot gets past all that ... He deserves to survive!
    </p>
    <p class="text-align-justify">
      A couple of things:
    </p>
    <ol>
      <li>
        The pilots health directly affects all dice rolls. So for example if he has a probability of walking to the front
        of 80%, but is on 50% health, his new probability is 40% (from 80% X 50%). Likewise if he is at 75% health and
        land in water, his chance of surviving the drown risk on impact is 0.75X (where X is the probability of surviving
        the initial crash into water.)
      </li>
      <li>
        Time of year has an impact. A sin function is used to determine how much of an impact. - i.e. at the height of
        summer there is no impact, at the height of winter there is the full impact, and it is a circular as opposed to
        linear function between the two.
      </li>
    </ol>
    <p class="text-align-justify">
      <b>Distance Probability Method:</b> Basically, the idea behind this is that "AND" probabilities are multiplied.
      So if the probability of covering 1 km is 0.9, the probability of covering 2 km is 0.81 (0.9 X 0.9), 3km is 0.729
      (0.9 X 0.9 X 0.9) etc...
    </p>
    <p class="text-align-justify">
      One can use this idea to work out backwards, what probability would give a compound 50% success at (e.g.) 300 rolls
      - i.e. the probability multiplied by itself 300 times to give a value of 50% is 0.5^(1/300). Taking 300 rolls would
      be the equivalent of walking 300 horizontal (or vertical) pixels which equates to 30km. The beauty of using an approach
      like this is that one gets a nice decay curve, so to continue the example if the p(success) at 30km is 50%, one
      knows that the p(success) at 60km is 25% and p(success) at 90km is 12.5%. If one brings that distance in (say for
      cold weather) to p(success) at 15km = 50% and calculate what p is ... then likewise using that p we know that the
      likelihood of success at 30km is now 25% etc... Like this the chance of success tends to zero as opposed to falling
      off a cliff suddenly, so one has the chance, albeit small, of the kind of survival tales that become the stuff of
      legend!
    </p>
    <p class="text-align-justify">
      This approach is non-linear, i.e. if one has a 50% probability of walking 30km, that does not mean one has a 75%
      chance of walking 15km.
    </p>
    <p class="text-align-justify">
      So, if one puts all of that into an example: If a pilot has a 50% probability of walking 30km unscathed (and he has
      15km to cover to the front after taking into account water features and towns) one knows: p_base = 0.5^(1/300) = 0.997692177
      - This is the probability of him successfully covering 100m.
    </p>
    <p class="text-align-justify">
      One can then say that the compound probability of covering 15km is: 0.997692177^150 = 0.7071, or 70.71%. If one
      rolls less than 0.7071 on a random roll, then great - he survived. If, however, one rolls more - say 0.76, then
      one can do LN(0.76) / LN(0.997692177) to give the distance he successfully covered before death / capture (which
      in this instance would be 11.8km). It makes no difference to the outcome, but allows to create a map.
    </p>
  </HideableDiv>
</template>

<script>
import HideableDiv from "../basic_comp/HideableDiv"

export default {
  name: "PilotFateDescription",
  components: {
    HideableDiv
  }
}
</script>

<style scoped>

</style>
