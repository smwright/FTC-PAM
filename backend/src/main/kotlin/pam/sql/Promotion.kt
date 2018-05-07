package pam.sql

import java.util.*
import javax.persistence.*

@Entity
@Table(name = "promotions")
data class Promotion(
    @ManyToOne
    @JoinColumn(name = "member_id")
    val acgMember: AcgMember,
    val value: Int,
    @Temporal(TemporalType.DATE)
    val date: Date,
    val comment: String
) : BaseEntity()