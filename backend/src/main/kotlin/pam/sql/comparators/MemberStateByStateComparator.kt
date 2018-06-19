package pam.sql.comparators

import pam.sql.MemberState

class MemberStateByStateComparator : Comparator<MemberState> {

  override fun compare(p0: MemberState, p1: MemberState): Int {
    return p0.state.compareTo(p1.state)
  }
}