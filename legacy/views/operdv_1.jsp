<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>





<br>
<table width="100%" border="0" font face="arial" size="20">
    <tr height="20"> 
        <td> Показания: <%=r.get("pokaz_"+count)%>
        </td>
    </tr>
    <tr height="40"> 
        <td>Обезболивание: <%=r.get("obezb_"+count)%>
        </td>
    </tr>
    
    <tr height="40"> 
        <td>Описание: <%=r.get("opis_"+count)%>
        </td>
    </tr>
    <tr> 
        
</table>


 
