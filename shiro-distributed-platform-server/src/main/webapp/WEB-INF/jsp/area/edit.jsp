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
    <title>区域结构编辑</title>
</head>
<body>
<div class="container-fluid">
    <div class="table-bordered">
        <ul id="myTab" class="nav nav-tabs">
            <li class="active" onclick="location.href='/area/search'"><a href="#" data-toggle="tab">
                区域列表</a></li>
            <li>
                <a href="#edit" data-toggle="tab">
                    <c:if test="${option == 'edit'}">
                        区域编辑
                    </c:if>
                    <c:if test="${option == 'add'}">
                        区域添加
                    </c:if>
                </a>
            </li>
        </ul>
        <div id="myTabContent" class="tab-content">
            <div class="tab-pane fade" id="edit">
                <form class="form-horizontal layui-form layui-form-pane1" method="post">
                    <div class="col-xs-12 form-group" style="text-align: center">
                        <label class="col-xs-2 layui-form-label">上级：</label>
                        <div class="col-xs-2 layui-input-inline">
                            <select name="parentId" lay-filter="organizations" lay-search lay-write>
                                <option value="0">请选择</option>
                                <c:forEach items="${areas}" var="area">
                                    <c:if test="${parentId==area.id}">
                                        <option value="${area.id}" selected="selected">${area.aName}</option>
                                    </c:if>
                                    <c:if test="${parentId!=area.id}">
                                        <option value="${area.id}">${area.aName}</option>
                                    </c:if>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="col-xs-12 form-group" style="text-align: center">
                        <label class="col-xs-2 layui-form-label">区域名称：</label>
                        <div class="col-xs-2 layui-input-inline">
                            <input type="text" name="aName" lay-verify="required|pass" placeholder=""
                                   autocomplete="off" class="layui-input" value="${area.aName}">
                        </div>
                    </div>
                    <div class="col-xs-12 form-group" style="text-align: center">
                        <label class="col-xs-2 layui-form-label">区域编码：</label>
                        <div class="col-xs-2 layui-input-inline">
                            <input type="text" name="code" lay-verify="required|pass" placeholder=""
                                   autocomplete="off" class="layui-input" value="${area.code}">
                        </div>
                    </div>
                    <div class="col-xs-12 form-group" style="text-align: center">
                        <label class="col-xs-2 layui-form-label">区域类型：</label>
                        <div class="col-xs-2 layui-input-inline">
                            <select name="aType" lay-filter="organizations" lay-search lay-write>
                                <option value="0">请选择</option>
                                <c:forEach items="${areaTypeDics}" var="areaTypeDic">
                                    <c:if test="${areaTypeDic.id==area.aType}">
                                        <option value="${areaTypeDic.id}" selected="selected">${areaTypeDic.atName}</option>
                                    </c:if>
                                    <c:if test="${areaTypeDic.id!=area.aType}">
                                        <option value="${areaTypeDic.id}">${areaTypeDic.atName}</option>
                                    </c:if>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <input type="hidden" name="id" value="${area.id}">

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
    layui.use('form','layer', function () {
        var form = layui.form;
        layer = layui.layer;
    })
    function save() {
        var parentId = $("select[name='parentId']").val()
        $("form").attr('action','/area/add');
        $("form").submit();
    }
    function update() {
        $("form").attr('action','/area/edit')
        $("form").submit();
    }
</script>
</body>
</html>
