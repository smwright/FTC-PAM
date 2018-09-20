package pam.repositories

import org.springframework.data.jpa.repository.JpaRepository
import pam.sql.DeployedUnit

interface DeployedUnitRepository : JpaRepository<DeployedUnit, Int>