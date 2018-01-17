package com.yz.shiro.server.controller;

import java.util.List;
import java.util.Map;
import com.yz.shiro.api.entity.Organization;
import com.yz.shiro.api.entity.User;
import com.yz.shiro.api.service.OrganizationService;
import com.yz.shiro.api.service.UserService;
import com.yz.shiro.server.utils.UUID;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * 
* @ClassName: UserController 
* @Description: 用户
* @author yangzhao
* @date 2017年12月20日 下午2:09:50
*
 */
@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;
    @Autowired
    private OrganizationService organizationService;

    @RequiresPermissions("user:view")
    @RequestMapping()
    public String list(Model model,Map<String, Object> map) {
		List<User> userList= userService.findAll();
        model.addAttribute("userList", userList);
        return "user/list";
    }

    @RequiresPermissions("user:view")
    @RequestMapping("/search")
    public String search(String username,String phone,Model model) {
        User user = new User();
        if (!StringUtils.isEmpty(username)){
            user.setUsername(username);
        }
        if (!StringUtils.isEmpty(phone)){
            user.setPhone(phone);
        }
		List<User> userList= userService.getByUser(user);
        model.addAttribute("userList", userList);
        return "user/list";
    }

    @RequiresPermissions("user:create")
    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String showCreateForm(Model model) {
        Organization organization = new Organization();
        organization.setOrgStatus(true);
        List<Organization> organizations = organizationService.getByOrganization(organization);
        model.addAttribute("user", new User());
        model.addAttribute("organizations", organizations);
        model.addAttribute("option", "add");
        model.addAttribute("salt", UUID.getUUID());
        return "user/edit";
    }

    @RequiresPermissions("user:create")
    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String create(User user) {
        userService.createUser(user);
        return "redirect:/user";
    }

    @RequiresPermissions("user:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.GET)
    public String showUpdateForm(@PathVariable("id") Long id, Model model) {
        Organization organization = new Organization();
        organization.setOrgStatus(true);
        List<Organization> organizations = organizationService.getByOrganization(organization);
        model.addAttribute("user", userService.findOne(id));
        model.addAttribute("option", "edit");
        model.addAttribute("organizations", organizations);
        return "user/edit";
    }

    @RequiresPermissions("user:update")
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public String update(User user) {
        userService.updateUser(user);
        return "redirect:/user";
    }

    @RequiresPermissions("user:delete")
    @RequestMapping(value = "/{id}/delete")
    @ResponseBody
    public boolean deleteById(@PathVariable("id") Long id) {
        boolean b = userService.deleteUser(id);
        return b;
    }

    @RequiresPermissions("user:update")
    @RequestMapping(value = "/{id}/changePassword", method = RequestMethod.GET)
    public String showChangePasswordForm(@PathVariable("id") Long id, Model model) {
        model.addAttribute("user", userService.findOne(id));
        model.addAttribute("op", "修改密码");
        return "user/changePassword";
    }

    @RequiresPermissions("user:update")
    @RequestMapping(value = "/{id}/changePassword", method = RequestMethod.POST)
    public String changePassword(@PathVariable("id") Long id, String newPassword, RedirectAttributes redirectAttributes) {
        userService.changePassword(id, newPassword);
        redirectAttributes.addFlashAttribute("msg", "修改密码成功");
        return "redirect:/user";
    }
}
