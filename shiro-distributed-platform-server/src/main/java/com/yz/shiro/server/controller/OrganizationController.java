package com.yz.shiro.server.controller;

import com.yz.shiro.entity.Organization;
import com.yz.shiro.api.service.OrganizationService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Arrays;
import java.util.List;

/**
 * 
* @ClassName: OrganizationController 
* @Description: 组织
* @author yangyw(imalex@163.com)
* @date 2015年3月20日 下午2:08:58 
*
 */
@Controller
@RequestMapping("/organization")
public class OrganizationController {

    @Autowired
    private OrganizationService organizationService;

    @RequiresPermissions("organization:view")
    @RequestMapping
    public String index() {
        return "organization/index";
    }

    @RequiresPermissions("organization:view")
    @RequestMapping("/search")
    public String search(@RequestParam(required = false,defaultValue = "0") long id, String orgName, String orgCode, ModelMap modelMap) {
        Organization organization = new Organization();
        if (id!=0){
            organization.setId(id);
        }
        if (!StringUtils.isEmpty(orgName)){
            organization.setOrgName(orgName);
        }
        if (!StringUtils.isEmpty(orgCode)){
            organization.setOrgCode(orgCode);
        }
        List<Organization> organizations = organizationService.getByOrganization(organization);
        modelMap.put("organizations",organizations);
        return "organization/list";
    }


    @RequiresPermissions("organization:view")
    @RequestMapping(value = "/tree", method = RequestMethod.GET)
    public String showTree(Model model) {
        Organization organization = new Organization();
        organization.setOrgStatus(true);
        List<Organization> organizations = organizationService.getByOrganization(organization);
        model.addAttribute("organizationList", organizations);
        return "organization/tree";
    }

    @RequiresPermissions("organization:update")
    @RequestMapping(value = "/edit",method = RequestMethod.GET)
    public String editPage(Long organizationId,Model model) {
        Organization organization = organizationService.findOne(organizationId);
        List<Organization> organizations = organizationService.findAll();
        model.addAttribute("parentId",organization.getParentId());
        model.addAttribute("organization",organization);
        model.addAttribute("organizations",organizations);
        model.addAttribute("option","edit");
        return "organization/edit";
    }

    @RequiresPermissions("organization:update")
    @RequestMapping(value = "/edit/org_status")
    @ResponseBody
    public boolean editOrgStatus(Long id,int status,int childStatus) {
        boolean b = organizationService.updateOrgStatus(id, status == 0 ? false : true, childStatus);
        return b;
    }

    @RequiresPermissions("organization:update")
    @RequestMapping(value = "/edit",method = RequestMethod.POST)
    public String edit(Organization organization) {
        boolean b = organizationService.updateOrganization(organization);
        if (!b){
            return "";
        }
        return "redirect:/organization/search";
    }

    @RequiresPermissions("organization:create")
    @RequestMapping(value = "/add")
    public String addPage(Model model) {
        List<Organization> organizations = organizationService.findAll();
        model.addAttribute("option","add");
        model.addAttribute("organizations",organizations);
        return "organization/edit";
    }


    @RequiresPermissions("organization:create")
    @RequestMapping(value = "/{parentId}/appendChild", method = RequestMethod.GET)
    public String showAppendChildForm(@PathVariable("parentId") Long parentId, Model model) {
        Organization parent = organizationService.findOne(parentId);
        model.addAttribute("organizations", Arrays.asList(parent));
        String parentIds = "/0/";
        if (parent != null){
            parentIds = parent.getParentIds()+parent.getId()+"/";
        }
        model.addAttribute("parentId", parentId);
        model.addAttribute("parentIds", parentIds);
        model.addAttribute("option", "add");
        return "organization/edit";
    }

    @RequiresPermissions("organization:create")
    @RequestMapping(value = "/{parentId}/appendChild", method = RequestMethod.POST)
    public String create(Organization organization) {
        Long parentId = organization.getParentId();
        Organization parentOrganization = organizationService.findOne(parentId);
        organization.setParentIds(parentOrganization.getParentIds()+parentId+"/");
        organizationService.createOrganization(organization);
        return "success";
    }

    @RequiresPermissions("organization:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.POST)
    public String update(Organization organization, RedirectAttributes redirectAttributes) {
        organizationService.updateOrganization(organization);
        redirectAttributes.addFlashAttribute("msg", "修改成功");
        return "redirect:/organization/success";
    }

    @RequiresPermissions("organization:update")
    @RequestMapping(value = "/{sourceId}/move", method = RequestMethod.POST)
    public String move(@PathVariable("sourceId") Long sourceId,
                       @RequestParam("targetId") Long targetId) {
        Organization source = organizationService.findOne(sourceId);
        Organization target = organizationService.findOne(targetId);
        organizationService.move(source, target);
        return "redirect:/organization/success";
    }

    @RequiresPermissions("organization:delete")
    @RequestMapping(value = "/{sourceId}/delete")
    public String delete(@PathVariable("sourceId") Long sourceId) {
        organizationService.deleteOrganization(sourceId);
        return "redirect:/organization/search";
    }

}
