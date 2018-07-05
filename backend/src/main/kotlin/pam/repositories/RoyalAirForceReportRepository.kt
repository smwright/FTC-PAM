package pam.repositories

import org.springframework.data.jpa.repository.JpaRepository
import pam.sql.RoyalAirforceReport

interface RoyalAirForceReportRepository : JpaRepository<RoyalAirforceReport, Long>