<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="application/javascript">
    layui.use('layer', function(){
        var $ = layui.jquery, layer = layui.layer;
        var msg = $("#windowMsg").val();
        if (msg!=null&&msg!=''){
            layer.msg(msg);
        }
    })
</script>
<input type="hidden" id="windowMsg" value="${window.msg}">
