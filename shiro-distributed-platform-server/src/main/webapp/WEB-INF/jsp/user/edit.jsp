<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: yangzhao
  Date: 17/12/20
  Time: 09:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="../main.jsp" %>
    <title>用户编辑</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <script type="application/javascript">
        $(function () {
            layui.use(['form', 'layedit', 'laydate'], function () {
                var form = layui.form
                        , layer = layui.layer
            })
        })

        function add() {
            $("form").attr('action','/user/create');
            $("form").submit();
        }
        function edit() {
            $("form").attr('action','/user/update');
            $("form").submit();
        }
    </script>
</head>
<body>
<div class="container-fluid">
    <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
        <ul class="layui-tab-title">
            <c:if test="${option=='add'}">
                <li class="layui-this">用户添加</li>
            </c:if>
            <c:if test="${option=='edit'}">
                <li class="layui-this">用户编辑</li>
            </c:if>
        </ul>
        <div class="layui-tab-content">
            <div class="layui-tab-item layui-show">
                <form class="layui-form text-center" method="post">
                    <div class="layui-form-item">
                        <label class="layui-form-label">用户名</label>
                        <div class="layui-input-inline">
                            <input type="tel" name="username" value="${user.username}"
                                   class="layui-input">
                        </div>
                    </div>
                    <c:if test="${option=='add'}">
                        <div class="layui-form-item">
                            <label class="layui-form-label">密码</label>
                            <div class="layui-input-inline">
                                <input type="tel" name="password" value="${user.password}"
                                       class="layui-input">
                            </div>
                            <div class="layui-form-mid layui-word-aux">请填写6到12位密码</div>
                        </div>
                    </c:if>
                    <div class="layui-form-item">
                        <label class="layui-form-label">salt</label>
                        <div class="layui-input-inline">
                            <c:if test="${option=='add'}">
                                <input type="tel" name="salt" readonly value="${salt}"
                                       class="layui-input">
                            </c:if>
                            <c:if test="${option=='edit'}">
                                <input type="tel" name="salt" readonly value="${user.salt}"
                                       class="layui-input">
                            </c:if>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">手机号</label>
                        <div class="layui-input-inline">
                            <input type="text" name="phone" class="layui-input" value="${user.phone}"/>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">机构</label>
                        <div class="layui-input-inline">
                            <select name="organizationId" lay-verify="required" lay-search="">
                                <option value="">请选择</option>
                                <c:forEach items="${organizations}" var="organization">
                                    <c:if test="${user.organizationId==organization.id}">
                                        <option value="${organization.id}" selected>${organization.orgName}</option>
                                    </c:if>
                                    <c:if test="${user.organizationId!=organization.id}">
                                        <option value="${organization.id}">${organization.orgName}</option>
                                    </c:if>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label"></label>

                        <c:if test="${option=='add'}">
                            <button class="layui-btn" onclick="add();">添加</button>
                        </c:if>
                        <c:if test="${option=='edit'}">
                            <button class="layui-btn" onclick="edit();">修改</button>
                        </c:if>
                    </div>
                    <input type="hidden" name="id" value="${user.id}"/>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
