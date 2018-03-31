import resource from '.'

export default {
  getAll: () => {
    return resource.get('characters')
  },
  get: (character_id) => {
    return resource.get('character', character_id)
  }
}
