package pam.repositories

import pam.sql.MemberStatus
import org.springframework.data.jpa.repository.JpaRepository

interface MemberStatusRepository : JpaRepository<MemberStatus, Int>