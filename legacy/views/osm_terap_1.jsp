<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>






<table width="100%" border="0" font face="arial" size="20">
    <tr height="30"> 
        <td> Жалобы: <%=r.get("jalob_"+count)%>
        </td>
    </tr>
     <tr height="30"> 
        <td> Анамнез: <%=r.get("anam_"+count)%>
        </td>
    </tr>
         <tr height="30"> 
        <td>Объективно: <%=r.get("obekt_"+count)%>
        </td>
    </tr>
    
    <tr height="40"> 
        <td>Диагноз: <%=r.get("dsss_"+count)%>
        </td>
    </tr>
    <tr> 
        <td>&nbsp;
        </td>
    </tr>
    <tr height="10"> 
        <td><b>Заключение: в своей профессии:  <%=r.get("zakl_"+count)%>  </b>
        </td>
    </tr>
    <tr height="30"> 
        <td><%if(!r.empty("rekom_"+count)){%>   Рекомендовано: <%=r.get("rekom_"+count)%><%}%>
            <%if(r.empty("rekom_"+count)){%>&nbsp;<%}%>
        </td>
    </tr>
    <tr height="30"> 
        <td><%if(!r.empty("lech_"+count)){%>  Лечение: <%=r.get("lech_"+count)%>  <%}%>
            <%if(r.empty("lech_"+count)){%>&nbsp;<%}%>
        </tr>
    <tr height="30"> 
        <td>Диспансерное наблюдение по <%=r.get("disp_"+count)%>  гр. 
        <%if(!r.empty("disp_text_"+count)){%> у  <%=r.get("disp_text_"+count)%>  <%}%>
            <%if(r.empty("disp_text_"+count)){%>&nbsp;<%}%>
         </td>
    </tr>
</table>


 
