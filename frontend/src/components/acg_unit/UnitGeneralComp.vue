<template>
  <div class="container">
    <div class="padding-10">
      <h1 class="text-align-center">ACG's units</h1>
      <p class="text-align-justify">
        Here you can find information about ACG's units.
      </p>
      <p class="text-align-justify">
        The Group consists of allied and axis combat units (base units). Depending on the campaign these base units may
        represent different historical units depending on the actual unit deployment in the area of operations at the time
        the campaign is taking place.
      </p>
      <p class="text-align-justify">
        ACG is predominantly English speaking, but there are currently two German speaking units. Their internal campaign
        communication is done primarily in German.
      </p>

      <h3>Base units</h3>
      <p class="text-align-justify">
        Air combat group is subdivided into {{ acg_units.length }} units, called base units or acg-units in the following.
        A base unit normally consists of up to 12 members, and each base unit has it's own character and aspects. I.e.
        some units communicate in some train more regularly, some are more laid back, some are switching regularly factions,
        some prefer one particular faction, some prefer to fly attack aircraft or bombers, etc.
      </p>
      <p class="text-align-justify">
        A base unit is lead by a commanding officer (CO) under the assistance of an adjutant. The CO is leading the unit during
        the campaign missions and represents the unit during staff meetings. The adjutant is taking care of all administrative
        task of the unit (i.e. transfers, promotions, decorations, after action report and claim approval etc.). Not all base
        units are active at all time. Some units are set to inactive depending on the campaign requirements and membership
        numbers.
      </p>
      <p class="text-align-justify">
        ACG's base units are not representing any specific unit or faction in particular. They are just a functional unit to
        organize it's members. The units get their historic context and faction through the historic units for each campaign.
        The name of the base units are derived from the historic unit that they were representing when they were formed.
      </p>
      <p class="text-align-justify">
        The base units are listed on the left in the vertical menu. Click on the name of the unit to get more information about
        a particular base unit. Click on the button labeled "Base units" if you can't see the list.
      </p>
      <h3>Historical units</h3>
      <p class="text-align-justify">
        ACG uses a collection of historic units to give the base units their historic context for each campaign. The historic units are thereby
        representing units on a squadron level like i.e. Royal Air Force squadrons or Luftwaffe Staffeln, but also bigger
        and overarching organizations as Luftwaffe Gruppen or Geschwader, or Royal Air Force Groups.
      </p>
      <p class="text-align-justify">
        A specific unit structure consisting of various historic units is put in place for each of ACG's campaigns, trying to reflect the structure
        the air forces of the battle depicted in the campaign as much as possible and practicable. Base units are then assigned
        to some of the historic units. The active base units are representing their assigned historic unit while that particular
        campaign is ongoing. The emblems and icons in the forums of ACG's members reflect their historical unit for the current
        campaign.
      </p>
      <p class="text-align-justify">
        The historical units are listed on the left in the vertical menu. The pages to show more information about
        the historical units are still under development. Click on the button labeled "Historical units" if you can't see the list. Additionally
        you can filter the list to show only units from a particular faction by using the faction buttons, or search for a
        unit with a specific name by using the search field.
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
    </div>

  </div>
</template>

<script>
import { mapState } from "vuex"

export default {
  name: "UnitGeneralComp",
  computed: {

    ...mapState('unitInfo', {
      acg_units: state => state.acg_units,
      hist_units: state => state.hist_units
    })
  }
}
</script>

<style scoped>

</style>
