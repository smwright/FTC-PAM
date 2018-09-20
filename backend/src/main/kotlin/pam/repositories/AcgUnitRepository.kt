package pam.repositories

import org.springframework.data.jpa.repository.JpaRepository
import pam.sql.AcgUnit

interface AcgUnitRepository : JpaRepository<AcgUnit, Int>