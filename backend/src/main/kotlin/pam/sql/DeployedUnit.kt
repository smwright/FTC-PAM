package pam.sql

import javax.persistence.Entity
import javax.persistence.JoinColumn
import javax.persistence.ManyToOne

@Entity(name = "deployed_unit")
data class DeployedUnit(
    @ManyToOne
    @JoinColumn(name = "campaign_id")
    val campaign: Campaign,
    @ManyToOne
    @JoinColumn(name = "hist_unit_id")
    val historicalUnit: HistoricalUnit
) : BaseEntity()