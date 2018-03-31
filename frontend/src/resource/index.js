import axios from 'axios'

import * as members from '../../mock_database/members.json'
import * as squadrons from '../../mock_database/squadrons.json'
import * as characters from '../../mock_database/characters.json'
import * as member_1 from '../../mock_database/member_1.json'
import * as character_4 from '../../mock_database/character_4.json'

let json_files = {
  members: members,
  squadrons: squadrons,
  characters: characters,
  member_1: member_1,
  character_4: character_4
}

export default {
  get: (ref, id) => {
    return new Promise((resolve, reject) => {
      if (id) ref = ref + '_' + id
      resolve(json_files[ref])
    })
  }
}
