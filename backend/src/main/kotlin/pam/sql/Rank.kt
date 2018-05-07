package pam.sql

import javax.persistence.Entity
import javax.persistence.Table

@Entity
@Table(name = "ranks")
data class Rank(
    val name: String,
    val abreviation: String,
    val level: Int,
    val faction: String,
    val image: String
) : BaseEntity()