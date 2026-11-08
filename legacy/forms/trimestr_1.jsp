<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title" align="center"><%=r.get("research")%></H3>
<table width="80%" border="1">
    <tr><td colspan="2">Первый день последней менструации 
        <%=r.getTextInput("mens_text")%> </td>
        <SCRIPT LANGUAGE="JavaScript">
            document.protocol.mens_text.focus();
        </script>
    </tr>
    <tr><td>Срок беременности </td>
        <td><%=r.getSizeInput("ned_text")%> нед</td>
    </tr>
    <tr><td colspan="2" align="center"><b>Плод:</b></td>
    </tr>
    <tr><td colspan="2">Определяется один живой плод </td></tr>
    <tr><td>Предлежащая часть</td>
        <td><%=r.getTextInput("plod")%></td>
    </tr>
    <tr><td>Положение плода</td>
        <td><%=r.getSelect("poloj_plod")%></td>
    </tr>
    <tr><td>Сердечная деятельность</td>
        <td><%=r.getTextInput("serd")%></td>
    </tr>
    <tr><td colspan="2" align="center"><b>Фетометрия:</b></td>
    </tr>
    <tr><td>БПР </td>
        <td><%=r.getTextInput("bpr")%></td>
    </tr>
    <tr><td>ЛЗ</td>
        <td><%=r.getTextInput("sdj")%></td>
    </tr>
    <tr><td>ОГ </td>
        <td><%=r.getTextInput("og")%></td>
    </tr>
    <tr><td>ОЖ </td>
        <td><%=r.getTextInput("oj")%></td>
    </tr>
    <tr><td>ДБК</td>
        <td><%=r.getTextInput("dbk")%></td>
    </tr>
    <tr><td colspan="2">Дополнительные измерения<br>
         <%=r.getTextAreaInput("dop_iz",3,80)%></td>
    </tr>
    <tr><td>Размеры плода </td>
        <td><%=r.getSelect("razmer_p")%> <%=r.getSizeInput("ned_ber")%> неделям беременности</td>
    </tr>
    <tr><td>Предпологаемая масса</td>
        <td> <%=r.getSizeInput("massa")%> г</td>
    </tr>

    <tr><td colspan="2" align="center"><b>Плацента и околоплодные воды:</b></td>
    </tr>
    <tr><td>Преимущественная докализация плаценты </td>
        <td><%=r.getSelect("placenta1")%><%=r.getSelect("placenta2")%></td>
    </tr>
    <tr><td>Толщина плаценты </td>
        <td><%=r.getTextInput("tolsh_p")%></td>
    </tr>
    <tr><td>Струкртура плаценты </td>
        <td><%=r.getTextInput("struct_plac")%></td>
    </tr>    
    <tr><td>Количество околоплодных вод</td>
        <td><%=r.getSelect("okolop_v")%></td>
    </tr>    
    <tr><td>УЗДГ плода:плодово-плацентарный кровоток</td>
        <td>С/Д <%=r.getSizeInput("pp_sd")%>  ИР <%=r.getSizeInput("pp_ir")%> <%=r.getSelect("pp_norma")%></td>
    </tr>
    <tr><td>маточно-плацентарный кровоток</td>
        <td>С/Д <%=r.getSizeInput("mp_sd")%>  ИР <%=r.getSizeInput("mp_ir")%> <%=r.getSelect("mp_norma")%></td>
    </tr>
    <tr><td>Почки беременной</td>
        <td><%=r.getTextInput("poch_ber")%></td>
    </tr>
</table>
<%@include file="footer.jsp"%>
