package acg.pam.repositories

import acg.pam.sql.MemberStatus
import org.springframework.data.jpa.repository.JpaRepository

interface MemberStatusRepository : JpaRepository<MemberStatus, Int>