package pam.sql

import javax.persistence.Entity
import javax.persistence.JoinColumn
import javax.persistence.OneToOne

@Entity
data class Briefing(
    @OneToOne
    @JoinColumn(name = "mission_id")
    val mission: Mission,
    val faction: Faction,
    val text: String
) : BaseEntity()