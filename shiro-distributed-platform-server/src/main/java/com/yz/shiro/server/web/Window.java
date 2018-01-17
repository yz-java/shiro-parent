package com.yz.shiro.server.web;

/**
 * @author yangzhao
 *         create by 17/12/19
 */
public class Window {

    public Window(){
    }

    public Window(String msg){
        this.msg = msg;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    private String msg;

}
