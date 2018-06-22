package pam.format.comparators

import pam.format.AcgMemberListElement

interface AcgMemberListElementComparator : Comparator<AcgMemberListElement> {

    class ById : AcgMemberListElementComparator {

        override fun compare(p0: AcgMemberListElement, p1: AcgMemberListElement) = p0.id.compareTo(p1.id)
    }

    class ByRank : AcgMemberListElementComparator {

        override fun compare(p0: AcgMemberListElement, p1: AcgMemberListElement) = p0.rank.compareTo(p1.rank)
    }

    class ByCallSign : AcgMemberListElementComparator {

        override fun compare(p0: AcgMemberListElement, p1: AcgMemberListElement) = p0.callSign.compareTo(p1.callSign)
    }

    class ByJoiningDate : AcgMemberListElementComparator {

        override fun compare(p0: AcgMemberListElement, p1: AcgMemberListElement) = p0.joiningDate.compareTo(p1.joiningDate)
    }

    class ByLastStatusChanged : AcgMemberListElementComparator {

        override fun compare(p0: AcgMemberListElement, p1: AcgMemberListElement) = p0.lastStatusChanged.compareTo(p1.lastStatusChanged)
    }

    class ByState : AcgMemberListElementComparator {

        override fun compare(p0: AcgMemberListElement, p1: AcgMemberListElement) = p0.state.compareTo(p1.state)
    }

    class Chained(
            private val list: List<Comparator<AcgMemberListElement>>
    ) : AcgMemberListElementComparator {


        override fun compare(p0: AcgMemberListElement, p1: AcgMemberListElement): Int {
            val comparator = list.first()

            list.subList(1, list.size - 1).forEach {
                comparator.thenComparing(it)
            }

            return comparator.compare(p0, p1)
        }

    }

}
