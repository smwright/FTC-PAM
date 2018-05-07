package pam.repositories

import pam.sql.AcgMember
import org.springframework.data.jpa.repository.JpaRepository

interface AcgMemberRepository : JpaRepository<AcgMember, Int>
