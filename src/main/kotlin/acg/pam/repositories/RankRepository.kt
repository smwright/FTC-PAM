package acg.pam.repositories

import acg.pam.sql.Rank
import org.springframework.data.jpa.repository.JpaRepository

interface RankRepository : JpaRepository<Rank, Int>