package acg.pam.sql

import java.time.Instant
import javax.persistence.Entity
import javax.persistence.JoinColumn
import javax.persistence.ManyToOne

@Entity(name = "transfers")
data class Transfer(
    @ManyToOne
    @JoinColumn(name = "memberID")
    val acgMember: AcgMember,
    @ManyToOne
    @JoinColumn(name = "squadronID")
    val squadron: Squadron,
    val transferDate: Instant
) : BaseEntity()