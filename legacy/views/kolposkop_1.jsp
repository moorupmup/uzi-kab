<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>



<table width="70%" border="0">
<tr><td width="20%"> <img src="/krug2.jpg"></td>
	</tr>
</table>

Влагалище раскрыто в зеркалах. 
Шейка обработана сухим и спиртовым шариками. Произведена кольпоскопия.

<br>
<%if(!r.empty("pred_"+count)){%>
        <b>Заключение:</b> <%=r.get("pred_"+count)%><br>
<%}%>
<%if(!r.empty("rekomend_"+count)){%>
        <b>Рекомендации:</b> <%=r.get("rekomend_"+count)%><br>
<%}%>

