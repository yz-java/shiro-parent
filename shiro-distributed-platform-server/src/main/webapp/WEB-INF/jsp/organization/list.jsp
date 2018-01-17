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
    <title>组织机构列表</title>
    <script type="application/javascript">
        var layer;
        layui.use('layer', function () { //独立版的layer无需执行这一句
            layer = layui.layer; //独立版的layer无需执行这一句
        })
        function disable(orgId,status) {
            var childStatus = -1;
            //询问框
            layer.confirm('是否禁用所有下级？', {
                btn: ['是', '否'] //按钮
            }, function () {
                childStatus = 0
                editOrgStatus(orgId,status,childStatus);
            }, function () {
                layer.closeAll();
                editOrgStatus(orgId,status,childStatus);
            });

        }
        function use(orgId,status) {
            var childStatus = -1;
            //询问框
            layer.confirm('是否启用所有下级？', {
                btn: ['是', '否'] //按钮
            }, function () {
                childStatus = 1
                layer.closeAll();
                editOrgStatus(orgId,status,childStatus);

            }, function () {
                layer.closeAll();
                editOrgStatus(orgId,status,childStatus);
            });

        }
        function editOrgStatus(orgId,status,allChildStatus) {
            $.post('/organization/edit/org_status',{'id':orgId,'status':status,'childStatus':allChildStatus}, function (data) {
                if (data) {
                    layer.msg("操作成功")
                    window.location.reload();
                } else {
                    layer.msg("操作失败")
                }
            })
        }
    </script>
</head>
<body>
<shiro:hasPermission name="organization:update">
    <c:set var="update" value="1"/>
</shiro:hasPermission>
<shiro:hasPermission name="organization:create">
    <c:set var="create" value="1"/>
</shiro:hasPermission>
<shiro:hasPermission name="organization:delete">
    <c:set var="delete" value="1"/>
</shiro:hasPermission>
<div class="container-fluid">
    <ul id="myTab" class="nav nav-tabs">
        <li class="active"><a href="#organization" data-toggle="tab">
            机构列表</a></li>
        <c:if test="${empty organization.id}">
            <li onclick="location.href='/organization/add'"><a href="#" data-toggle="tab">机构添加</a></li>
        </c:if>
        <c:if test="${!empty organization.id}">
            <li onclick="location.href='/organization/${organization.id}/appendChild'"><a href="#" data-toggle="tab">机构添加</a>
            </li>
        </c:if>
    </ul>
    <div id="myTabContent" class="tab-content">
        <div class="tab-pane fade in active" id="organization">
            <div style="margin: 20px">
                <form class="form-inline" action="/organization/search">
                    <div class="form-group">
                        <label for="orgId">机构ID</label>
                        <input type="text" name="id" class="form-control" id="orgId">
                    </div>
                    <div class="form-group">
                        <label for="orgName">机构名称</label>
                        <input type="text" name="orgName" class="form-control" id="orgName">
                    </div>
                    <div class="form-group">
                        <label for="orgCode">机构编码</label>
                        <input type="text" name="orgCode" class="form-control" id="orgCode">
                    </div>
                    <button type="submit" class="btn btn-default">搜索</button>
                </form>
            </div>
            <div class="table-responsive">
                <table class="table table-bordered text-center text-nowrap">
                    <thead>
                    <tr>
                        <td>机构ID</td>
                        <td>机构名称</td>
                        <td>机构编码</td>
                        <td>所属区域</td>
                        <td>父节点</td>
                        <td>所有父节点</td>
                        <td>状态</td>
                        <td>备注</td>
                        <td>操作</td>
                    </tr>
                    </thead>
                    <tbody>

                    <c:if test="${empty organizations}">
                        <tr>
                            <td colspan="20">暂无数据</td>
                        </tr>
                    </c:if>

                    <c:forEach items="${organizations}" var="organization">
                        <tr>
                            <td>${organization.id}</td>
                            <td>${organization.orgName}</td>
                            <td>${organization.orgCode}</td>
                            <td>${organization.area}</td>
                            <td>${organization.parentId}</td>
                            <td>${organization.parentIds}</td>
                            <td>${organization.orgStatus}</td>
                            <td></td>
                            <td>
                                <c:if test="${update==1}">
                                    <a href="/organization/edit?organizationId=${organization.id}">修改</a>
                                    <c:if test="${organization.orgStatus==false}">
                                        <a href="#" onclick="use('${organization.id}',1);">启用</a>
                                    </c:if>
                                    <c:if test="${organization.orgStatus==true}">
                                        <a href="#" onclick="disable('${organization.id}',0)">禁用</a>
                                    </c:if>
                                </c:if>
                                <c:if test="${delete==1}">
                                    <a href="/organization/${organization.id}/delete">删除</a>
                                </c:if>
                                <c:if test="${create==1}">
                                    <a href="/organization/${organization.id}/appendChild">添加下级机构</a>
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
