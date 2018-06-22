package pam.services

import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import org.springframework.stereotype.Service
import pam.sql.comparators.MemberStateByDateComparator
import pam.format.AcgMemberListElement
import pam.format.comparators.AcgMemberListElementComparator
import pam.repositories.AcgMemberRepository
import pam.repositories.CampaignRepository
import pam.sql.AcgMember
import pam.sql.Mission
import pam.sql.comparators.PromotionByDateComparator
import pam.util.Sort

@Service
class AcgMemberService(
        val acgMemberRepository: AcgMemberRepository,
        val campaignRepository: CampaignRepository
) {

    fun createAcgMemberListElement(page: Pageable, sort: List<Sort>?): Page<AcgMemberListElement> {
        val members = acgMemberRepository.findAll(page)

        val converted = members.map {
            toListElement(it)
        }

        val list = sort?.let {
            it.map {
                when (it.name) {
                    "id" -> comparatorSortDirection(AcgMemberListElementComparator.ById(), it)
                    "rank" -> comparatorSortDirection(AcgMemberListElementComparator.ByRank(), it)
                    "name" -> comparatorSortDirection(AcgMemberListElementComparator.ByCallSign(), it)
                    "by_joining_date" -> comparatorSortDirection(AcgMemberListElementComparator.ByJoiningDate(), it)
                    "by_last_status_changed" -> comparatorSortDirection(AcgMemberListElementComparator.ByLastStatusChanged(), it)
                    "by_state" -> comparatorSortDirection(AcgMemberListElementComparator.ByState(), it)
                    else -> {
                        throw IllegalArgumentException("Please Enter a correct field")
                    }
                }
            }
        }

        list?.let {
            converted.sortedWith(
                    AcgMemberListElementComparator.Chained(list)
            )
        }

        return converted
    }

    private fun comparatorSortDirection(comparator: AcgMemberListElementComparator, it: Sort): Comparator<AcgMemberListElement> {
        return it.direction?.let {
            if (it == Sort.Direction.ASC) {
                comparator
            } else {
                comparator.reversed()
            }
        } ?: comparator
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
            }

            if (participatedIn.isNotEmpty()) {
                return@mapNotNull AcgMemberListElement.MemberListCampaignElement(
                        id = it.id,
                        name = it.name,
                        flownSorties = participatedIn.size
                )
            } else {
                return@mapNotNull null
            }
        }
    }

    private fun participated(mission: Mission, acgMember: AcgMember): Boolean {
        var count = 0

        acgMember.characters.forEach {
            it.reports.forEach {
                if (it.mission.id == mission.id) {
                    count++
                }
            }
        }
        return count != 0
    }

    fun <S, T : Comparator<S>> getFirstOrLastFromList(list: List<S>, comparator: T, last: Boolean): S {

        return if (last) {
            list.sortedWith(comparator).last()
        } else {
            list.sortedWith(comparator).first()
        }
    }
}