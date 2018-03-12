package acg.pam.sql

import javax.persistence.Entity
import javax.persistence.JoinColumn
import javax.persistence.ManyToOne

@Entity(name = "careercharacters")
data class Character(
    val firstName: String,
    val lastName: String,
    val characterStatus: Int,
    @ManyToOne
    @JoinColumn(name = "personifiedBy")
    val acgMember: AcgMember
) : BaseEntity()