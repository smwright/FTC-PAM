
package pam.sql

import javax.persistence.*

@Entity
@Table(name = "rank")
data class Rank(
    val name: String,
    val abreviation: String,
    val value: Int,
    val faction: Int,
    val image: String
) : BaseEntity()

