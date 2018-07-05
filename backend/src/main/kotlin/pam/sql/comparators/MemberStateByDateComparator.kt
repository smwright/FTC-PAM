package pam.sql.comparators

import pam.sql.MemberState


class MemberStateByDateComparator : Comparator<MemberState> {

  override fun compare(p0: MemberState, p1: MemberState): Int {
    return p0.date.compareTo(p1.date)
  }
}