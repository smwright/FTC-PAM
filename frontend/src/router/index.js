import Vue from 'vue'
import VueRouter from 'vue-router'
import Frontpage from '@/components/Frontpage'
import CampaignList from '@/components/CampaignList'
import CampaignInfoMain from '@/components/CampaignInfoMain'
import CampaignInfoMissions from '@/components/CampaignInfoMissions'
import CampaignInfoUnits from '@/components/CampaignInfoUnits'
import CampaignInfoSideNav from '@/components/CampaignInfoSideNav'
import CampaignEditor from '@/components/CampaignEditor'

//Flight school components
import FlightSchoolSideNav from '@/components/FlightSchoolSideNav'
import FlightSchoolMain from '@/components/FlightSchoolMain'
import FlightSchoolFirstLesson from '@/components/FlightSchoolFirstLesson'
import FlightSchoolSecondLesson from '@/components/FlightSchoolSecondLesson'

import Members from '@/components/Members'
import Missions from '@/components/Missions'
import Admin from '@/components/Admin'
import SquadronCommand from '@/components/SquadronCommand'
import CampaignStatistics from '@/components/CampaignStatistics'
import Home from '@/components/Home'
import MembersList from '@/components/MembersList'
import Member from '@/components/Member'
import CharactersList from '@/components/CharactersList'
import Character from '@/components/Character'

Vue.use(VueRouter)

export default new VueRouter({
  routes: [
    {
      path: '/',
      name: 'Home',
      component: Home
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
          path: '/campaign-info/units/:campaign_id',
          name: 'Units',
          components: {
            subcontent: CampaignInfoUnits
          }
        },
        {
          path: '/campaign-info/missions/:campaign_id',
          name: 'Missions',
          components: {
            subcontent: CampaignInfoMissions
          }
        }
      ]
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
    {
      path: '/members',
      name: 'Members',
      component: Members,
      children: [
        {
          path: '',
          name: 'Members',
          redirect: 'members-list'
        },
        {
          path: 'members-list',
          name: 'MembersList',
          component: MembersList
        },
        {
          path: 'members-list/:squadron',
          name: 'MembersListSqn',
          component: MembersList
        },
        {
          path: 'characters-list',
          name: 'AllCharacters',
          component: CharactersList
        },
        {
          path: 'member/:member_id',
          name: 'Member',
          component: Member
        },
        {
          path: 'character/:character_id',
          name: 'Character',
          component: Character
        }

      ]
    },
    {
      path: '/missions',
      name: 'Missions',
      component: Missions
    },
    {
      path: '/admin',
      name: 'Admin',
      component: Admin
    },
    {
      path: '/sqncmd',
      name: 'SquadronCommand',
      component: SquadronCommand
    }
  ]
})
