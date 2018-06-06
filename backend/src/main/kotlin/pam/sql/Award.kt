package pam.sql

import javax.persistence.Entity
import javax.persistence.Table

@Entity
data class Award(
    val name: String,
    val abreviation: String,
    val image: String,
    val faction: String
) : BaseEntity()