package pam.controller

import org.springframework.data.domain.PageRequest
import org.springframework.data.web.PagedResourcesAssembler
import org.springframework.hateoas.PagedResources
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.RestController
import pam.format.AcgMemberListElement
import pam.services.AcgMemberListService
import pam.util.Sort


@RestController()
class AcgMemberCustomController(
        val acgMemberListService: AcgMemberListService,
        val pagedResourcesAssembler: PagedResourcesAssembler<AcgMemberListElement>
) {


    @GetMapping("getMemberListElements")
    fun getListElements(
            @RequestParam(value = "page", required = false) page: Int?,
            @RequestParam(value = "size", required = false) size: Int?,
            @RequestParam(value = "sort", required = false) sort: List<Sort>?
    ): PagedResources<*> {

        val pageable = PageRequest.of(page ?: 0, size ?: 20)
        val responseBody = acgMemberListService.createAcgMemberListElement(pageable, sort)

        return pagedResourcesAssembler.toResource(responseBody)
    }
}