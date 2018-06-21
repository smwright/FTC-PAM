package pam.sql

import java.time.Instant
import java.util.*
import javax.persistence.*

@Entity(name = "transfers")
data class Transfer(
    @ManyToOne
    @JoinColumn(name = "member_id")
    val acgMember: AcgMember,
    @Temporal(TemporalType.DATE)
    val transferDate: Date = Date.from(Instant.MIN)
) : BaseEntity()