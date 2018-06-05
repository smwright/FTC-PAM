package pam.services

import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.stereotype.Service
import pam.sql.comparators.MemberStateByDateComparator
import pam.format.AcgMemberListElement
import pam.repositories.AcgMemberRepository
import pam.sql.AcgMember
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
        joiningDate = getFirstOrLastFromList(acgMember.memberState, MemberStateByDateComparator(), false).date,
        lastStatusChanged = getFirstOrLastFromList(acgMember.memberState, MemberStateByDateComparator(), true).date,
        current_Status = getFirstOrLastFromList(acgMember.memberState, MemberStateByDateComparator(), true).state.name,
        rank = getFirstOrLastFromList(acgMember.promotions, PromotionByDateComparator(), true).rankValue
    )
  }

  fun <S, T : Comparator<S>> getFirstOrLastFromList(list: List<S>, comparator: T, last: Boolean): S {

    return if (last) {
      list.sortedWith(comparator).last()
    } else {
      list.sortedWith(comparator).first()
    }
  }
}