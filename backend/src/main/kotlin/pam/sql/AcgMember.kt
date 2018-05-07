package pam.sql

import java.time.Instant
import java.util.*
import javax.persistence.*

@Entity
@Table(name = "acgmembers")
data class AcgMember(
    val username: String,
    val callsign: String,
    @Temporal(TemporalType.DATE)
    var joiningDate: Date = Date.from(Instant.MIN),
    @Temporal(TemporalType.DATE)
    var dischargeDate: Date?,
    val status: Status,
    val admin: Boolean,
    val mapViewer: Boolean,
    val missionBuilder: Boolean,
    @OneToMany(mappedBy = "acgMember")
    val transfers: List<Transfer>,
    @OneToMany(mappedBy = "acgMember")
    val characters: List<Character>,
    @OneToMany(mappedBy = "acgMember")
    val promotions: List<Promotion>,
    @OneToMany(mappedBy = "acgMember")
    val memberStatuses: List<MemberStatus>
) : BaseEntity() {

  enum class Status {
    UNKNOWN,
    ACTIVE,
    DISMISSED
  }
}