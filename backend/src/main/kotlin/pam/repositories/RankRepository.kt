package pam.repositories

import pam.sql.Rank
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query

interface RankRepository : JpaRepository<Rank, Int> {

  @Query(name = "select ra from Rank r where value = r.value and faction = r.faction ")
  fun findByValueAndFaction(value: Int, faction: Int): Rank?

}

