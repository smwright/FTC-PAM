import Vue from 'vue'
import VueRouter from 'vue-router'
import * as auth from '@/resource/auth.js'

import EmptySideNav from '@/components/EmptySideNav'
import MainSideNav from '@/components/MainSideNav'

//ACG Info
import ACGInfoIndex from '@/components/acg_info/ACGInfoIndex'
import ACGComms from '@/components/acg_info/ACGComms'
import ACGHistory from '@/components/acg_info/ACGHistory'
import ACGJoining from '@/components/acg_info/ACGJoining'
import ACGInfoSideNav from '../components/acg_info/ACGInfoSideNav'
import ACGStrucure from '../components/acg_info/ACGStructure'
import ACGUnits from '../components/acg_info/ACGUnits'
import ACGRanks from '../components/acg_info/ACGRanks'
import ACGCampaigns from '../components/acg_info/ACGCampaigns'
import ACGCampaignRules from '../components/acg_info/ACGCampaignRules'
import ACGCampaignProcedures from '../components/acg_info/ACGProcedures'
import ACGAfterActionReports from '../components/acg_info/ACGAfterActionReports'

//ACG Members
import MemberIndex from '../components/acg_member/MemberIndex'
import MemberInfoSideNav from '../components/acg_member/MemberInfoSideNav'
import MemberProfile from '../components/acg_member/MemberProfile'
import MemberGeneral from '../components/acg_member/MemberGeneralComp'
import MemberCharacters from '../components/acg_member/MemberCharactersComp'
import CharacterProfile from '../components/acg_member/CharacterProfile'

//ACG Unit
import UnitInfoSideNav from '../components/acg_unit/UnitInfoSideNav'
import UnitGeneral from '../components/acg_unit/UnitGeneralComp'
import ACGUnit from '../components/acg_unit/ACGUnit'

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
import CampaignMissionSynop from '../components/campaign/Synop'
import FateMap from '../components/campaign/SynopPilotFateMap'
import RecommendedReports from '../components/campaign/ReportRecommendations'

//Report submission
import ReportCharacterSelection from '../components/campaign/ReportCharacterSelection'

//Administration
import AdminIndex from '../components/admin/AdminIndex'
import AdminMainSideNav from '../components/admin/AdminMainSideNav'
import AdminUnitOverview from '../components/admin/UnitAdminOverview'
import AdminUnit from '../components/admin/UnitAdmin'
import AdminMember from '../components/admin/Member'
import AdminCampaign from '../components/admin/Campaign'
import AdminHistUnit from '../components/admin/HistUnits'
import Assets from '../components/admin/Assets'
import RosterAssets from '../components/admin/RosterAsset'


//Flight school components
import FlightSchoolSideNav from '@/components/FlightSchoolSideNav'
import FlightSchoolMain from '@/components/FlightSchoolMain'
import FlightSchoolFirstLesson from '@/components/FlightSchoolFirstLesson'
import FlightSchoolSecondLesson from '@/components/FlightSchoolSecondLesson'

//General components
import Home from '@/components/Home'
import QuickLinks from '@/components/QuickLinks'

Vue.use(VueRouter)

