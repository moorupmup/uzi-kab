<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>


<table width="100%" border="0">
    <tr><td colspan="4" align="center"><b>Внутренние диаметры экстракраниальных артерий</b>
        </td>
    </tr>

    <tr><td width="25%" align="center"> Артерия</td> 
        <td width="25%" align="center"> Диаметр (мм)</td> 
        <td width="25%" align="center"> Диаметр (мм)</td> 
        <td align="center">Артерия</td> 
    </tr>
    <tr><td align="center"> Правая ОСА </td>
        <td align="center"><%=r.get("osa_r_diam")%></td>
        <td align="center"><%=r.get("osa_l_diam")%></td>
        <td align="center"> Левая ОСА  </td> 
    </tr> 

    <tr><td align="center"> Правая ВСА </td>
        <td  align="center"><%=r.get("bsa_r_diam")%></td>
        <td align="center"><%=r.get("bsa_l_diam")%></td> 
        <td align="center"> Левая ВСА</td>
    </tr> 

    <tr><td align="center"> Правая НСА </td>
        <td align="center"><%=r.get("nsa_r_diam")%></td>
        <td align="center"><%=r.get("nsa_l_diam")%></td> 
        <td align="center"> Левая НСА</td>
    </tr> 

    <tr><td align="center"> Правая ПА </td>
        <td align="center"><%=r.get("pa_r_diam")%></td> 
        <td align="center"><%=r.get("pa_l_diam")%></td>
        <td align="center"> Левая ПА</td>
    </tr> 
</table>
<%if(!r.empty("addition_" + count)){%><br><b>Дополнительные признаки:</b> <%=r.get("addition_" + count)%><%}%>
<br><b>Заключение:</b> <%=r.get("decision_" + count)%> <%=r.get("decision_text_" + count)%><br>
