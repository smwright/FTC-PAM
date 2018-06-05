package pam.sql

import com.fasterxml.jackson.annotation.JsonBackReference
import com.fasterxml.jackson.annotation.JsonManagedReference
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
    @JsonBackReference
    val acgMember: AcgMember,
    @OneToMany(mappedBy = "character")
    @JsonManagedReference
    val decorations: List<Decoration>
) : BaseEntity()