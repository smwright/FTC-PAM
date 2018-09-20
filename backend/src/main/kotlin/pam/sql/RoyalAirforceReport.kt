package pam.sql

import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.JoinColumn
import javax.persistence.OneToOne


@Entity(name = "report_detail_raf")
data class RoyalAirforceReport(
        val flight: Int,
        val section: Int,
        val sectionPos: Int,
        val serialNo: String,
        @OneToOne
        @JoinColumn(name = "report_id")
        val report: Report
) : BaseEntity()