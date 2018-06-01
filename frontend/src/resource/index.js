
// Members
import * as members from '../../mock_database/members.json'
import * as members_c_info from '../../mock_database/members_c_info.json'
import * as members_c_info_1 from '../../mock_database/members_c_info_1.json'
import * as members_c_info_2 from '../../mock_database/members_c_info_2.json'
import * as members_c_info_3 from '../../mock_database/members_c_info_3.json'

import * as campaign_2 from '../../mock_database/campaign_2.json'
import * as campaign_4 from '../../mock_database/campaign_4.json'
import * as campaign_6 from '../../mock_database/campaign_6.json'
import * as campaigns from '../../mock_database/campaigns.json'
import * as missionsCampaign_4 from '../../mock_database/missions_campaign_4.json'
import * as missionsCampaign_6 from '../../mock_database/missions_campaign_6.json'

import * as squadrons from '../../mock_database/squadrons.json'
import * as characters from '../../mock_database/characters.json'
import * as member_1 from '../../mock_database/member_1.json'
import * as character_4 from '../../mock_database/character_4.json'

let json_files = {
  members: members,
  members_c_info: members_c_info,
  members_c_info_1: members_c_info_1,
  members_c_info_2: members_c_info_2,
  members_c_info_3: members_c_info_3,
  campaign_2: campaign_2,
  campaign_4: campaign_4,
  campaign_6: campaign_6,
  campaigns: campaigns,
  missionsCampaign_4: missionsCampaign_4,
  missionsCampaign_6: missionsCampaign_6,
  squadrons: squadrons,
  characters: characters,
  member_1: member_1,
  character_4: character_4
}

export default {

  getByName: (name, verbose) => {

    return new Promise((resolve, reject) => {
      if(verbose){
        console.log("MockCom returning: "+name);
      }
      resolve(json_files[name]);
    })
  }

}
