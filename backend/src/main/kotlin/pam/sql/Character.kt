package pam.sql

import javax.persistence.Entity
import javax.persistence.JoinColumn
import javax.persistence.ManyToOne
import javax.persistence.OneToMany

@Entity(name = "career_character")
data class Character(
    val firstName: String,
    val lastName: String,
    @ManyToOne
    @JoinColumn(name = "personified_by")
    val acgMember: AcgMember,
    @OneToMany(mappedBy = "character")
    val decorations: List<Decoration>
) : BaseEntity()