package pam.sql

import javax.persistence.Entity

@Entity
data class Namepool(
        val name: String,
        val type: String,
        val faction: Faction
) : BaseEntity()