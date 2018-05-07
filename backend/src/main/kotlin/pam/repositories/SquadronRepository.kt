package pam.repositories

import pam.sql.Squadron
import org.springframework.data.jpa.repository.JpaRepository

interface SquadronRepository : JpaRepository<Squadron, Int>