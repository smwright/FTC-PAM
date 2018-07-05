package pam.format

import pam.sql.MemberState
import java.util.*

data class AcgMemberDetailed(
    val id: Int,
    val rank: Int,
    val callSign: String,
    val joiningDate: Date,
    val admin: Boolean,
    val missionBuilder: Boolean,
    val lastStatusChanged: Date,
    val state: MemberState.State
    ) {
}