package pam.sql

import java.util.*
import javax.persistence.*

@Entity
@Table(name = "decorations")
data class Decoration(
    @ManyToOne
    @JoinColumn(name = "character_id")
    val character: Character,
    @ManyToOne
    @JoinColumn(name = "award_id")
    val award: Award,
    @Temporal(TemporalType.DATE)
    val date: Date,
    val awarded: Boolean,
    @OneToOne
    @JoinColumn(name = "awarded_by")
    val awardedBy: AcgMember,
    @Temporal(TemporalType.DATE)
    val availableSince: Date
) : BaseEntity()