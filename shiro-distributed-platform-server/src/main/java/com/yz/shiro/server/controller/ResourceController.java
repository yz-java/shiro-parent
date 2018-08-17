package com.yz.shiro.server.controller;

import com.yz.shiro.entity.Resource;
import com.yz.shiro.api.service.ResourceService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

/**
 * 
* @ClassName: ResourceController 
* @Description: 资源
* @author yangyw(imalex@163.com)
* @date 2015年3月20日 下午2:09:17 
*
 */
@Controller
@RequestMapping("/resource")
public class ResourceController {

    @Autowired
    private ResourceService resourceService;

    @RequiresPermissions("resource:view")
    @RequestMapping()
    public String index() {
        return "resource/index";
    }

    @RequiresPermissions("resource:view")
    @RequestMapping("/search")
    public String list(@RequestParam(required = false,defaultValue = "0") long id,String rName,@RequestParam(required = false,defaultValue = "0")int rType, ModelMap modelMap) {
        Resource resource = new Resource();
        if (id!=0){
            resource.setId(id);
        }
        if (!StringUtils.isEmpty(rName)){
            resource.setrName(rName);
        }
        if (rType!=0) {
            resource.setrType(rType);
        }
        List<Resource> resources = resourceService.getByResource(resource);
        modelMap.put("resources",resources);
        return "resource/list";
    }

    @RequiresPermissions("resource:view")
    @RequestMapping("/tree")
    public String tree(ModelMap modelMap) {
        Resource resource = new Resource();
        resource.setrStatus(true);
        List<Resource> resources = resourceService.getByResource(resource);
        modelMap.put("resources",resources);
        return "resource/tree";
    }

    @RequiresPermissions("resource:create")
    @RequestMapping(value = "/{parentId}/add", method = RequestMethod.GET)
    public String addPage(@PathVariable("parentId") Long parentId, ModelMap modelMap) {
        List<Resource> resources = resourceService.findAll();
        modelMap.put("resources", resources);
        modelMap.put("option", "add");
        modelMap.put("parentId", parentId);
        return "resource/edit";
    }

    @RequiresPermissions("resource:create")
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String add(Resource resource) {
        Long parentId = resource.getParentId();
        Resource r = resourceService.findOne(parentId);
        resource.setParentIds(r.getParentIds()+r.getId()+"/");
        boolean add = resourceService.createResource(resource);
        if (!add){
            return "";
        }
        return "redirect:/resource";
    }

    @RequiresPermissions("resource:update")
    @RequestMapping(value = "/{id}/edit", method = RequestMethod.GET)
    public String showUpdateForm(@PathVariable("id") Long id, Model model) {
        List<Resource> resources = resourceService.findAll();
        Resource resource = resources.stream().filter(r -> {
            return r.getId().equals(id);
        }).findFirst().get();
        model.addAttribute("resource",resource);
        model.addAttribute("resources",resources);
        model.addAttribute("option", "edit");
        model.addAttribute("parentId", resource.getParentId());
        return "resource/edit";
    }

    @RequiresPermissions("resource:update")
    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    public String edit(Resource resource,ModelMap modelMap) {
        boolean b = resourceService.updateResourceById(resource);
        return "redirect:/resource/search";
    }

    @RequiresPermissions("resource:delete")
    @RequestMapping(value = "/edit/update_status", method = RequestMethod.POST)
    @ResponseBody
    public boolean delete(Long id,boolean status,boolean updateAllChild) {
        boolean b = resourceService.updateStatusById(id, status, updateAllChild);
        return b;
    }

    @RequestMapping(value = "/query/ids", method = RequestMethod.POST)
    @ResponseBody
    public Object getResourcesByIds(String resourceIds) {
        if (StringUtils.isEmpty(resourceIds)){
            return null;
        }
        List<Long> rIds = new ArrayList<>();
        for (String id:
             resourceIds.split(",")) {
            rIds.add(Long.parseLong(id));
        }
        List<Resource> resources = resourceService.getByIds(rIds);
        return resources;
    }


}
