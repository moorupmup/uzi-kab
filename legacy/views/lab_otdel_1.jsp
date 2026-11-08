<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>

Дата забора <%=r.get("data")%>
<table width="100%" border="1">
    <tr><td colspan="4" align="center">
	<b>Анализ отделяемого № <%=r.get("nomer")%> гр-ки <%=r.get("gr_ki")%></b>
        </td>
    </tr>
    <tr><td width="40%">Реакция отделяемого</td> 
        <td width="20%"> Уретры</td> 
        <td width="20%"> Шейки матки</td> 
        <td>Вагины</td> 
    </tr>
    <tr><td>Гнойные клетки</td>
        <td> <%=r.get("gnoi_yr")%></td> 
        <td> <%=r.get("gnoi_sh")%></td> 
        <td> <%=r.get("gnoi_vg")%></td> 
    </tr>
    <tr><td>Лейкоциты</td>
        <td> <%=r.get("leik_yr")%></td> 
        <td> <%=r.get("leik_sh")%></td> 
        <td> <%=r.get("leik_vg")%></td> 
    </tr>

    <tr><td>Эритроциты</td>
        <td> <%=r.get("eret_yr")%></td> 
        <td> <%=r.get("eret_sh")%></td> 
        <td> <%=r.get("eret_vg")%></td> 
    </tr>

    <tr><td>Клетки пл. эпителий</td>
        <td> <%=r.get("klet_yr")%></td> 
        <td> <%=r.get("klet_sh")%></td> 
        <td> <%=r.get("klet_vg")%></td> 
    </tr>

    <tr><td>Слизь</td>
        <td> <%=r.get("sliz_yr")%></td> 
        <td> <%=r.get("sliz_sh")%></td> 
        <td> <%=r.get("sliz_vg")%></td> 
    </tr>

    <tr><td>Гонок. Нейсера</td>
        <td> <%=r.get("neis_yr")%></td> 
        <td> <%=r.get("neis_sh")%></td> 
        <td> <%=r.get("neis_vg")%></td> 
    </tr>

    <tr><td>Трихомонады</td>
        <td> <%=r.get("trih_yr")%></td> 
        <td> <%=r.get("trih_sh")%></td> 
        <td> <%=r.get("trih_vg")%></td> 
    </tr>

    <tr><td>Др. кокков и диплокок. форм</td>
        <td> <%=r.get("koki_yr")%></td> 
        <td> <%=r.get("koki_sh")%></td> 
        <td> <%=r.get("koki_vg")%></td> 
    </tr>
 
    <tr><td>Пл. Додерлейна</td>
        <td> <%=r.get("dodr_yr")%></td> 
        <td> <%=r.get("dodr_sh")%></td> 
        <td> <%=r.get("dodr_vg")%></td> 
    </tr>
	
</table>
