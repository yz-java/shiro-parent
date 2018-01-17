package com.yz.shiro.server.controller;

import com.yz.shiro.api.entity.User;
import com.yz.shiro.api.service.AuthorizationService;
import com.yz.shiro.api.service.ResourceService;
import com.yz.shiro.common.constants.Constant;
import com.yz.shiro.api.entity.Resource;
import com.yz.shiro.common.annotation.CurrentUser;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

/**
 * 
* @ClassName: IndexController 
* @Description: 主页
* @author yangyw(imalex@163.com)
* @date 2015年3月20日 下午2:08:34 
*
 */
@Controller
public class IndexController {

    @Autowired
    private ResourceService resourceService;
    @Autowired
    private AuthorizationService authorizationService;

    @RequestMapping("/")
    public String index(@CurrentUser User loginUser, Model model) {
        Set<String> permissions = authorizationService.findPermissions(Constant.SERVER_APP_KEY, loginUser.getUsername());
        List<Resource> resources = resourceService.getByPermissionList(new ArrayList<>(permissions));
        model.addAttribute("resources", resources);
    	return "index";
    }

    @RequestMapping("/cache/resource/reload")
    @ResponseBody
    public boolean reSourceReload() {
        resourceService.cacheAllResources();
        return true;
    }


}
