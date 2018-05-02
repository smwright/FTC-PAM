package acg.pam.sql

import java.util.*
import javax.persistence.*

@Entity
@Table(name = "memberstatuslog")
data class MemberStatus(
    @ManyToOne
    @JoinColumn(name = "member_id")
    val acgMember: AcgMember,
    val status: Status,
    @Temporal(TemporalType.DATE)
    val date: Date,
    val comment: String
) : BaseEntity() {

  enum class Status {
    UNKNOWN,
    ACTIVE,
    DISMISSED,
    RELIEVED_FROM_DUTY,
    GONE
  }
}