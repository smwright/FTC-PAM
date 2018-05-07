package pam.sql

import javax.persistence.Entity
import javax.persistence.JoinColumn
import javax.persistence.ManyToOne
import javax.persistence.OneToMany

@Entity(name = "careercharacters")
data class Character(
    val firstName: String,
    val lastName: String,
    val characterStatus: Status,
    @ManyToOne
    @JoinColumn(name = "member_id")
    val acgMember: AcgMember,
    @OneToMany(mappedBy = "character")
    val decorations: List<Decoration>
) : BaseEntity() {

  enum class Status {
    SHORE_LEAVE,
    WOUNDED,
    OK,
    POW,
    KIA
  }
}