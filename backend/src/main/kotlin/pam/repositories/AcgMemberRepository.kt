package pam.repositories

import org.springframework.data.domain.Page
import org.springframework.data.domain.Pageable
import pam.sql.AcgMember
import org.springframework.data.jpa.repository.JpaRepository

interface AcgMemberRepository : JpaRepository<AcgMember, Int> {

  fun findByCallsign(callsign: String, p: Pageable): Page<AcgMember>

  fun findByAdmin(admin: Boolean, p: Pageable): Page<AcgMember>
}
