package pam.sql

import java.util.*
import javax.persistence.*

@Entity
@Table(name = "member_status_log")
data class  MemberState(
    @ManyToOne
    @JoinColumn(name = "member_id")
    val acgMember: AcgMember,
    @Column(name = "member_status")
    val state: State,
    @Temporal(TemporalType.DATE)
    val date: Date,
    val comment: String
) : BaseEntity() {

  enum class State {
    ACTIVE,
    DISMISSED,
    RELIEVED_FROM_DUTY,
    GONE
  }
}