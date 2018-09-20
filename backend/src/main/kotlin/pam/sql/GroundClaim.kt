package pam.sql

import javax.persistence.Entity
import javax.persistence.JoinColumn
import javax.persistence.ManyToOne

@Entity(name = "claim_ground")
data class GroundClaim(
        @ManyToOne
        @JoinColumn(name = "report_id")
        val report: Report,
        @ManyToOne
        @JoinColumn(name = "asset_id")
        val asset: Asset,
        val amount: Int,
        val description: String,
        val accepted: Boolean
) : BaseEntity()