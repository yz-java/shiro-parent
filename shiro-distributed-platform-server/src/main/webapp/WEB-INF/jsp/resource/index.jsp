<%--
  Created by IntelliJ IDEA.
  User: yangzhao
  Date: 17/12/15
  Time: 19:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="../main.jsp"%>
    <title>Title</title>
    <script type="application/javascript">
        $(document).ready(function(){
            var height = $(window).height();
            $("iframe").each(function(){
                $(this).attr('style','border:0;height:'+height+'px;margin:0;padding:0')
            })
        })
    </script>
</head>
<body>
<div class="container-fluid">

    <iframe src="/resource/tree" class="col-xs-2"></iframe>

    <iframe src="/resource/search" class="col-xs-10"></iframe>
</div>
</body>
</html>
