package pam.repositories

import org.springframework.data.jpa.repository.JpaRepository
import pam.sql.Report

interface ReportRepository : JpaRepository<Report, Int>