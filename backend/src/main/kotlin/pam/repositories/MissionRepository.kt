package pam.repositories

import org.springframework.data.jpa.repository.JpaRepository
import pam.sql.Mission

interface MissionRepository : JpaRepository<Mission, Int>