package acg.pam.sql

import java.time.Instant
import javax.persistence.Entity
import javax.persistence.OneToMany

@Entity(name = "acgmembers")
data class AcgMember(
    val username : String,
    val callsign : String,
    val joiningDate : Instant,
    val dischargeDate : Instant?,
    val status : Int,
    val admin : Boolean,
    val mapViewer : Boolean,
    val missionBuilder : Boolean,
    val aircraftId : Int,
    @OneToMany(mappedBy = "acgMember", orphanRemoval = true)
    val  characters : List<Character>,
    @OneToMany(mappedBy = "acgMember")
    val transfers : List<Transfer>,
    @OneToMany(mappedBy = "acgMember")
    val commanders : List<Commander>
) : BaseEntity()