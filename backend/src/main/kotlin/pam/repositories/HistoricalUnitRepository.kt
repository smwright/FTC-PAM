package pam.repositories

import org.springframework.data.jpa.repository.JpaRepository
import pam.sql.HistoricalUnit

interface HistoricalUnitRepository : JpaRepository<HistoricalUnit, Int> {
}