package pam.sql

import javax.persistence.*

@Entity
data class Campaign(
    val name: String,
    val platform: Platform,
    @Column(name = "campaign_status")
    val state: State,
    val time: String,
    val open: Boolean,
    @OneToOne
    @JoinColumn(name = "campaign_link")
    val previous_campaign: Campaign,
    val description: String,
    val image: String,
    @OneToMany(mappedBy = "campaign")
    val missions: List<Mission>,
    @OneToMany(mappedBy = "campaign")
    val deployedUnits: List<DeployedUnit>
) : BaseEntity() {

  enum class Platform {
    IL2_CLIFFS_OF_DOVER,
    IL2_BATTLE_OF_MOSCOW,
    IL2_BATTLE_OF_STALINGRAD,
    IL2_BATTLE_OF_KUBAN,
    RISE_OF_FLIGHT,
    DIGITAL_COMBAT_SIMULATOR
  }

  enum class State {
    IN_PLANNING,
    ONGOING,
    FINISHED
  }
}