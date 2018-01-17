<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%--<%@ include file="../../jsp/common/resource.jsp"%>--%>
    <%--<%@ include file="../../jsp/common/tags.jsp"%>--%>
    <%@include file="../main.jsp" %>
    <title>编辑授权</title>
    <script type="application/javascript">

        $(function () {
            layui.use(['form'], function () {
                var form = layui.form
            });
            $('select').selectpicker({
                liveSearch: true,
                maxOptions: 10
            });

            var roleIds = $("#roleIds").val();
            $.each(roleIds.split(","),function (i,v) {
                $("#role_"+v).change();
            })
        });
        function add() {
            $("form").attr('action', '/authorization/create');
            $("form").submit();
        }
        function edit() {
            $("form").attr('action', '/authorization/update');
            $("form").submit();
        }

    </script>
</head>
<body>
<div class="container-fluid">
    <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
        <ul class="layui-tab-title">
            <li class="layui-this">编辑授权</li>
        </ul>
        <div class="layui-tab-content">
            <div class="layui-tab-item layui-show">
                <form class="text-center" method="post">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label style="width: 100px" class="layui-form-label">应用</label>
                            <div class="layui-input-block">
                                <select name="appId" <c:if test="${option=='edit'}">disabled</c:if>>
                                    <option value="">请选择</option>
                                    <c:forEach items="${apps}" var="app">
                                        <c:if test="${app.id==authorization.id}">
                                            <option selected="selected" value="${app.id}">${app.name}</option>
                                        </c:if>
                                        <c:if test="${app.id!=authorization.id}">
                                            <option value="${app.id}">${app.name}</option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label style="width: 100px" class="layui-form-label">用户</label>
                            <div class="layui-input-block">
                                <select name="userId" <c:if test="${option=='edit'}">disabled</c:if>>
                                    <option value="">请选择</option>
                                    <c:forEach items="${users}" var="user">
                                        <c:if test="${user.id==authorization.userId}">
                                            <option selected="selected" value="${user.id}">${user.username}</option>
                                        </c:if>
                                        <c:if test="${user.id!=authorization.userId}">
                                            <option value="${user.id}">${user.username}</option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label style="width: 100px" class="layui-form-label">角色</label>
                            <div class="layui-input-block">
                                <select id="roles" name="roleIds" class="show-menu-arrow" multiple>
                                    <option value="">请选择</option>
                                    <c:forEach items="${roleForms}" var="role">
                                        <option <c:if test="${role.selected==true}">selected</c:if> id="role_${role.id}" value="${role.id}">${role.rDesc}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>
                    <input type="hidden" name="id" value="${authorization.id}"/>
                    <input type="hidden" id="roleIds" value="${authorization.roleIds}"/>
                    <div class="layui-form-item">
                        <c:if test="${option=='add'}">
                            <button type="button" class="layui-btn" onclick="add();">添加</button>
                        </c:if>
                        <c:if test="${option=='edit'}">
                            <button type="button" class="layui-btn" onclick="edit();">保存</button>
                        </c:if>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

</body>
</html>