<%@ taglib prefix="shbfn" uri="http://www.saohuobang.com/platform/tags/shb-functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%@include file="../main.jsp" %>
    <title>角色管理</title>
    <script type="application/javascript">
        var layer;
        $(function () {
            var totalRecord = $("input[name='totalRecord']").val();
            layui.use(['laypage', 'layer'], function () {
                var laypage = layui.laypage;
                layer = layui.layer;
                //完整功能
                laypage.render({
                    elem: 'page'
                    , count: totalRecord
                    , theme: '#377bb5'
                    , layout: ['count', 'prev', 'page', 'next', 'limit', 'skip']
                    , jump: function (obj) {
                        console.log(obj)
                    }
                });
            })
        })

        function showResource(resources) {
            $.post('/resource/query/ids', {"resourceIds": resources}, function (data) {
                var html = "";
                $("#resource").html(html);
                if (data != null) {
                    $.each(data, function (i, v) {
                        html += "<tr>";
                        html += '<td>' + v.id + '</td>';
                        html += '<td>' + v.rName + '</td>';
                        html += '<td>' + v.url + '</td>';
                        if (v.rType == 1) {
                            html += '<td>菜单</td>';
                        }
                        if (v.rType == 2) {
                            html += "<td>按钮</td>";
                        }
                        html += '<td>' + v.permission + '</td>';
                        html += "</tr>";
                    });
                    $("#resource").html(html);

                    layer.open({
                        title: '资源列表',
                        type: 1,
                        skin: 'layui-layer-rim',
                        area: ['500px', '580px'],
                        content: $('#resource_table').html()
                    });
                }
            })
        }
        function updateStauts(id, status) {
            $.post('/role/update/status', {"id": id, "status": status}, function (data) {
                if (data == true) {
                    layer.msg("操作成功")
                    window.location.reload();
                } else {
                    layer.msg("操作失败")
                }
            })
        }
        function del(id) {
            $.post('/role/' + id + '/delete', function (data) {
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
<div class="container-fluid text-center">
    <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
        <ul class="layui-tab-title">
            <li class="layui-this">角色列表</li>
        </ul>
        <div class="layui-tab-content" style="height: 100px;">
            <div class="layui-tab-item layui-show">
                <div class="text-left">
                    <form class="form-inline layui-form layui-form-pane1" action="/role/search">
                        <div class="form-group">
                            <label for="rCode">角色编码</label>
                            <input type="text" name="rCode" class="form-control" id="rCode">
                        </div>
                        <button type="submit" class="btn btn-default">搜索</button>
                        <shiro:hasPermission name="role:create">
                            <a href="${ctx}/role/create" class="btn btn-primary">新增</a><br/>
                        </shiro:hasPermission>
                    </form>
                </div>
                <p></p>
                <div class="table-responsive text-center">
                    <table class="table table-bordered table-hover">
                        <thead>
                        <tr>
                            <td>角色编码</td>
                            <td>角色描述</td>
                            <td>拥有资源(权限)</td>
                            <td>是否启用</td>
                            <td>操作</td>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${roleList}" var="role">
                            <tr id="tr_${role.id}">
                                <td>${role.rCode}</td>
                                <td>${role.rDesc}</td>
                                <td>
                                    <button class="btn btn-success" onclick="showResource('${role.resourceIds}');">查看</button>
                                </td>
                                <td>
                                        ${role.rStatus}
                                </td>
                                <td>
                                    <a href="${ctx}/role/${role.id}/update">修改</a>
                                    <c:if test="${role.rStatus==true}">
                                        <a href="#" onclick="updateStauts('${role.id}',0)">禁用</a>
                                    </c:if>
                                    <c:if test="${role.rStatus==false}">
                                        <a href="#" onclick="updateStauts('${role.id}',1)">启用</a>
                                    </c:if>
                                    <a href="#" onclick="del('${role.id}')">删除</a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>

                </div>
                <c:if test="${not empty msg}">
                    <div class="message">${msg}</div>
                </c:if>
                <div class="text-left" id="page"></div>
                <input type="hidden" name="pageNo" value="${page.pageNo}"/>
                <input type="hidden" name="totalRecord" value="${page.totalRecord}"/>
            </div>
            <div class="hide">
                <div id="resource_table">
                    <table class="table table-bordered table-hover text-nowrap">
                        <thead>
                        <tr>
                            <td>资源ID</td>
                            <td>资源名称</td>
                            <td>资源URL</td>
                            <td>资源类型</td>
                            <td>权限</td>
                        </tr>
                        </thead>
                        <tbody id="resource">

                        </tbody>
                    </table>
                </div>
            </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>