package com.yz.shiro.server.controller;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;
import com.yz.shiro.entity.Resource;
import com.yz.shiro.entity.Role;
import com.yz.shiro.api.service.ResourceService;
import com.yz.shiro.api.service.RoleService;
import com.yz.shiro.server.utils.Page;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

/**
 * 
* @ClassName: RoleController 
* @Description: 角色 
* @author yangzhao
* @date 2017年12月20日 下午2:09:34
*
 */
@Controller
@RequestMapping("/role")
public class RoleController {

    @Autowired
    private RoleService roleService;

    @Autowired
    private ResourceService resourceService;

    @RequiresPermissions("role:view")
    @RequestMapping("/search")
    public String list(@RequestParam(required = false,defaultValue = "0")Long totalRecord,String rCode,Page page ,ModelMap modelMap) {
        Role role = new Role();
        if (!StringUtils.isEmpty(rCode)){
            role.setrCode(rCode);
        }
        List<Role> roleList= roleService.getByRole(role);
        totalRecord = roleService.getAllCount();
        page.setTotalPage(totalRecord);
        modelMap.put("page",page);
        modelMap.put("roleList",roleList);
        return "role/list";
    }

    @RequiresPermissions("role:create")
    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String showCreateForm(Model model) {
        Resource resource = new Resource();
        resource.setrStatus(true);
        List<Resource> resources = resourceService.getByResource(resource);
        model.addAttribute("resources", resources);
        model.addAttribute("role", new Role());
        model.addAttribute("option", "add");
        return "role/edit";
    }

    @RequiresPermissions("role:create")
    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String create(Role role,String[]permission) {
        if (permission!=null){
            List<String> strings = Arrays.asList(permission);
            if (!CollectionUtils.isEmpty(strings)){
                String resourceIds = strings.stream().collect(Collectors.joining(","));
                role.setResourceIds(resourceIds);
            }
        }
        roleService.createRole(role);
        if (role!=null){
            return "redirect:/role/search";
        }
        return "redirect:/role/create";
    }

    @RequiresPermissions("role:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.GET)
    public String showUpdateForm(@PathVariable("id") Long id, Model model) {
        Role role = roleService.findOne(id);
        String resourceIds = role.getResourceIds();
        if (!StringUtils.isEmpty(resourceIds)){
            String[] split = role.getResourceIds().split(",");
            List<Long> collect = Arrays.asList(split).stream().map(s -> Long.parseLong(s)).collect(Collectors.toList());
            List<Resource> resources = resourceService.getByIds(collect);
            model.addAttribute("resources", resources);
        }

        List<Resource> allResources = resourceService.findAll();
        model.addAttribute("role", role);
        model.addAttribute("allResources", allResources);
        model.addAttribute("option", "edit");
        return "role/edit";
    }

    @RequiresPermissions("role:update")
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public String update(Role role,String[]permission) {
        List<String> strings = Arrays.asList(permission);
        if (!CollectionUtils.isEmpty(strings)){
            String resourceIds = strings.stream().collect(Collectors.joining(","));
            role.setResourceIds(resourceIds);
        }
        roleService.updateRole(role);
        if (role!=null){
            return "redirect:/role/search";
        }
        return "redirect:/role/"+role.getId()+"/update";
    }

    @RequiresPermissions("role:update")
    @RequestMapping(value = "/update/status", method = RequestMethod.POST)
    @ResponseBody
    public boolean updateStatus(long id,boolean status) {
        Role role = new Role();
        role.setId(id);
        role.setrStatus(status);
        roleService.updateRole(role);
        if (role==null){
            return false;
        }
        return true;
    }

    @RequiresPermissions("role:delete")
    @RequestMapping(value = "/{id}/delete", method = RequestMethod.GET)
    public String showDeleteForm(@PathVariable("id") Long id, Model model) {
        setCommonData(model);
        model.addAttribute("role", roleService.findOne(id));
        model.addAttribute("op", "删除");
        return "role/edit";
    }

    @RequiresPermissions("role:delete")
    @RequestMapping(value = "/{id}/delete", method = RequestMethod.POST)
    @ResponseBody
    public boolean delete(@PathVariable("id") Long id) {
        boolean b = roleService.deleteRole(id);
        return b;
    }

    private void setCommonData(Model model) {
        model.addAttribute("resourceList", resourceService.findAll());
    }

}
