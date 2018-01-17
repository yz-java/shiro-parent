<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: yangzhao
  Date: 17/12/15
  Time: 17:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="../main.jsp" %>
    <title>资源编辑</title>
</head>
<body>
<div class="container-fluid">
    <div class="table-bordered">
        <ul id="myTab" class="nav nav-tabs">
            <li onclick="location.href='/resource/search'"><a href="#" data-toggle="tab">
                资源列表</a></li>
            <li>
                <a href="#edit" data-toggle="tab">
                    <c:if test="${option == 'edit'}">
                        资源编辑
                    </c:if>
                    <c:if test="${option == 'add'}">
                        资源添加
                    </c:if>
                </a>
            </li>
        </ul>
        <div id="myTabContent" class="tab-content">
            <div class="tab-pane fade" id="edit">
                <form class="form-horizontal layui-form layui-form-pane1" method="post">
                    <div class="col-xs-12 form-group" style="text-align: center">
                        <label class="col-xs-2 layui-form-label">父菜单：</label>
                        <div class="col-xs-2 layui-input-inline">
                            <select name="parentId" lay-filter="resources" lay-search lay-write>
                                <c:forEach items="${resources}" var="resource">
                                    <c:if test="${parentId==resource.id}">
                                        <option value="${resource.id}" selected="selected">${resource.rName}</option>
                                    </c:if>
                                    <c:if test="${parentId!=resource.id}">
                                        <option value="${resource.id}">${resource.rName}</option>
                                    </c:if>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="col-xs-12 form-group" style="text-align: center">
                        <label class="col-xs-2 layui-form-label">资源名称：</label>
                        <div class="col-xs-2 layui-input-inline">
                            <input type="text" name="rName" class="layui-input" value="${resource.rName}">
                        </div>
                    </div>
                    <div class="col-xs-12 form-group" style="text-align: center">
                        <label class="col-xs-2 layui-form-label">资源URL：</label>
                        <div class="col-xs-2 layui-input-inline">
                            <input type="text" name="url" lay-verify="required|pass"
                                   autocomplete="off" class="layui-input" value="${resource.url}">
                        </div>
                    </div>
                    <div class="col-xs-12 form-group" style="text-align: center">
                        <label class="col-xs-2 layui-form-label">资源类型：</label>
                        <div class="col-xs-2 layui-input-inline">
                            <select name="rType" lay-filter="resources" lay-search lay-write>
                                <option value="">请选择</option>
                                <c:if test="${resource.rType==1}">
                                    <option value="1" selected>菜单</option>
                                </c:if>
                                <c:if test="${resource.rType!=1}">
                                    <option value="1">菜单</option>
                                </c:if>
                                <c:if test="${resource.rType==2}">
                                    <option value="2" selected>按钮</option>
                                </c:if>
                                <c:if test="${resource.rType!=2}">
                                    <option value="2">按钮</option>
                                </c:if>
                            </select>
                        </div>
                    </div>
                    <div class="col-xs-12 form-group" style="text-align: center">
                        <label class="col-xs-2 layui-form-label">权限：</label>
                        <div class="col-xs-2 layui-input-inline">
                            <input type="text" name="permission" lay-verify="required|pass"
                                   autocomplete="off" class="layui-input" value="${resource.permission}">
                        </div>
                    </div>
                    <input type="hidden" name="id" value="${resource.id}">

                    <c:if test="${option == 'edit'}">
                        <div class="col-xs-12 form-group" style="text-align: center">
                            <button type="button" class="btn btn-default" onclick="update()">修改</button>
                        </div>
                    </c:if>
                    <c:if test="${option == 'add'}">
                        <div class="col-xs-12 form-group" style="text-align: center">
                            <button type="button" class="btn btn-default" onclick="save()">提交</button>
                        </div>
                    </c:if>
                </form>
            </div>
        </div>
    </div>
</div>
<script type="application/javascript">
    $("a[href='#edit']").click()
    var layer;
    layui.use('form', 'layer', function () {
        var form = layui.form;
        layer = layui.layer;
    })
    function save() {
        $("form").attr('action', '/resource/add');
        $("form").submit();
    }
    function update() {
        $("form").attr('action', '/resource/edit')
        $("form").submit();
    }
</script>
<%@include file="../window.jsp"%>
</body>
</html>
