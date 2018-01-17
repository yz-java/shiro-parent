<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@ include file="../../jsp/common/resource.jsp" %>
    <%@ include file="../../jsp/common/tags.jsp" %>
    <%@ include file="../main.jsp" %>
    <title>用户管理</title>
    <shiro:hasPermission name="user:update">
        <c:set value="1" var="allow_update"/>
    </shiro:hasPermission>
    <shiro:hasPermission name="user:delete">
        <c:set value="1" var="allow_delete"/>
    </shiro:hasPermission>
    <script type="application/javascript">
        var layer;
        layui.use(['form', 'layedit', 'laydate'], function () {
            var form = layui.form;
            layer = layui.layer
        })
        function del(id) {
            $.post('/user/' + id + '/delete', function (data) {
                if (data == true) {
                    layer.msg("操作成功");
                    $("#tr_" + id).remove();
                } else {
                    layer.msg("操作失败")
                }
            })
        }
    </script>
</head>
<body>
<div class="container-fluid">
    <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
        <ul class="layui-tab-title">
            <li class="layui-this">用户列表</li>
        </ul>

        <div class="layui-tab-content">
            <form class="form-inline" action="/user/search">
                <div class="form-group">
                    <label for="username">用户名	</label>
                    <input type="text" name="username" class="form-control" id="username">
                </div>
                <div class="form-group">
                    <label for="phone">手机号</label>
                    <input type="phone" name="phone" class="form-control" id="phone">
                </div>
                <button type="submit" class="btn btn-default">搜索</button>
            </form>
            <br/>
            <div class="table-responsive text-center">
                <table class="table table-bordered table-hover">
                    <thead>
                    <tr>
                        <td>用户名</td>
                        <td>密码</td>
                        <td>手机号</td>
                        <td>所属组织</td>
                        <td>操作</td>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${userList}" var="user">
                        <tr id="tr_${user.id}">
                            <td>${user.username}</td>
                            <td>${user.password}</td>
                            <td>${user.phone}</td>
                            <td>${shbfn:organizationName(user.organizationId)}</td>
                            <td>
                                <c:if test="${allow_update==1}">
                                    <a href="${ctx}/user/${user.id}/update">修改</a>
                                </c:if>
                                <c:if test="${allow_delete==1}">
                                    <a href="#" onclick="del('${user.id}');">删除</a>
                                </c:if>
                                <c:if test="${allow_update==1}">
                                    <a href="${ctx}/user/${user.id}/changePassword">改密</a>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <!-- 表格结束-->
            <shiro:hasPermission name="user:create">
                <a href="${ctx}/user/create" class="layui-btn">用户新增</a>
            </shiro:hasPermission>
        </div>
    </div>
</div>
</body>
</html>