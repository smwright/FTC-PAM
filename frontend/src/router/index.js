import Vue from 'vue'
import VueRouter from 'vue-router'
import * as auth from '@/resource/auth.js'

import EmptySideNav from '@/components/EmptySideNav'

//ACG Info
import ACGInfoIndex from '@/components/acg_info/ACGInfoIndex'
import ACGComms from '@/components/acg_info/ACGComms'
import ACGHistory from '@/components/acg_info/ACGHistory'
import ACGJoining from '@/components/acg_info/ACGJoining'
import ACGRanks from '@/components/acg_info/ACGRanks'
import ACGInfoSideNav from '../components/acg_info/ACGInfoSideNav'

//ACG Members
import MemberIndex from '../components/acg_member/MemberIndex'
import MemberInfoSideNav from '../components/acg_member/MemberInfoSideNav'
import MemberProfile from '../components/acg_member/MemberProfile'
import MemberGeneral from '../components/acg_member/MemberGeneralComp'
import MemberCharacters from '../components/acg_member/MemberCharactersComp'
import CharacterProfile from '../components/acg_member/CharacterProfile'

//Campaign
import CampaignList from '../components/campaign/CampaignList'
import CampaignInfoMain from '../components/campaign/CampaignInfoMain'
import CampaignInfoMission from '../components/campaign/Mission'
import CampaignInfoMissionLobby from '../components/campaign/MissionLobby'
import CampaignInfoMissionBriefing from '../components/campaign/Briefing'
import CampaignInfoUnits from '../components/campaign/Unit'
import CampaignInfoSideNav from '../components/campaign/SideNav'
import CampaignInfoMissionUnitsSideNav from '../components/campaign/MissionUnitSideNav'
import Report from '../components/campaign/Report'

//Report submission
import ReportCharacterSelection from '../components/campaign/ReportCharacterSelection'

//Administration
import AdminIndex from '../components/admin/AdminIndex'
import AdminMainSideNav from '../components/admin/AdminMainSideNav'
import AdminMember from '../components/admin/Member'
import AdminCampaign from '../components/admin/Campaign'
import AdminHistUnit from '../components/admin/HistUnits'
import Assets from '../components/admin/Assets'


//Flight school components
import FlightSchoolSideNav from '@/components/flight_school/FlightSchoolSideNav'
import FlightSchoolMain from '@/components/flight_school/FlightSchoolMain'
import FlightSchoolRAF from '@/components/flight_school/FlightSchoolRAF'
import FlightSchoolRAFVocabulary from '@/components/flight_school/FlightSchoolRAFVocabulary'
import FlightSchoolRAFRanks from '@/components/flight_school/FlightSchoolRAFRanks'
import FlightSchoolRAFAlphabet from '@/components/flight_school/FlightSchoolRAFAlphabet'
import FlightSchoolRAFOrganisation from '@/components/flight_school/FlightSchoolRAFOrganisation'
import FlightSchoolLW from '@/components/flight_school/FlightSchoolLW'
import FlightSchoolVVS from '@/components/flight_school/FlightSchoolVVS'
import FlightSchoolUSAAF from '@/components/flight_school/FlightSchoolUSAAF'
import FlightSchoolRAI from '@/components/flight_school/FlightSchoolRAI'
import FlightSchoolBasicNavigation from '@/components/flight_school/FlightSchoolBasicNavigation'
import FlightSchoolAdvancedNavigation from '@/components/flight_school/FlightSchoolAdvancedNavigation'


import Home from '@/components/Home'


Vue.use(VueRouter)

