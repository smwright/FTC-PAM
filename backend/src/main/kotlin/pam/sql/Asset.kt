package pam.sql

import javax.persistence.Column
import javax.persistence.Entity

@Entity
data class Asset(
    val name : String,
    val faction: Faction,
    @Column(name = "controlable")
    val controllable : Boolean,
    val lft : Int,
    val rgt : Int
    ) : BaseEntity()