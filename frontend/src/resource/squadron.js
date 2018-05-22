import resource from '.'

export default {
  getAll: () => {
    return resource.get('squadrons')
  }
}
