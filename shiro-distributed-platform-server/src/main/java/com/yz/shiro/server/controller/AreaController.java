package com.yz.shiro.server.controller;

import com.yz.shiro.api.entity.Area;
import com.yz.shiro.api.entity.AreaTypeDic;
import com.yz.shiro.api.service.AreaService;
import com.yz.shiro.api.service.AreaTypeDicService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * @author yangzhao
 *         create by 17/12/18
 */
@Controller
@RequestMapping("/area")
public class AreaController {

    @Resource
    AreaService areaServiceImpl;

    @Resource
    AreaTypeDicService areaTypeDicServiceImpl;

    @RequestMapping
    public String index() {
        return "area/index";
    }

    @RequiresPermissions("area:view")
    @RequestMapping("/tree")
    public String tree(ModelMap modelMap) {
        Area area = new Area();
        area.setaStatus(true);
        List<Area> areas = areaServiceImpl.get(area);
        modelMap.put("areas", areas);
        return "area/tree";
    }
    @RequiresPermissions("area:view")
    @RequestMapping(value = "/search", method = RequestMethod.GET)
    public String listPage(@RequestParam(required = false,defaultValue = "0") long id,String aName,String code,ModelMap modelMap) {
        Area area = new Area();
        if (id!=0){
            area.setId(id);
        }
        if (!StringUtils.isEmpty(aName)){
            area.setaName(aName);
        }
        if (!StringUtils.isEmpty(code)){
            area.setCode(code);
        }
        List<Area> areas = areaServiceImpl.get(area);
        List<AreaTypeDic> areaTypeDics = areaTypeDicServiceImpl.selectList(new AreaTypeDic());
        Map<Integer, AreaTypeDic> typeDicMap = areaTypeDics.stream().collect(Collectors.toMap(AreaTypeDic::getId, at -> at));
        modelMap.put("areas", areas);
        modelMap.put("typeDicMap", typeDicMap);
        return "area/list";
    }
    @RequiresPermissions("area:add")
    @RequestMapping(value = "/{parentId}/add", method = RequestMethod.GET)
    public String areaAddPage(@PathVariable("parentId") Long parentId, ModelMap modelMap) {
        List<Area> areas = areaServiceImpl.get(new Area());
        List<AreaTypeDic> areaTypeDics = areaTypeDicServiceImpl.selectList(new AreaTypeDic());
        modelMap.put("option", "add");
        modelMap.put("parentId", parentId);
        modelMap.put("areas", areas);
        modelMap.put("areaTypeDics", areaTypeDics);
        return "area/edit";
    }
    @RequiresPermissions("area:add")
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String areaAdd(Area area) {
        area.setCreateDate(new Date());
        boolean add = areaServiceImpl.add(area);
        if (!add) {
            return "";
        }
        return "redirect:/area/search";
    }
    @RequiresPermissions("area:edit")
    @RequestMapping(value = "/edit", method = RequestMethod.GET)
    public String editPage(long id,ModelMap modelMap) {
        Area area = new Area();
        area.setId(id);
        List<Area> areas = areaServiceImpl.get(area);
        if (CollectionUtils.isEmpty(areas)){
            modelMap.put("area",null);
        }else{
            modelMap.put("area",areas.get(0));
            modelMap.put("parentId",areas.get(0).getParentId());
        }
        areas = areaServiceImpl.get(new Area());
        modelMap.put("areas",areas);
        modelMap.put("option","edit");
        List<AreaTypeDic> areaTypeDics = areaTypeDicServiceImpl.selectList(new AreaTypeDic());
        modelMap.put("areaTypeDics", areaTypeDics);
        return "area/edit";
    }
    @RequiresPermissions("area:edit")
    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    public String edit(Area area,ModelMap modelMap) {
        boolean b = areaServiceImpl.updateById(area);
        if (!b){
            return "";
        }
        return "redirect:/area/search";
    }

    @RequiresPermissions("area:edit")
    @RequestMapping(value = "/edit/del_flag")
    @ResponseBody
    public boolean editDelFlag(long id,boolean status,boolean childStatus) {
        boolean b = areaServiceImpl.updateDelFlagById(id, status, childStatus);
        return b;
    }

    @RequiresPermissions("area:delete")
    @RequestMapping(value = "/{sourceId}/delete")
    @ResponseBody
    public boolean delete(@PathVariable("sourceId")Long sourceId) {
        boolean b = areaServiceImpl.deleteById(sourceId);
        return b;
    }
}
