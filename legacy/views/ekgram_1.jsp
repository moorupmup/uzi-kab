<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>





<br>
<table width="100%" border="0" font face="arial" size="20">
    <tr height="30"> 
        <td><b>Заключение: </b>  <%=r.get("zakl_"+count)%>  
        </td>
    </tr>
   </table>


 
