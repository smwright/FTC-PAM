package pam.format

import com.fasterxml.jackson.annotation.JsonAlias
import com.fasterxml.jackson.annotation.JsonProperty
import com.sun.org.apache.xerces.internal.util.URI
import org.springframework.web.util.DefaultUriBuilderFactory
import org.springframework.web.util.UriBuilder
import pam.sql.MemberState
import java.io.Serializable
import java.util.*

data class AcgMemberListElement(
        val id: Int,
        val rank: Int,
        val name: String,
        val joiningDate: Date,
        val lastStatusChanged: Date,
        val state: MemberState.State
) : Serializable {

    @JsonProperty("_link")
    val link = DefaultUriBuilderFactory()
            .builder()
            .path("/pam/acgMembers/$id")
            .build()
}