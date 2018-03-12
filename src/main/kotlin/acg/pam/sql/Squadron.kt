package acg.pam.sql

import javax.persistence.Entity
import javax.persistence.OneToMany

@Entity(name = "squadrons")
data class Squadron(
    val name: String,
    val code: String,
    val faction: String,
    val rank: Int,
    @OneToMany(mappedBy = "squadron")
    val commanders: List<Commander>,
    @OneToMany(mappedBy = "squadron")
    val transfers: List<Transfer>
) : BaseEntity()