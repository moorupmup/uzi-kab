<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title" align="center">Дуплексное сканирование экстракраниальных артерий</H3>

<table width="100%" border="1">
    <tr><td colspan="4" align="center"><b>Внутренние диаметры экстракраниальных артерий</b>
        </td>
    </tr>

    <tr><td width="25%" align="center"> Артерия</td> 
        <td align="center"> Диаметр (мм)</td> 
        <td width="25%" align="center"> Артерия</td> 
        <td align="center"> Диаметр (мм)</td> 
    </tr>
    <tr>
        <td align="center" > Правая ОСА</td>
        <td align="center"> <%=r.getSizeInput("osa_r_diam")%></td> 
        <SCRIPT LANGUAGE="JavaScript">
            document.protocol.osa_r_diam.focus();
        </script>
        <td align="center"> Правая ВСА </td>
        <td align="center"><%=r.getSizeInput("bsa_r_diam")%></td> 
    </tr>
    <tr>        
        <td align="center"> Правая НСА </td>
        <td align="center"> <%=r.getSizeInput("nsa_r_diam")%></td> 
        <td align="center"> Правая ПА </td>
        <td align="center"><%=r.getSizeInput("pa_r_diam")%></td> 
    </tr>
    <tr>
        <td align="center"> Левая ОСА </td>
        <td align="center"> <%=r.getSizeInput("osa_l_diam")%></td> 
        <td align="center"> Левая ВСА </td>
        <td align="center"><%=r.getSizeInput("bsa_l_diam")%></td> 
    </tr>
    <tr>
        <td align="center"> Левая НСА </td>
        <td align="center"> <%=r.getSizeInput("nsa_l_diam")%></td> 
        <td align="center"> Левая ПА </td>
        <td align="center"> <%=r.getSizeInput("pa_l_diam")%></td> 
    </tr>
</table>


<%@include file="footer.jsp"%>
