<template>
  <div>
    <p>Use this pages to administer ACG members, units and campaigns.</p>

    <div>
      <h3>Members</h3>
      <p>Add or edit members</p>
    </div>
    <div>
      <h3>Campaigns</h3>
      <p>Create or edit campaigns</p>
    </div>
    <div>
      <h3>Historical units</h3>
      <p>The units represented in the various campaigns.</p>
    </div>
    <div>
      <h3>Assets</h3>
      <p>
        Assets include all objects that are used in campaigns. This includes assets, mostly aircraft, that can be selected
        in after action reports, both as piloted by the members as well as for claiming victories, additionally all types
        of ground targets for ground victories. Here you can create, edit, delete and arrange the various assets.</p>
    </div>
    <div>
      <h3>Roster Assets</h3>
      <p>
        Individual assets can be created and edited here. Roster assets are individual entities of a particular asset type
        as defined in assets, i.e. a particular aircraft. As the name suggests, the roster assets can be assigned to ACG
        members, one asset per member per unit per campaign, and will show up on the roster pages for the member.
      </p>
    </div>
  </div>

</template>

<script>

export default {
  name: "AdminIndex",
}
</script>

<style scoped>

</style>
