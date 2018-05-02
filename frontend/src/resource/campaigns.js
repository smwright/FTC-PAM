import resource from '.'

export default {
  get: (campaign_id) => {
    return resource.get('campaign', campaign_id)
  },
  getAll: () => {
    return resource.get('campaigns')
  }
}