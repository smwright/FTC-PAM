package pam.sql

import com.fasterxml.jackson.annotation.JsonManagedReference
import javax.persistence.*

@Entity
data class AcgMember(
        val username: String,
        val callsign: String,
        val admin: Boolean,
        val mapViewer: Boolean,
        val missionBuilder: Boolean

) : BaseEntity() {

    @OneToMany(mappedBy = "acgMember")
    @JsonManagedReference
    lateinit var characters: List<Character>
    @OneToMany(mappedBy = "acgMember")
    @JsonManagedReference
    lateinit var memberState: List<MemberState>
    @OneToMany(mappedBy = "acgMember")
    @JsonManagedReference
    lateinit var promotions: List<Promotion>
}