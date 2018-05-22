import resource from '.'

export default {
  get: (member_id) => {
    return resource.get('member', member_id)
  },
  getAll: () => {
    return resource.get('members')
  }
}
