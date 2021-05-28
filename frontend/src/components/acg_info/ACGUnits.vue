<template>
  <div class="container">
    <div class="padding-10">
      <h1 class="text-align-center">ACG's units</h1>
      <p class="text-align-justify">
        The Group consists of allied and axis combat units. Depending on the campaign these units may differ depending on the
        actual unit deployment in the area of operations at the time the campaign is taking place.
      </p>
      <h3>Unit Commanders & Adjutants</h3>
      <p class="text-align-justify">
        Unit commanders manage and direct day-to-day operations of their
        respective units. They are responsible for welcoming, training,
        developing, promoting and supporting their unit members as well as
        directing and leading operations during campaign missions. Each Unit
        Commander is supported by an Adjutant to assist in these duties.
      </p>
      <p class="text-align-justify">
        ACG is predominantly English speaking, but there are currently two
        German speaking units. Their internal campaign communication is done
        primarily in German.
      </p>
      <h3>Holding (RSV) & HQ Units</h3>
      <p class="text-align-justify">
        ACG has instituted Holding Units (RSV) and HQ Units to assist in the
        administrative process of dealing with members who go on leave or
        contribute to ACG in other ways other than flying.
      </p>
      <p class="text-align-justify">
        Holding Units (RSV) are designed to take on long-standing ACG members who go
        on leave for an extended period of time. A leave period of less than 2
        months will be handled by unit commanders as usual (temporary leave).
      </p>
      <p class="text-align-justify">
        For a leave period of equal to or more than 2 months unit commanders
        are required to request a transfer of the member to a holding squadron
        for a specific time frame. The standard holding period is 2 to 6 months.
        The limit of 6 months is a soft limit and can be requested by unit
        commanders after communication with the member in question.
      </p>
      <p class="text-align-justify">
        HQ Units are designed to hold long standing ACG members who contribute
        to ACG but do not have the time to fly on a regular basis. Members are
        assigned here with Board approval only. Length of stay, possible
        dismissal, and re-assignment to a flying unit is decided by the Board
        and executed by the Chief Adjutants.
      </p>
      <h3>MIA</h3>
      <p class="text-align-justify">
        Holding Units will not take on members who go MIA, i.e. members who
        leave without giving notice. If a Holding Unit’s member becomes MIA
        after his extended leave of absence period is up (more than 6 months) the
        member must be dismissed. It is up to the individual pilot to stay in
        contact with ACG. The leaders of his previous unit may try to reach out
        as well and inform the respective Chief Adjutant if successful. After his
        leave of absence, a pilot may re-join his former unit if recruitment
        needs allow for that.
      </p>


      <DivLinkButton v-bind="{routeName: 'Units'}">
        <div class="heading">For a complete list of all ACG units and more detailed info about each unit click here.</div>
      </DivLinkButton>
    </div>

  </div>
</template>

<script>
import DivLinkButton from "../basic_comp/DivLinkButton"

export default {
  name: "ACGUnits",
    components: {
    DivLinkButton,
  },
  }
</script>

<style scoped>

</style>
