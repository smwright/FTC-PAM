package pam.controller

import org.springframework.data.domain.PageRequest
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.RestController
import pam.services.AcgMemberService


@RestController()
class AcgMemberCustomController(
    val acgMemberService: AcgMemberService
) {

  @GetMapping("getMemberListElements")
  fun getListElements(
      @RequestParam(value = "page", required = false) page: Int?,
      @RequestParam(value = "size", required = false) size: Int?
//      @RequestParam(value = "name", required = false) name: String
  ): ResponseEntity<*> {

    val pageable = PageRequest.of(page ?: 0, size ?: 20)
    val responseBody = acgMemberService.createAcgMemberListElement(pageable)

    return ResponseEntity.ok(responseBody)
  }
}