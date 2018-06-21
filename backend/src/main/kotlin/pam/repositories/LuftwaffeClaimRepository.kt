package pam.repositories

import org.springframework.data.jpa.repository.JpaRepository
import pam.sql.LuftwaffeClaim

interface LuftwaffeClaimRepository : JpaRepository<LuftwaffeClaim, Long>