package pam.repositories

import org.springframework.data.jpa.repository.JpaRepository
import pam.sql.Namepool

interface NamepoolRepository : JpaRepository<Namepool, Long>