package acg.pam.sql

import javax.persistence.Entity
import javax.persistence.OneToMany
import javax.persistence.Table

@Entity
@Table(name = "squadrons")
data class Squadron(
    val name: String,
    val code: String,
    val faction: String,
    @OneToMany(mappedBy = "squadron")
    val transfers: List<Transfer>
) : BaseEntity()