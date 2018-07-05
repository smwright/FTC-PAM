package pam.sql

import java.util.*
import javax.persistence.*

@Entity
data class Report(
        @ManyToOne
        @JoinColumn(name = "mission_id")
        val mission: Mission,
        @ManyToOne
        @JoinColumn(name = "character_id")
        val character: Character,
        @ManyToOne
        @JoinColumn(name = "deployed_unit_id")
        val deployedUnit: DeployedUnit,
        val base: String,
        @ManyToOne
        @JoinColumn(name = "asset_id")
        val asset: Asset,
        val markings: String,
        val pilotStatus: PilotStatus,
        val assetStatus: AssetStatus,
        val synopsis: String,
        @Temporal(TemporalType.DATE)
        val dateSubmitted: Date,
        val accepted: Boolean,
        @ManyToOne
        @JoinColumn(name = "accepted_by")
        val acceptedBy: AcgMember
) : BaseEntity() {

    enum class PilotStatus {
        OK,
        WOUNDED,
        POW,
        KIA
    }

    enum class AssetStatus {
        OK,
        DAMAGED,
        DESTROYED
    }
}