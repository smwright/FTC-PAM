package pam.repositories

import org.springframework.data.jpa.repository.JpaRepository
import pam.sql.Briefing

interface BriefingRepository : JpaRepository<Briefing, Int>