import Vue from 'vue'
import VueRouter from 'vue-router'

//About aCG
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

import CampaignEditor from '@/components/CampaignEditor'


//Flight school components
import FlightSchoolSideNav from '@/components/FlightSchoolSideNav'
import FlightSchoolMain from '@/components/FlightSchoolMain'
import FlightSchoolFirstLesson from '@/components/FlightSchoolFirstLesson'
import FlightSchoolSecondLesson from '@/components/FlightSchoolSecondLesson'

import Home from '@/components/Home'


Vue.use(VueRouter)

export default new VueRouter({
  routes: [
    {
      path: '/',
      name: 'Home',
      component: Home
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
      component: CampaignList
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
            }
          ]
        },
      ],
    },
    {
      path: '/campaign-editor',
      name: 'CampaignEditor',
      component: CampaignEditor
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
