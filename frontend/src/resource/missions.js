import resource from '.'

export default {
  get: (mission_id) => {
    return resource.get('missionsCampaign', mission_id)
  }
}