package acg.pam.repositories

import acg.pam.sql.Character
import org.springframework.data.jpa.repository.JpaRepository

interface CharacterRepository : JpaRepository<Character, Int> {
}