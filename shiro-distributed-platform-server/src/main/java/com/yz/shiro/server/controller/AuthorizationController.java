package com.yz.shiro.server.controller;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import com.yz.shiro.api.entity.App;
import com.yz.shiro.api.entity.Authorization;
import com.yz.shiro.api.entity.Role;
import com.yz.shiro.api.entity.User;
import com.yz.shiro.api.service.AppService;
import com.yz.shiro.api.service.AuthorizationService;
import com.yz.shiro.api.service.RoleService;
import com.yz.shiro.api.service.UserService;
import com.yz.shiro.server.form.RoleForm;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * 
* @ClassName: AuthorizationController 
* @Description: 权限
* @author yangzhao
* @date 2017年12月20日 下午2:08:22
*
 */
@Controller
@RequestMapping("/authorization")
public class AuthorizationController {

    @Autowired
    private AuthorizationService authorizationService;
    @Autowired
    private UserService userService;
    @Autowired
    private AppService appService;
    @Autowired
    private RoleService roleService;

    @RequiresPermissions("authorization:view")
    @RequestMapping()
    public String list(Model model,HttpServletRequest request,Map<String, Object> map) {
		List<Authorization> authorizationList= authorizationService.findAll();
        model.addAttribute("authorizationList", authorizationList);
        return "authorization/list";
    }

    @RequiresPermissions("authorization:create")
    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String showCreateForm(Model model) {
        List<App> apps = appService.getByApp(new App());
        Role role = new Role();
        role.setrStatus(true);
        List<Role> roles = roleService.getByRole(role);
        List<RoleForm> roleForms = roles.stream().map(r -> {
            RoleForm roleForm = new RoleForm();
            BeanUtils.copyProperties(r, roleForm);
            return roleForm;
        }).collect(Collectors.toList());
        List<User> users = userService.findAll();
        model.addAttribute("apps", apps);
        model.addAttribute("roleForms", roleForms);
        model.addAttribute("users", users);
        model.addAttribute("option", "add");
        return "authorization/edit";
    }

    @RequiresPermissions("authorization:create")
    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String create(Authorization authorization, RedirectAttributes redirectAttributes) {
        authorizationService.createAuthorization(authorization);
        redirectAttributes.addFlashAttribute("msg", "新增成功");
        return "redirect:/authorization";
    }

    @RequiresPermissions("authorization:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.GET)
    public String showUpdateForm(@PathVariable("id") Long id, Model model) {
        Authorization authorization = authorizationService.findOne(id);
        List<App> apps = appService.getByApp(new App());
        Role role = new Role();
        role.setrStatus(true);
        List<Role> roles = roleService.getByRole(role);
        String[] roleIds = authorization.getRoleIds().split(",");
        List<RoleForm> roleForms = roles.stream().map(r -> {
            RoleForm roleForm = new RoleForm();
            BeanUtils.copyProperties(r, roleForm);
            for (String roleId : roleIds) {
                if (r.getId().toString().equals(roleId)) {
                    roleForm.setSelected(true);
                    return roleForm;
                }
            }
            roleForm.setSelected(false);
            return roleForm;
        }).collect(Collectors.toList());
        List<User> users = userService.findAll();
        model.addAttribute("apps", apps);
        model.addAttribute("roleForms", roleForms);
        model.addAttribute("users", users);
        model.addAttribute("authorization", authorization);
        model.addAttribute("option", "edit");
        return "authorization/edit";
    }

    @RequiresPermissions("authorization:update")
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public String update(Authorization authorization) {
        authorizationService.updateAuthorization(authorization);
        return "redirect:/authorization";
    }

    @RequiresPermissions("authorization:delete")
    @RequestMapping(value = "/{id}/delete")
    @ResponseBody
    public boolean delete(@PathVariable("id") Long id) {
        boolean b = authorizationService.deleteAuthorization(id);
        return b;
    }

}
