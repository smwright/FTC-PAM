package pam.sql

import java.util.*
import javax.persistence.*

@Entity
@Table(name = "promotion")
data class Promotion(
    @ManyToOne
    @JoinColumn(name = "member_id")
    val acgMember: AcgMember,
    @Temporal(TemporalType.DATE)
    val date: Date,
    val comment: String,
    val rankValue: Int
) : BaseEntity()