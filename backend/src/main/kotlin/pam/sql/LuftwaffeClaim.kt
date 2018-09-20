package pam.sql

import javax.persistence.Entity
import javax.persistence.JoinColumn
import javax.persistence.ManyToOne


@Entity(name = "claim_lw")
data class LuftwaffeClaim(
        val claimTime: String,
        val place: String,
        val opponent: String,
        val typeOfDestruction: TypeOfDestruction,
        val typeOfImpact: TypeOfImpact,
        val fateOfCrew: FateOfCrew,
        @ManyToOne
        @JoinColumn(name = "witness")
        val witness: AcgMember,
        val confirmed: Boolean,
        @ManyToOne
        @JoinColumn(name = "report_id")
        val report: Report,
        @ManyToOne
        @JoinColumn(name = "asset_id")
        private val asset: Asset,
        private val accepted: Boolean
) : BaseEntity() {

    enum class TypeOfDestruction {
        LIGHT_SMOKE,
        DARK_SMOKE,
        FLAMES,
        PARTS_BROKE_AWAY,
        EXPLOSION,
        FORCED_CRASH_LANDING
    }

    enum class TypeOfImpact {
        NOT_OBSERVED,
        STEEP_ANGLE_WITH_CRASH_FIRE,
        SHALLOW_ANGLE_WITH_CRASH_FIRE,
        STEEP_ANGLE_WITH_DUST_CLOUD,
        SHALLOW_ANGLE_WITH_DUST_CLOUD,
        SPLASHDOWN,
        Something
    }

    enum class FateOfCrew {
        WTF,
        Something,
        NOT_OBSERVED,
        PARACHUTED,
        DEATH
    }
}