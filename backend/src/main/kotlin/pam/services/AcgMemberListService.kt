package pam.services

import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.stereotype.Service
import pam.sql.comparators.MemberStateByDateComparator
import pam.format.AcgMemberListElement
import pam.repositories.AcgMemberRepository
import pam.repositories.CampaignRepository
import pam.sql.AcgMember
import pam.sql.Mission
import pam.sql.comparators.PromotionByDateComparator

@Service
class AcgMemberListService(
    val acgMemberRepository: AcgMemberRepository,
    val campaignRepository: CampaignRepository
) {

  fun createAcgMemberListElement(page: Pageable): Page<AcgMemberListElement> {
    val members = acgMemberRepository.findAll(page)

    return members.map {
      toListElement(it)
    }
  }


  fun toListElement(acgMember: AcgMember): AcgMemberListElement {
    return AcgMemberListElement(
        id = acgMember.id,
        callSign = acgMember.callsign,
        joiningDate = getFirstOrLastFromList(acgMember.memberState, MemberStateByDateComparator(), false).date,
        lastStatusChanged = getFirstOrLastFromList(acgMember.memberState, MemberStateByDateComparator(), true).date,
        state = getFirstOrLastFromList(acgMember.memberState, MemberStateByDateComparator(), true).state,
        rank = getFirstOrLastFromList(acgMember.promotions, PromotionByDateComparator(), true).rankValue,
        campaignStats = mapCampaignStats(acgMember)
    )
  }

  fun mapCampaignStats(acgMember: AcgMember): List<AcgMemberListElement.MemberListCampaignElement> {

    val campaigns = campaignRepository.findAll()

    return campaigns.mapNotNull {

      val participatedIn = it.missions.filter {
        participated(it, acgMember)
      }.size

      if (participatedIn > 0) {
        return@mapNotNull AcgMemberListElement.MemberListCampaignElement(
            id = it.id,
            name = it.name,
            flownSorties = participatedIn
        )
      } else {
        return@mapNotNull null
      }
    }
  }

  private fun participated(mission: Mission, acgMember: AcgMember): Boolean {

    return acgMember.characters.find {
      it.reports.find {
        it.mission == mission
      } != null
    } != null
  }

  fun <S, T : Comparator<S>> getFirstOrLastFromList(list: List<S>, comparator: T, last: Boolean): S {

    return if (last) {
      list.sortedWith(comparator).last()
    } else {
      list.sortedWith(comparator).first()
    }
  }
}