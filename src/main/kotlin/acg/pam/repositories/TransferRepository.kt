package acg.pam.repositories

import acg.pam.sql.Transfer
import org.springframework.data.jpa.repository.JpaRepository

interface TransferRepository : JpaRepository<Transfer, Int>