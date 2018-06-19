package pam.controller

import org.springframework.data.domain.PageRequest
import org.springframework.data.web.PagedResourcesAssembler
import org.springframework.hateoas.PagedResources
import org.springframework.hateoas.Resource
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.RestController
import pam.format.AcgMemberListElement
import pam.services.AcgMemberService
import pam.util.Sort


@RestController()
class AcgMemberCustomController(
        val acgMemberService: AcgMemberService,
        val pagedResourcesAssembler: PagedResourcesAssembler<AcgMemberListElement>
) {


    @GetMapping("getMemberListElements")
    fun getListElements(
            @RequestParam(value = "page", required = false) page: Int?,
            @RequestParam(value = "size", required = false) size: Int?,
            @RequestParam(value = "sort", required = false) sort: List<Sort>?
    ): PagedResources<*> {

        val pageable = PageRequest.of(page ?: 0, size ?: 20)
        val responseBody = acgMemberService.createAcgMemberListElement(pageable, sort)

        return pagedResourcesAssembler.toResource(responseBody)
    }
}