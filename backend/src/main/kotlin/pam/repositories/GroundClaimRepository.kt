package pam.repositories

import org.springframework.data.jpa.repository.JpaRepository
import pam.sql.GroundClaim

interface GroundClaimRepository : JpaRepository<GroundClaim, Long>