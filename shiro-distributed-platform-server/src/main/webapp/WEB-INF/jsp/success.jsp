<%--
  Created by IntelliJ IDEA.
  User: yangzhao
  Date: 17/12/17
  Time: 13:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h1>
    操作成功，3秒后返回
</h1>
<script type="application/javascript">
    setTimeout(function () {
        window.history.back()
    },3000)
</script>
</body>
</html>
