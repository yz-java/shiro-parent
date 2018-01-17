<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shbfn" uri="http://www.saohuobang.com/platform/tags/shb-functions" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <jsp:include page="../main.jsp"/>
    <title>授权管理</title>
    <script type="application/javascript">
        var layer;
        layui.use(['layer'],function () {
            layer = layui.layer;
        })
        function del(id) {
            $.post('/authorization/'+id+'/delete',function (data) {
                if (data){
                    layer.msg("删除成功");
                    $("#auth_"+id).remove()
                }else{
                    layer.msg("删除失败");
                }
            })
        }
    </script>
</head>
<body>
<shiro:hasPermission name="authorization:update">
    <c:set var="update" value="1"/>
</shiro:hasPermission>
<shiro:hasPermission name="authorization:delete">
    <c:set var="delete" value="1"/>
</shiro:hasPermission>
<div class="container-fluid">
    <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
        <ul class="layui-tab-title">
            <li class="layui-this">授权管理</li>
        </ul>
        <div class="layui-tab-content" style="height: 100px;">
            <div class="layui-tab-item layui-show">
                <table class="table table-hover table-bordered">
                    <thead>
                    <tr>
                        <th>应用</th>
                        <th>用户</th>
                        <th>角色列表</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${authorizationList}" var="authorization">
                        <tr id="auth_${authorization.id}" class="table_content">
                            <td>${shbfn:appName(authorization.appId)}</td>
                            <td>${shbfn:username(authorization.userId)}</td>
                            <td>${shbfn:roleNames(authorization.roleIdsList)}</td>
                            <td>
                                <c:if test="${update==1}">
                                    <a href="${ctx}/authorization/${authorization.id}/update">修改</a>
                                </c:if>
                                <c:if test="${delete==1}">
                                    <a href="#" onclick="del('${authorization.id}');">删除</a>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <shiro:hasPermission name="authorization:create">
                    <a href="${ctx}/authorization/create" class="layui-btn">授权新增</a><br/>
                </shiro:hasPermission>
            </div>
        </div>
    </div>
</div>
</body>
</html>