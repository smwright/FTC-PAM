<template>
  <div class="container">
    <h1 class="text-align-center">
      Rules
    </h1>
    <h3>Participation</h3>
    <p class="text-align-justify">
      Members are expected to attend "most" of the missions with prior notice of absences being notified to unit commanders
      / adjutants. Any difficulties in regular attendance can usually be negotiated with a member of staff. Members not
      attending the Campaign Missions, without informing their unit commander/adjutant, will be contacted via pm or e-mail
      about their status. Repeated unexcused absence and failure to respond to status inquiries will result in dismissal.
    </p>
    <h3>Attitude</h3>
    <p class="text-align-justify">
      This is an immersion campaign not a competitive campaign. Pilots will be
      assigned a task to do as a squadron and will be expected to carry this
      out as best they can. There will be no winners or losers, events and
      outcomes are recorded, as happened historically, through the After
      Action Reports. The character system and ‘single life’ rules are there
      to promote immersion and encourage realistic behaviour in self-
      preservation during missions. There is no scoring. Events, results and claims are to be recorded
      in the After Action Reports. Submission of After Action Reports is
      compulsory - see Section 4 for details
    </p>
    <h3>Lives</h3>
    <p class="text-align-justify">
      Refly is allowed only if specifically briefed for an individual mission
      and may be subject to certain conditions (ie landing undamaged /
      unharmed, availability of turn around facilities etc). See the Mission
      Briefing for details.
    </p>
    <h3>Rules of Engagement (ROE)</h3>
    <table>
      <thead>
        <tr>
          <th width="20%">Target types</th>
          <th width="20%">Rule</th>
          <th width="20%">Claims</th>
          <th width="20%">Interpretation of effects</th>
        </tr>
        <tr><th colspan="4"><hr></th></tr>
      </thead>
      <tbody>
        <tr>
          <td>Aircraft on the ground at airfields</td>
          <td>Allowed if the airfield is on the Vulnerable Airfield List for that mission</td>
          <td>Aircraft Lost or Damaged status for affected targets that have landed, ditched, or crash landed do
            count. Claims may be submitted in all cases, but as a Ground Target claim.</td>
          <td>Pilot deaths/wounds do not count against any affected targets. Aircraft Lost or Damaged status for
            affected targets between spawning in and take off do not count, and the pilot may spawn in again</td>
        </tr>
        <tr>
          <td>Aircraft on the ground away from airfields (i.e. landed, ditched, crash landed etc.)</td>
          <td>Allowed</td>
          <td>Aircraft Lost or Damaged status for affected targets do count. Claims may be submitted in all cases, but as
            a Ground Target claim.</td>
          <td>Pilot deaths/wounds do not count against any affected targets</td>
        </tr>
        <tr>
          <td>Aircraft airborne, having just taken off from or on landing approach to an airfield</td>
          <td>Allowed if the airfield is on the Vulnerable Airfield List for that mission</td>
          <td>Normal rules apply</td>
          <td>Normal rules apply</td>
        </tr>
        <tr>
          <td>Parachutes</td>
          <td>NOT allowed. No shooting at parachutes at any time.</td>
          <td>-</td>
          <td>Pilot deaths/wounds do not count against any affected targets.</td>
        </tr>
      </tbody>
    </table>
    <h3>Explanation / Amplification</h3>
    <ul>
      <li>The Vulnerable Airfield List for any given mission will typically include most airfields, with specific exceptions
        for those active bases which are either far enough away from the front line or sufficiently well defended as to
        be considered immune from attack.</li>
      <li>If on the ground, a pilot character is not affected by death and wounds inflicted by air attack. Taking off from
        a Vulnerable Airfield immediately puts a pilot/character at risk.</li>
      <li>If attacking a Vulnerable Airfield, the only restriction is that claims against aircraft on the ground should
        be submitted as Ground Targets. Making pilots submit Ground Target claims for attacking aircraft on the ground,
        at or away from airfields, should remove much of the incentive for doing so.</li>
      <li>The Mission Planner (and Mission Control if in operation) should, where possible, avoid situations where airfields
        come under attack just as units are taking off on their first sortie of the mission.</li>
      <li>Mission Control can, if necessary, intervene to prevent or stop an airfield attack.</li>
      <li>Individual scenarios may allow the replacement of damaged aircraft, or aircraft destroyed during or after landing
        at their starting base in order for the pilot to continue the mission.</li>
      <li>No attack should be made if any doubt exists on its validity (i.e. unsure of position and or the status of an
        airfield).</li>
      <li>Pilots are free to impose their own ‘code of honour’ on what targets they engage, these rules just provide an
        official, common baseline.</li>
    </ul>
    <p class="text-align-justify">
      Any transgressions of these rules should be reported through the chain of command or to Mission / Ground Control (if
      in operation) and will be dealt with by the ACG Board of Directors as required.
    </p>
  </div>
</template>

<script>
    export default {
        name: "ACGCampaignRules"
    }
</script>

<style scoped>

td {
  padding: 10px
}

ul {
  margin: 10px;
  padding: 10px;
}

li {
  padding: 2px;
  list-style: circle;
}
</style>
