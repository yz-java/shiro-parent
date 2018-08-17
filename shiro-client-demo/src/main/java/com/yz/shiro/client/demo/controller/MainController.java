package com.yz.shiro.client.demo.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author yangzhao
 * @Description
 * @Date create by 15:49 18/8/15
 */

@RestController
public class MainController {

    @RequestMapping("/index")
    public String index(){
        return "hello world";
    }
}
