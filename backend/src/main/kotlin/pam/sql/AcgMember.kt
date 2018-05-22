package pam.sql

import javax.persistence.*

@Entity
data class AcgMember(
    val username: String,
    val callsign: String,
    val admin: Boolean,
    val mapViewer: Boolean,
    val missionBuilder: Boolean,
    @OneToMany(mappedBy = "acgMember")
    val characters: List<Character>,
    @OneToMany(mappedBy = "acgMember")
    val memberState : List<MemberState>
) : BaseEntity()