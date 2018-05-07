package pam.sql

import java.time.Instant
import java.util.*
import javax.persistence.*

@Entity(name = "transfers")
data class Transfer(
    @ManyToOne
    @JoinColumn(name = "member_id")
    val acgMember: AcgMember,
    @ManyToOne
    @JoinColumn(name = "squadron_id")
    val squadron: Squadron,
    @Temporal(TemporalType.DATE)
    val transferDate: Date = Date.from(Instant.MIN)
) : BaseEntity()