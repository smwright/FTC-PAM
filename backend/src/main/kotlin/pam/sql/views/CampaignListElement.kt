package pam.sql.views

import pam.sql.BaseEntity
import pam.sql.Campaign
import javax.persistence.*

@Entity
@Table(name = "campaign_list")
data class CampaignListElement(
    val name: String,
    val primary: Boolean,
    val platform: Campaign.Platform,
    val campaignStatus: Campaign.State,
    val time: String,
    val open: Boolean,
    @OneToOne
    @JoinColumn(name = "campaign_link")
    val campaignLink: CampaignListElement?,
    val description: String,
    val image: String,
    val missions: Int,
    val reports: Int
) : BaseEntity()