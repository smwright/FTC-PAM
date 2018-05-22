package pam.repositories

import pam.sql.MemberState
import org.springframework.data.jpa.repository.JpaRepository

interface MemberStatusRepository : JpaRepository<MemberState, Int>