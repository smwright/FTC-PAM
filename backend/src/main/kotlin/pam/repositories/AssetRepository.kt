package pam.repositories

import org.springframework.data.jpa.repository.JpaRepository
import pam.sql.Asset

interface AssetRepository : JpaRepository<Asset, Int>