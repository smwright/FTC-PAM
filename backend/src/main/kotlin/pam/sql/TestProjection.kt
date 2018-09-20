package pam.sql

import org.springframework.data.rest.core.config.Projection
import pam.sql.views.AcgMemberListElement


@Projection(name = "test", types = [AcgMemberListElement::class])
interface TestProjection {

  fun getCallsign() : String

  fun getCharacter(): Character
}