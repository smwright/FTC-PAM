package pam.repositories

import org.springframework.data.jpa.repository.JpaRepository
import pam.sql.Campaign

interface CampaignRepository : JpaRepository<Campaign, Int>