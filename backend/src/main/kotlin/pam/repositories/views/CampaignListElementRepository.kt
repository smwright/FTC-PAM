package pam.repositories.views

import org.springframework.data.jpa.repository.JpaRepository
import pam.sql.views.CampaignListElement

interface CampaignListElementRepository : JpaRepository<CampaignListElement, Int>