package pam.sql

import javax.persistence.Entity
import javax.persistence.OneToMany

@Entity(name = "hist_unit")
data class HistoricalUnit(
    val name: String,
    val code: String,
    val faction: Faction,
    val type: Type,
    val description: String,
    val image: String,
    @OneToMany(mappedBy = "historicalUnit")
    val deployedUnits: List<DeployedUnit>

) : BaseEntity() {

  enum class Type {
    FIGHTER,
    BOMBER,
    GROUND_ATTACK,
    SUPPORT
  }
}