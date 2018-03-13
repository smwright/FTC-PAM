package acg.pam.repositories

import acg.pam.sql.Promotion
import org.springframework.data.jpa.repository.JpaRepository

interface PromotionRepository : JpaRepository<Promotion, Int>