const router = new VueRouter({
  routes: [
    {
      path: '/',
      name: 'Home',
      components: {
        sidenav: QuickLinks,
        centercontent: Home,
        rightsidenav: EmptySideNav,
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
      path: '/structure/',
      name: 'ACGStructure',
      components: {
        centercontent: ACGStrucure,
        sidenav: ACGInfoSideNav,
        rightsidenav: EmptySideNav,
      }
    },
    {
      path: '/campaigns/',
      name: 'ACGCampaigns',
      components: {
        sidenav: ACGInfoSideNav,
        centercontent: ACGCampaigns,
        rightsidenav: EmptySideNav,
      }
    },
    {
      path: '/campaignrules/',
      name: 'ACGCampaignsRules',
      components: {
        sidenav: ACGInfoSideNav,
        centercontent: ACGCampaignRules,
        rightsidenav: EmptySideNav,
      }
    },
    {
      path: '/campaignprocedures/',
      name: 'ACGCampaignProcedures',
      components: {
        sidenav: ACGInfoSideNav,
        centercontent: ACGCampaignProcedures,
        rightsidenav: EmptySideNav,
      }
    },
    {
      path: '/campaignafteractionreports/',
      name: 'ACGAfterActionReports',
      components: {
        sidenav: ACGInfoSideNav,
        centercontent: ACGAfterActionReports,
        rightsidenav: EmptySideNav,
      }
    },
    {
      path: '/acg_units/',
      name: 'ACGRanks',
      components: {
        centercontent: ACGRanks,
        sidenav: ACGInfoSideNav,
        rightsidenav: EmptySideNav,
      }
    },
    {
      path: '/ranks/',
      name: 'ACGUnits',
      components: {
        centercontent: ACGUnits,
        sidenav: ACGInfoSideNav,
        rightsidenav: EmptySideNav,
      }
    },
    {
      path: '/communications/',
      name: 'ACGComms',
      components: {
        sidenav: ACGInfoSideNav,
        default: ACGComms,
      }
    },
    {
      path: '/joining/',
      name: 'ACGJoining',
      components: {
        sidenav: ACGInfoSideNav,
        default: ACGJoining,
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
    // Units
    // ---------------------------------------------------
    {
      path: '/units/',
      name: 'Units',
      components: {
        default: UnitGeneral,
        sidenav: UnitInfoSideNav
      }
    },
    {
      path: '/units/base/:unit_id',
      name: 'ACGUnitInfo',
      components: {
        default: ACGUnit,
        sidenav: UnitInfoSideNav,
        // children: [
        //   {
        //     path: 'general',
        //     name: 'UnitGeneral',
        //     components: {
        //       subcontent: MemberGeneral
        //     }
        //   },
        // ]
      },
    },
    {
      path: '/units/hist/:unit_id',
      name: 'HistUnitInfo',
      components: {
        default: UnitGeneral,
        sidenav: UnitInfoSideNav
      },
    },


    // ---------------------------------------------------
    // Campaign
    // ---------------------------------------------------
    {
      path: '/campaign-list',
      name: 'CampaignList',
      components: {
        default: CampaignList,
        sidenav: MainSideNav
      }
    },
    {
      path: '/recrep',
      name: 'RecommendedReports',
      components: {
        default: RecommendedReports,
        sidenav: MainSideNav
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
          name: 'CampaignUnits',
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
          path: 'recrepcamp',
          name: 'RecommendedReportsCampaign',
          components: {
            subcontent: RecommendedReports
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
                mission_lobby_content: CampaignMissionSynop
              }
            },
            {
              path: 'fatemap/:member_id/:flight_number',
              name: 'FateMap',
              components: {
                mission_lobby_content: FateMap
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
            },
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
      path: '/admin/unit/-1',
      name: 'UnitOverview',
      components: {
        default: AdminUnitOverview,
        sidenav: AdminMainSideNav
      },
      meta: {requiresAdmin: true},
    },
    {
      path: '/admin/unit/:unit_id',
      name: 'AdminUnit',
      components: {
        default: AdminUnit,
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
    {
      path: '/admin/rasset',
      name: 'RosterAsset',
      components: {
        default: RosterAssets,
        sidenav: AdminMainSideNav
      },
      meta: {requiresAdmin: true},
    },

    // Flight school routing
    {
      // Main entry of the flight school
      path: '/flight-school',
      name: 'FlightSchool',
      components: {
        default: FlightSchoolMain,
        sidenav: FlightSchoolSideNav
      },
      children: [
        {
          path: '/flight-school/first-lesson',
          name: 'FirstLesson',
          components: {
            lessoncontainer: FlightSchoolFirstLesson
          }
        },
        {
          path: '/flight-school/second-lesson',
          name: 'SecondLesson',
          components: {
            lessoncontainer: FlightSchoolSecondLesson
          }
        }
      ]
    },
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
