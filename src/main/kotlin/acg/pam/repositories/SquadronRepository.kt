package acg.pam.repositories

import acg.pam.sql.Squadron
import org.springframework.data.jpa.repository.JpaRepository

interface SquadronRepository : JpaRepository<Squadron, Int>