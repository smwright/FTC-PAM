package pam.repositories

import pam.sql.Rank
import org.springframework.data.jpa.repository.JpaRepository

interface RankRepository : JpaRepository<Rank, Int>