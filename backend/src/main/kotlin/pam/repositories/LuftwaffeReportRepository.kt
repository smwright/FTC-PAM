package pam.repositories

import org.springframework.data.jpa.repository.JpaRepository
import pam.sql.LuftwaffeReport


interface LuftwaffeReportRepository : JpaRepository<LuftwaffeReport, Long>