<template>
  <div>
    <h3>
      Editing assets:
    </h3>
    <p>
      Use the tree on the left to organize ACG assets. Assets can be dragged and dropped to form groups. Click on the
      name of each asset to edit the asset details. Each asset can be given a name and faction. Each asset can be marked as
      controllable, which means it will be available as the pilots aircraft in the After Action Reports. Each asset can
      be marked as claimable, which means it will be available as a claimed aircraft in the After Action Reports.
    </p>

    <p>
      <b>The available factions are:</b>
    </p>

    <ul>
      <li v-for="(faction, index) in factionStatus">
        <template v-if="index == 0">
          Neutral / No faction
        </template>
        <template v-else>
          {{ faction.long }}
        </template>
      </li>
    </ul>

    <p>
      <b>Adding assets:</b>
      Use the button on top of the page to add an asset.
    </p>

    <p>
      <b>Fetch data:</b>
      Use this button to reload the assets from the database. All changes will be lost.
    </p>

    <p>
      <b>Deleting assets:</b>
      Assets or assets-groups can be deleted by using the corresponding button. When an asset-group is deleted, all
      assets in that group will be moved into the parent group.
    </p>

    <p>
      <b>Save changes:</b>
      Use this button to save the changes and send them to the database. Deleted assets or asset-groups are still stored
      in the database until the changes are send to the database.
    </p>
  </div>
</template>

<script>
import statConv from "../../resource/statusConverter"

export default {
  name: "AssetEditInstructions",
  mixins: [statConv],
}
</script>

<style scoped>

</style>
