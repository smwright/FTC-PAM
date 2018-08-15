
function memberStatus(id) {
  switch (id) {
    case 0:
      return "Active";
    case 1:
      return "Dismissed";
    case 2:
      return "Relieved from duty";
    case 3:
      return "Passed away";
    default:
      return id;
  }
}

function platform(id) {
  switch (id) {
    case 0:
      return "IL-2 Cliffs of Dover";
    case 1:
      return "IL-2 Battle of Moscow";
    case 2:
      return "IL-2 Battle of Stalingrad";
    case 3:
      return "IL-2 Battle of Kuban";
    case 4:
      return "Rise of flight";
    default:
      return id;
  }

}

function campaignStatus(id) {
  switch (id) {
    case 0:
      return "In preparation";
    case 1:
      return "Ongoing";
    case 2:
      return "Finished";
    default:
      return id;
  }
}

export {
  memberStatus,
  platform,
  campaignStatus
}
