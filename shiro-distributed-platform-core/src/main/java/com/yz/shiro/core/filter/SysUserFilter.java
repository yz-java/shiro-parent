package com.yz.shiro.core.filter;

import com.yz.shiro.api.entity.User;
import com.yz.shiro.api.service.UserService;
import com.yz.shiro.common.constants.Constant;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.web.filter.PathMatchingFilter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

/**
 * 
* @ClassName: SysUserFilter 
* @Description: 请求拦截器
* @author yangzhao
* @date 2017年12月20日 下午2:10:23
*
 */
public class SysUserFilter extends PathMatchingFilter {

    private Logger logger = LoggerFactory.getLogger(SysUserFilter.class);

    @Autowired
    private UserService userService;

    @Override
    protected boolean onPreHandle(ServletRequest request, ServletResponse response, Object mappedValue) throws Exception {
        HttpServletRequest httpServletRequest = (HttpServletRequest) request;
        logger.info("SysUserFilter----处理拦截URL："+httpServletRequest.getRequestURI());
        String username = (String)SecurityUtils.getSubject().getPrincipal();
        User user = userService.findByUsername(username);
        request.setAttribute(Constant.CURRENT_USER,user);
        return true;
    }
}
