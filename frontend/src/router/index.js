import Vue from 'vue'
import VueRouter from 'vue-router'
import * as auth from '@/resource/auth.js'

//About aCG
import EmptySideNav from '@/components/EmptySideNav'
import AboutUs from '@/components/AboutACGAboutUs'
import AboutACGSideNav from '@/components/AboutACGSideNav'
import Ranks from '@/components/AboutACGRanks'


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
import AdminCampaign from '../components/admin/Campaign'
import AdminHistUnit from '../components/admin/HistUnits'
import Assets from '../components/admin/Assets'


//Flight school components
import FlightSchoolSideNav from '@/components/FlightSchoolSideNav'
import FlightSchoolMain from '@/components/FlightSchoolMain'
import FlightSchoolFirstLesson from '@/components/FlightSchoolFirstLesson'
import FlightSchoolSecondLesson from '@/components/FlightSchoolSecondLesson'

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
      path: '/about-acg',
      name: 'AboutACG',
      redirect: {name: 'AboutUs'}
    },
    {
      path: '/about-acg/about-us',
      name: 'AboutUs',
      components: {
        default: AboutUs,
        sidenav: AboutACGSideNav
      }
    },
    {
      path: '/about-acg/ranks',
      name: 'Ranks',
      components: {
        default: Ranks,
        sidenav: AboutACGSideNav
      }
    },
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
      next('/')
    }
  }
  next()
})

export default router;
