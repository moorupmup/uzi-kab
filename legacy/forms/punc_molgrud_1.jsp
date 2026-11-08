<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title">ПУНКЦИЯ МОЛОЧНОЙ/ГРУДНОЙ ЖЕЛЕЗЫ</H3>    

<table border="1">
<tr> 
    <td class="simple_str">День цикла
        <%=r.getSizeInput("den")%>
        <SCRIPT LANGUAGE="JavaScript">
            document.protocol.den.focus();
            document.protocol.den.onkeyup = point
            function point(){
                if (document.protocol.den.value.length == 2) document.protocol.den.value += ".";
            }
         </script>
    </td>
</tr>
<tr> 
    <td class="simple_str">Кожный покров
        <%=r.getSelect("pokrov")%>
        <%=r.getSizeInput("pokrov_how")%>мм
    </td>
</tr>
<tr> 
    <td class="simple_str">Область соска
        <%=r.getSelect("sosok")%>
    </td>
</tr>
<tr> 
    <td class="simple_str">Молочные железы представлены 
        <%=r.getSelect("jeleza")%>
    </td>
</tr>
<tr>
    <td> Паренхима
        <%=r.getSelect("parenhima")%>
    </td>
</tr>
<tr> 
    <td class="simple_str">Млечные протоки
          <%=r.getSelect("protoki")%>
        до
          <%=r.getSizeInput("protoki_how")%>     
      <font class="ed_izm">мм</font>
    </td>
</tr>
<tr> 
    <td class="simple_str">Региональные лимфатические узлы
         <%=r.getSelect("limf")%>
        до 
        <%=r.getSizeInput("limf_how")%>      
        <font class="ed_izm">мм</font>
    </td>
</tr>
<tr>
    <td>Соединительная ткань
        <%=r.getSelect("tkani")%>
    </td>
</tr>
</table>

<%@include file="footer.jsp"%>
