<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>






<table width="100%" border="0" font face="arial" size="20">
    <tr height="20"> 
        <td> Жалобы: <%=r.get("jalob_"+count)%>
        </td>
    </tr>

       <tr height="20"> 
        <td> Месячные с <%=r.get("ssss_"+count)%> по  <%=r.get("pooo_"+count)%>  дн., через <%=r.get("cher_"+count)%>  дн.
        Беременностей  <%=r.get("berem_"+count)%> роды <%=r.get("rodi_"+count)%> аборты <%=r.get("abort_"+count)%>    <%=r.get("disp_text_"+count)%>
        
    </td>
    </tr>
         



          
          <tr height="30"> 
        <td>Гинекологические заболевания <%=r.get("ginek_"+count)%>
        </td>
    </tr>
    
    <tr height="20"> 
        <td>Контрацепция <%=r.get("kontr_"+count)%>
        </td>
    </tr>

    <tr height="20"> 
        <td>Гин.осмотр:  шейка матки: <%=r.get("gin_text_"+count)%>
        </td>
    </tr>
    <tr height="20"> 
        <td>Матка <%=r.get("mat_text_"+count)%>
        </td>
    </tr>
     <tr height="20"> 
        <td>Придатки <%=r.get("pri_text_"+count)%>
        </td>        
    </tr>
      <tr height="20"> 
        <td>Выделения <%=r.get("vid_text_"+count)%>
        </td>
    </tr>
       <tr height="20"> 
        <td>Молочные железы <%=r.get("mol_text_"+count)%>
        </td>
    </tr>
    <tr height="20"> 
                          
        <td>   Взят мазок на: <%=r.get("mazo_"+count)%>

 

        </td>
    </tr>
     <tr height="30"> 
        <td>Диагноз: <%=r.get("dsss_"+count)%>
        </td>
    </tr>
    
    <tr height="20"> 
        <td><b>Заключение: в своей профессии:  <%=r.get("zakl_"+count)%>  </b>
        </td>
    </tr>
    <tr height="20"> 
        <td><%if(!r.empty("rekom_"+count)){%>   Рекомендовано: <%=r.get("rekom_"+count)%><%}%>
            <%if(r.empty("rekom_"+count)){%>&nbsp;<%}%>
        </td>
    </tr>
    <tr height="30"> 
        <td><%if(!r.empty("lech_"+count)){%>  Лечение: <%=r.get("lech_"+count)%>  <%}%>
            <%if(r.empty("lech_"+count)){%>&nbsp;<%}%>
        </tr>
    
</table>


 
