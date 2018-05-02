package acg.pam.repositories

import acg.pam.sql.Decoration
import org.springframework.data.jpa.repository.JpaRepository

interface DecorationsRepository : JpaRepository<Decoration, Int> {
}