const router = new VueRouter({
  routes: [
    {
      path: '/',
      name: 'Home',
      components: {
        fullmain: Home,
      }
    },
    {
      path: '/about-acg/',
      name: 'AboutACG',
      components: {
        default: ACGInfoIndex,
        sidenav: ACGInfoSideNav
      }

    },
    {
      path: '/history/',
      name: 'ACGHistory',
      components: {
        default: ACGHistory,
        sidenav: ACGInfoSideNav
      }
    },

    {
      path: '/ranks/',
      name: 'ACGRanks',
      components: {
        default: ACGRanks,
        sidenav: ACGInfoSideNav
      }
    },

    {
      path: '/communications/',
      name: 'ACGComms',
      components: {
        fullmain: ACGComms,
      }
    },
    {
      path: '/joining/',
      name: 'ACGJoining',
      components: {
        fullmain: ACGJoining,
      }
    },

    // ---------------------------------------------------
    // Members
    // ---------------------------------------------------
    {
      path: '/members/',
      name: 'Members',
      components: {
        default: MemberIndex,
        sidenav: MemberInfoSideNav
      },
    },
    {
      path: '/members/:member_id',
      name: 'AboutACGMember',
      components: {
        default: MemberProfile,
        sidenav: MemberInfoSideNav
      },
      children: [
        {
          path: 'general',
          name: 'MemberGeneral',
          components: {
            subcontent: MemberGeneral
          }
        },
        {
          path: 'characters',
          name: 'MemberCharacters',
          components: {
            subcontent: MemberCharacters
          }
        },
        {
          path: 'characters/:character_id',
          name: 'CharacterGeneral',
          components: {
            subcontent: CharacterProfile
          }
        },
      ]
    },

    // ---------------------------------------------------
    // Campaign
    // ---------------------------------------------------
    {
      path: '/campaign-list',
      name: 'CampaignList',
      components: {
        default: CampaignList,
        sidenav: EmptySideNav
      }
    },
    {
      path: '/campaign-info/:campaign_id',
      name: 'Campaign',
      components: {
        default: CampaignInfoMain,
        sidenav: CampaignInfoSideNav
      },
      children: [
        {
          path: 'units',
          name: 'Units',
          components: {
            subcontent: CampaignInfoUnits
          }
        },
        {
          path: 'missions',
          name: 'Missions',
          components: {
            subcontent: CampaignInfoMission
          },
        },
        {
          path: 'missions/:mission_id',
          name: 'MissionInfo',
          components: {
            subcontent: CampaignInfoMissionLobby,
            sideview_units: CampaignInfoMissionUnitsSideNav
          },
          children: [
            {
              path: 'briefing/:briefing_faction',
              name: 'Briefing',
              components: {
                mission_lobby_content: CampaignInfoMissionBriefing
              }
            },
            {
              path: 'synop/:depl_unit_id',
              name: 'MissionSynop',
              components: {
                mission_lobby_content: CampaignInfoMissionBriefing
              }
            },
            {
              path: 'report/:report_id',
              name: 'Report',
              components: {
                mission_lobby_content: Report
              }
            },
            {
              path: 'addReport/',
              name: 'AddReport',
              components: {
                mission_lobby_content: ReportCharacterSelection
              }
            }
          ]
        },
      ],
    },
    // Administration
    {
      path: '/admin',
      name: 'Admin',
      components: {
        default: AdminIndex,
        sidenav: AdminMainSideNav
      },
      meta: {requiresAdmin: true},
    },
    {
      path: '/admin/member/:member_id',
      name: 'AdminMember',
      components: {
        default: AdminMember,
        sidenav: AdminMainSideNav
      },
      meta: {requiresAdmin: true},
    },
    {
      path: '/admin/campaign/:campaign_id',
      name: 'AdminCampaign',
      components: {
        default: AdminCampaign,
        sidenav: AdminMainSideNav
      },
      meta: {requiresAdmin: true},
    },
    {
      path: '/admin/hist-unit',
      name: 'AdminHistUnit',
      components: {
        default: AdminHistUnit,
        sidenav: AdminMainSideNav
      },
      meta: {requiresAdmin: true},
    },
    {
      path: '/admin/asset',
      name: 'Asset',
      components: {
        default: Assets,
        sidenav: AdminMainSideNav
      },
      meta: {requiresAdmin: true},
    },
    // Flight school routing
    {
      // Main entry of the flight school
      path: '/flight-school',
      name: 'FlightSchoolMain',
      components: {
        default: FlightSchoolMain,
        sidenav: FlightSchoolSideNav
      }
    },
        {
          path: '/flight-school/basic-navigation',
          name: 'FlightSchoolBasicNavigation',
          components: {
            default: FlightSchoolBasicNavigation,
            sidenav: FlightSchoolSideNav
          }
        },
        {
          path: '/flight-school/advanced-navigation',
          name: 'FlightSchoolAdvancedNavigation',
          components: {
            default: FlightSchoolAdvancedNavigation,
            sidenav: FlightSchoolSideNav
          }
        },
    {
      path: '/flight-school/royal-air-force',
      name: 'FlightSchoolRAF',
      components: {
        default: FlightSchoolRAF,
        sidenav: FlightSchoolSideNav
          }
        },
    {
      path: '/flight-school/royal-air-force/wartime-vocabulary',
      name: 'FlightSchoolRAFVocabulary',
      components: {
        default: FlightSchoolRAFVocabulary,
        sidenav: FlightSchoolSideNav
      }
    },
    {
      path: '/flight-school/royal-air-force/phonetic-alphabet',
      name: 'FlightSchoolRAFAlphabet',
      components: {
        default: FlightSchoolRAFAlphabet,
        sidenav: FlightSchoolSideNav
      }
    },
    {
      path: '/flight-school/royal-air-force/ranks',
      name: 'FlightSchoolRAFRanks',
      components: {
        default: FlightSchoolRAFRanks,
        sidenav: FlightSchoolSideNav
      }
    },
    {
      path: '/flight-school/royal-air-force/organisation',
      name: 'FlightSchoolRAFOrganisation',
      components: {
        default: FlightSchoolRAFOrganisation,
        sidenav: FlightSchoolSideNav
      }
    },

        {
          path: '/flight-school/luftwaffe',
          name: 'FlightSchoolLW',
          components: {
            default: FlightSchoolLW,
            sidenav: FlightSchoolSideNav
          }
        },
        {
          path: '/flight-school/soviet-air-forces',
          name: 'FlightSchoolVVS',
          components: {
            default: FlightSchoolVVS,
            sidenav: FlightSchoolSideNav
          }
        },
        {
          path: '/flight-school/united-states-army-air-force',
          name: 'FlightSchoolUSAAF',
          components: {
            default: FlightSchoolUSAAF,
            sidenav: FlightSchoolSideNav
          }
        },
        {
          path: '/flight-school/regia-aeronautica-italiana',
          name: 'FlightSchoolRAI',
          components: {
            default: FlightSchoolRAI,
            sidenav: FlightSchoolSideNav
          }
        }
  ]
})

router.beforeEach( async (to, from, next) => {
  if(to.matched.some(record => record.meta.requiresAdmin)) {

    // var vue_inst = this.a.app;
    var isAdmin = await Vue.prototype.$auth.isAdmin(this.name);
    console.log("Route requires admin rights: " + from.name + " -> " + to.name);
    console.log("Permission granted: " + isAdmin);
    if(isAdmin){
      next();
    } else {
      next(false)
    }
  } else {
    next()
  }
})

export default router;
