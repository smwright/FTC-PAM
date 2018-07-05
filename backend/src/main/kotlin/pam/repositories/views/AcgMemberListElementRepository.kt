package pam.repositories.views

import org.springframework.data.jpa.repository.JpaRepository
import pam.sql.views.AcgMemberListElement

interface AcgMemberListElementRepository : JpaRepository<AcgMemberListElement, Int>