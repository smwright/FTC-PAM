package pam.services

import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.stereotype.Service
import pam.sql.comparators.MemberStateByDateComparator
import pam.format.AcgMemberListElement
import pam.repositories.AcgMemberRepository
import pam.sql.AcgMember
import pam.sql.MemberState
import pam.sql.Promotion
import pam.sql.comparators.PromotionByDateComparator

@Service
class AcgMemberService(
    val acgMemberRepository: AcgMemberRepository
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
        name = acgMember.callsign,
        joiningDate = getFirstOrLastStatus(acgMember.memberState, false).date,
        lastStatusChanged = getFirstOrLastStatus(acgMember.memberState, true).date,
        current_Status = getFirstOrLastStatus(acgMember.memberState, true).state.name,
        rank = getFirstOrLastPromotion(acgMember.promotions, true).rankValue
    )

  }

  fun getFirstOrLastPromotion(promotions: List<Promotion>, last: Boolean): Promotion {
    return if (last) {
      promotions.sortedWith(PromotionByDateComparator()).last()
    } else {
      promotions.sortedWith(PromotionByDateComparator()).first()
    }

  }

  fun getFirstOrLastStatus(memberStates: List<MemberState>, last: Boolean): MemberState {

    return if (last) {
      memberStates.sortedWith(MemberStateByDateComparator())
          .last()
    } else {
      memberStates.sortedWith(MemberStateByDateComparator()).first()
    }
  }
}