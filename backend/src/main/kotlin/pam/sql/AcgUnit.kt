package pam.sql

import javax.persistence.Entity

@Entity(name = "acg_unit")
data class AcgUnit(
    val permanent: Int
) : BaseEntity()