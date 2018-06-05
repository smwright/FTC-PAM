package pam.sql

import com.fasterxml.jackson.annotation.JsonBackReference
import java.util.*
import javax.persistence.*

@Entity
@Table(name = "member_status_log")
data class MemberState(
    @Column(name = "member_status")
    val state: State,
    @Temporal(TemporalType.DATE)
    val date: Date,
    val comment: String,
    @ManyToOne
    @JoinColumn(name = "member_id")
    @JsonBackReference
    val acgMember: AcgMember
) : BaseEntity() {


  enum class State {
    ACTIVE,
    DISMISSED,
    RELIEVED_FROM_DUTY,
    GONE
  }
}