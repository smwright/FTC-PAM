import Vue from 'vue'
import VueRouter from 'vue-router'
import Frontpage from '@/components/Frontpage'
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
      component: Home,
      children: [
        {
          path: '',
          component: Frontpage
        },
        {
          path: 'campaign-statistics',
          name: 'CampaignStatistics',
          component: CampaignStatistics
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
