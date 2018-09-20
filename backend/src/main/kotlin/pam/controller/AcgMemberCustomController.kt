package pam.controller

import org.springframework.data.domain.Pageable
import org.springframework.data.web.PagedResourcesAssembler
import org.springframework.hateoas.PagedResources
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController
import pam.format.AcgMemberListElement
import pam.services.AcgMemberListService


@RestController()
class AcgMemberCustomController(
    val acgMemberListService: AcgMemberListService,
    val pagedResourcesAssembler: PagedResourcesAssembler<AcgMemberListElement>
) {


  @GetMapping("getMemberListElements")
  fun getListElements(
      pageable: Pageable
  ): PagedResources<*> {

    val responseBody = acgMemberListService.createAcgMemberListElement(pageable)

    return pagedResourcesAssembler.toResource(responseBody)
  }
}