<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: yangzhao
  Date: 17/12/15
  Time: 16:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="../main.jsp" %>
    <title>区域列表</title>
    <script type="application/javascript">
        var layer;
        layui.use('layer', function () { //独立版的layer无需执行这一句
            layer = layui.layer; //独立版的layer无需执行这一句
        })
        function disable(areaId, status) {
            var childStatus = 0;
            //询问框
            layer.confirm('是否禁用所有下级？', {
                btn: ['是', '否'] //按钮
            }, function () {
                childStatus = 1
                editOrgStatus(areaId, status, childStatus);
            }, function () {
                layer.closeAll();
                editOrgStatus(areaId, status, childStatus);
            });

        }
        function use(areaId, status) {
            var childStatus = 0;
            //询问框
            layer.confirm('是否启用所有下级？', {
                btn: ['是', '否'] //按钮
            }, function () {
                childStatus = 1
                layer.closeAll();
                editOrgStatus(areaId, status, childStatus);

            }, function () {
                layer.closeAll();
                editOrgStatus(areaId, status, childStatus);
            });

        }
        function editOrgStatus(areaId, status, allChildStatus) {
            $.post('/area/edit/del_flag', {
                'id': areaId,
                'status': status,
                'childStatus': allChildStatus
            }, function (data) {
                if (data) {
                    layer.msg("操作成功")
                    window.location.reload();
                } else {
                    layer.msg("操作失败")
                }
            })
        }

        function del(id) {
            $.post("/area/" + id + "/delete", function (data) {
                if (data) {
                    layer.msg("操作成功")
                    $("#tr_" + id).remove();
                } else {
                    layer.msg("操作失败")
                }
            })
        }
    </script>
</head>
<body>
<shiro:hasPermission name="area:edit">
    <c:set var="update" value="1"/>
</shiro:hasPermission>
<shiro:hasPermission name="area:add">
    <c:set var="create" value="1"/>
</shiro:hasPermission>
<shiro:hasPermission name="area:delete">
    <c:set var="delete" value="1"/>
</shiro:hasPermission>
<div class="container-fluid">
    <ul id="myTab" class="nav nav-tabs">
        <li class="active"><a href="#organization" data-toggle="tab">
            区域列表</a></li>
        <c:if test="${empty area.id}">
            <li onclick="location.href='/area/0/add'"><a href="#" data-toggle="tab">区域添加</a></li>
        </c:if>
        <c:if test="${!empty area.id}">
            <li onclick="location.href='/area/${area.id}/appendChild'"><a href="#" data-toggle="tab">区域添加</a>
            </li>
        </c:if>
    </ul>
    <div id="myTabContent" class="tab-content">
        <div class="tab-pane fade in active">
            <div class="table-bordered" style="padding: 20px">
                <form class="form-inline" action="/area/search">
                    <div class="form-group">
                        <label for="id">区域ID</label>
                        <input type="text" name="id" class="form-control" id="id">
                    </div>
                    <div class="form-group">
                        <label for="aName">区域名称</label>
                        <input type="text" name="aName" class="form-control" id="aName">
                    </div>
                    <div class="form-group">
                        <label for="code">区域编码</label>
                        <input type="text" name="code" class="form-control" id="code">
                    </div>
                    <button type="submit" class="btn btn-default">搜索</button>
                </form>
            </div>
            <div class="table-responsive">
                <table class="table table-bordered text-nowrap">
                    <thead>
                    <tr>
                        <td>区域ID</td>
                        <td>区域名称</td>
                        <td>区域编码</td>
                        <td>区域类别</td>
                        <td>父节点</td>
                        <td>所有父节点</td>
                        <td>状态</td>
                        <td>备注</td>
                        <td>操作</td>
                    </tr>
                    </thead>
                    <tbody>

                    <c:if test="${empty areas}">
                        <tr>
                            <td colspan="20">暂无数据</td>
                        </tr>
                    </c:if>

                    <c:forEach items="${areas}" var="area">
                        <tr id="tr_${area.id}">
                            <td>${area.id}</td>
                            <td>${area.aName}</td>
                            <td>${area.code}</td>
                            <td>
                                ${typeDicMap[area.aType].atName}
                            </td>
                            <td>${area.parentId}</td>
                            <td>${area.parentIds}</td>
                            <td>${area.aStatus}</td>
                            <td></td>
                            <td>
                                <c:if test="${update==1}">
                                    <a href="/area/edit?id=${area.id}">修改</a>
                                    <c:if test="${area.aStatus==false}">
                                        <a href="#" onclick="use('${area.id}',1);">启用</a>
                                    </c:if>
                                    <c:if test="${area.aStatus==true}">
                                        <a href="#" onclick="disable('${area.id}',0)">禁用</a>
                                    </c:if>
                                </c:if>

                                <c:if test="${delete==1}">
                                    <a href="#" onclick="del('${area.id}')">删除</a>
                                </c:if>

                                <c:if test="${create==1}">
                                    <a href="/area/${area.id}/add">添加下级机构</a>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>
