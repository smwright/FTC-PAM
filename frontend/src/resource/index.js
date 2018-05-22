import axios from 'axios'

import * as campaign_2 from '../../mock_database/campaign_2.json'
import * as campaign_4 from '../../mock_database/campaign_4.json'
import * as campaign_6 from '../../mock_database/campaign_6.json'
import * as campaigns from '../../mock_database/campaigns.json'
import * as missionsCampaign_4 from '../../mock_database/missions_campaign_4.json'
import * as missionsCampaign_6 from '../../mock_database/missions_campaign_6.json'
import * as members from '../../mock_database/members.json'
import * as squadrons from '../../mock_database/squadrons.json'
import * as characters from '../../mock_database/characters.json'
import * as member_1 from '../../mock_database/member_1.json'
import * as character_4 from '../../mock_database/character_4.json'

let json_files = {
  campaign_2: campaign_2,
  campaign_4: campaign_4,
  campaign_6: campaign_6,
  campaigns: campaigns,
  missionsCampaign_4: missionsCampaign_4,
  missionsCampaign_6: missionsCampaign_6,
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
