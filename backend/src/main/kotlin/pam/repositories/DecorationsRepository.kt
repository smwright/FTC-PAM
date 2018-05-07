package pam.repositories

import pam.sql.Decoration
import org.springframework.data.jpa.repository.JpaRepository

interface DecorationsRepository : JpaRepository<Decoration, Int> {
}