package pam.sql

import com.fasterxml.jackson.annotation.JsonManagedReference
import javax.persistence.*

@Entity
data class AcgMember(
        val username: String,
        val callsign: String,
        val admin: Boolean,
        val mapViewer: Boolean,
        val missionBuilder: Boolean,
        @OneToMany(mappedBy = "acgMember")
        @JsonManagedReference
        val characters: List<Character>,
        @OneToMany(mappedBy = "acgMember")
        @JsonManagedReference
        val memberState: List<MemberState>,
        @OneToMany(mappedBy = "acgMember")
        @JsonManagedReference
        val promotions: List<Promotion>,
        @OneToMany(mappedBy = "acgMember")
        val transfers: List<Transfer>
) : BaseEntity()