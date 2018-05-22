package pam.sql

import java.util.*
import javax.persistence.*

@Entity
data class Mission(
    val name: String,
    @ManyToOne
    @JoinColumn(name = "campaign_id")
    val campaign: Campaign,
    @Temporal(TemporalType.DATE)
    val realDate: Date,
    @Temporal(TemporalType.DATE)
    val histDate: Date,
    @Column(name = "mission_status")
    val state: State
) : BaseEntity() {

  enum class State {
    BRIEFING,
    DEBRIEFING,
    CLOSED
  }
}