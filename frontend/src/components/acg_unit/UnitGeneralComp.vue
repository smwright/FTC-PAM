<template>
  <div class="container">
    <div class="padding-10">
      <h1 class="text-align-center">ACG's units</h1>
      <p class="text-align-justify">
        Here you can find information about ACG's units. There's two types of units in ACG: Base units and historical units.
      </p>
      <h3>Base units</h3>
      <p class="text-align-justify">
        Air combat group is subdivided into {{ acg_units.length }} units, called base units or acg-units in the following.
        A base unit normally consists of up to about 16 members, and each base unit has it's own character and aspects. I.e.
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
