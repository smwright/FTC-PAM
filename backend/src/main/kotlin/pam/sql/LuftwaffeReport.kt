package pam.sql

import javax.persistence.Entity
import javax.persistence.JoinColumn
import javax.persistence.OneToOne

@Entity(name = "report_detail_lw")
data class LuftwaffeReport(
        @OneToOne
        @JoinColumn(name = "report_id")
        val report: Report,
        val swarm: Int,
        val swarmPos: Int
) : BaseEntity()