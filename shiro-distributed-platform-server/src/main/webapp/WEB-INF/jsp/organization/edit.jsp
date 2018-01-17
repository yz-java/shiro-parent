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
    <title>组织结构编辑</title>
</head>
<body>
<div class="container-fluid">
    <div class="table-bordered">
        <ul id="myTab" class="nav nav-tabs">
            <li class="active" onclick="location.href='/organization/search'"><a href="#" data-toggle="tab">
                机构列表</a></li>
            <li>
                <a href="#edit" data-toggle="tab">
                    <c:if test="${option == 'edit'}">
                        机构编辑
                    </c:if>
                    <c:if test="${option == 'add'}">
                        机构添加
                    </c:if>
                </a>
            </li>
        </ul>
        <div id="myTabContent" class="tab-content">
            <div class="tab-pane fade" id="edit">
                <form class="form-horizontal layui-form layui-form-pane1" method="post">
                    <div class="col-xs-12 form-group" style="text-align: center">
                        <label class="col-xs-2 layui-form-label">上级机构：</label>
                        <div class="col-xs-2 layui-input-inline">
                            <select name="parentId" lay-filter="organizations" lay-search lay-write>
                                <c:forEach items="${organizations}" var="organization">
                                    <c:if test="${parentId==organization.id}">
                                        <option value="${organization.id}" selected="selected">${organization.orgName}</option>
                                    </c:if>
                                    <c:if test="${parentId!=organization.id}">
                                        <option value="${organization.id}">${organization.orgName}</option>
                                    </c:if>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="col-xs-12 form-group" style="text-align: center">
                        <label class="col-xs-2 layui-form-label">归属区域：</label>
                        <div class="col-xs-2 layui-input-inline">
                            <select name="" lay-filter="organizations" lay-search lay-write>
                                <option value="">请选择</option>
                                <c:forEach items="${organizations}" var="organization">
                                    <option value="${organization.id}">${organization.orgName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="col-xs-12 form-group" style="text-align: center">
                        <label class="col-xs-2 layui-form-label">机构名称：</label>
                        <div class="col-xs-2 layui-input-inline">
                            <input type="text" name="orgName" lay-verify="required|pass" placeholder="请输入机构名称"
                                   autocomplete="off" class="layui-input" value="${organization.orgName}">
                        </div>
                        <div class="layui-form-mid layui-word-aux">请务必填写机构名称</div>
                    </div>
                    <div class="col-xs-12 form-group" style="text-align: center">
                        <label class="col-xs-2 layui-form-label">机构编码：</label>
                        <div class="col-xs-2 layui-input-inline">
                            <input type="text" name="orgCode" lay-verify="required|pass" placeholder="请输入机构编码"
                                   autocomplete="off" class="layui-input" value="${organization.orgCode}">
                        </div>
                        <div class="layui-form-mid layui-word-aux">请务必填写机构编码</div>
                    </div>
                    <div class="col-xs-12 form-group" style="text-align: center">
                        <label class="col-xs-2 layui-form-label">机构类型：</label>
                        <div class="col-xs-2 layui-input-inline">
                            <select name="interest" lay-filter="organizations" lay-search lay-write>
                                <option value="">请选择</option>
                                <c:forEach items="${organizations}" var="organization">
                                    <option value="${organization.id}">${organization.orgName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="col-xs-12 form-group" style="text-align: center">
                        <label class="col-xs-2 layui-form-label">机构级别：</label>
                        <div class="col-xs-2 layui-input-inline">
                            <select name="interest" lay-filter="organizations" lay-search lay-write>
                                <option value="">请选择</option>
                                <c:forEach items="${organizations}" var="organization">
                                    <option value="${organization.id}">${organization.orgName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <input type="hidden" name="id" value="${organization.id}">

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
        $("form").attr('action','/organization/'+parentId+'/appendChild');
        $("form").submit();
    }
    function update() {
        $("form").attr('action','/organization/edit')
        $("form").submit();
    }
</script>
</body>
</html>
