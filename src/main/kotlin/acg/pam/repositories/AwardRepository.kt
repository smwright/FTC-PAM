package acg.pam.repositories

import acg.pam.sql.Award
import org.springframework.data.jpa.repository.JpaRepository

interface AwardRepository : JpaRepository<Award, Int> {
}