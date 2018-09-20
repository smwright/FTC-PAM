package pam.sql.views

import pam.sql.BaseEntity
import pam.sql.MemberState
import java.util.*
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.Table

@Entity
@Table(name = "acg_member_list_element")
data class AcgMemberListElement(
    val callsign: String,
    val admin: Boolean,
    val mapViewer: Boolean,
    val missionBuilder: Boolean,
    val rank: Int,
    val joiningDate: Date,
    val lastStatusChanged: Date,
    @Column(name = "member_status")
    val state: MemberState.State
//    val campaignStats: List<AcgMemberListElement.MemberListCampaignElement.MemberListCampaignElement>
) : BaseEntity()