package pam.format

import com.fasterxml.jackson.annotation.JsonProperty
import org.springframework.web.util.DefaultUriBuilderFactory
import pam.sql.MemberState
import java.io.Serializable
import java.net.URI
import java.util.*

data class AcgMemberListElement(
        val id: Int,
        val rank: Int,
        val callSign: String,
        val joiningDate: Date,
        val lastStatusChanged: Date,
        val state: MemberState.State,
        val campaignStats: List<MemberListCampaignElement>

) : Serializable {


    @JsonProperty("_link")
    val link: URI = DefaultUriBuilderFactory()
            .builder()
            .path("/pam/acgMembers/$id")
            .build()

    data class MemberListCampaignElement(
            val id: Int,
            val name: String,
            val flownSorties: Int
    ) {

        @JsonProperty("_link")
        val link: URI = DefaultUriBuilderFactory()
                .builder()
                .path("/pam/campaigns/$id")
                .build()
    }
}