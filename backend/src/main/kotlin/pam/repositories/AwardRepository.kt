package pam.repositories

import pam.sql.Award
import org.springframework.data.jpa.repository.JpaRepository

interface AwardRepository : JpaRepository<Award, Int> {
}