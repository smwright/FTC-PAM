package pam.sql

import java.time.Instant
import java.util.*
import javax.persistence.*

@Entity
@Table(name = "acg_member")
data class AcgMember(
    val username: String,
    val callsign: String,
    val admin: Boolean,
    val mapViewer: Boolean,
    val missionBuilder: Boolean
) : BaseEntity() {

  enum class Status {
    UNKNOWN,
    ACTIVE,
    DISMISSED
  }
}