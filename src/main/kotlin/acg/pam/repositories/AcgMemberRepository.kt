package acg.pam.repositories

import acg.pam.sql.AcgMember
import org.springframework.data.jpa.repository.JpaRepository

interface AcgMemberRepository : JpaRepository<AcgMember, Int> {
}