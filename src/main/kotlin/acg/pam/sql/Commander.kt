package acg.pam.sql

import java.io.Serializable
import java.time.Instant
import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.JoinColumn
import javax.persistence.ManyToOne

@Entity(name = "commanders")
data class Commander(
    @Id
    @ManyToOne
    @JoinColumn(name = "squadronId")
    val squadron: Squadron,
    @Id
    @ManyToOne
    @JoinColumn(name = "memberID")
    val acgMember: AcgMember,
    val assigmentDate: Instant
) : Serializable