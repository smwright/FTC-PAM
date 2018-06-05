package pam.sql.comparators

import pam.sql.Promotion

class PromotionByDateComparator : Comparator<Promotion> {

  override fun compare(p0: Promotion, p1: Promotion): Int {
    return p0.date.compareTo(p1.date)
  }
}