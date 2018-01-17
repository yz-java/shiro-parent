<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="../main.jsp"%>
<title>修改密码</title>
</head>
<body>
<div class="container-fluid">
	<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
		<ul class="layui-tab-title">
			<li class="layui-this">修改密码</li>
		</ul>
		<div class="layui-tab-content">
			<div class="layui-tab-item layui-show text-center">
				<form class="form-horizontal" method="post" id="cpform">
					<div class="form-group">
						<label class="col-sm-4 control-label" for="newPassword">新密码</label>
						<div class="col-sm-4">
							<input id="newPassword" type="text" name="newPassword" id="newPassword" placeholder="输入新密码" class="form-control"/>
						</div>
					</div>
					<br/>
					<div class="form-group">
						<a href="javascript:void(0)" name="submit" onclick="document.getElementById('cpform').submit();" class="layui-btn">${op}</a>
					</div>
				</form>
			</div>
		</div>
	</div>

</div>
</body>
</html>