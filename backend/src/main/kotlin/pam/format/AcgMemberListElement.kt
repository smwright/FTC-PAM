package pam.format

import java.io.Serializable
import java.util.*

class AcgMemberListElement(
    val id: Int,
    val rank: Int,
    val name: String,
    val joiningDate: Date,
    val lastStatusChanged: Date,
    val current_Status: String
) : Serializable