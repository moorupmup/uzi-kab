<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>

<H3 class="p_title">УЗИ при беременности</H3>
<table width="90%" border="1">
    <tr> 
        <td>Первый день последней менструации</td>
        <td colspan="2">
            &nbsp;
        </td>
    </tr>
    <tr> 
        <td>Срок беременности</td>
        <td colspan="2">
            <%=r.getSizeInput("srok_berem")%> нед.
            <SCRIPT LANGUAGE="JavaScript">
            document.protocol.srok_berem.focus();
            </script>
        </td>
    </tr>
    <tr>
        <td class="simple_str" width="35%">В матке определяется
        </td>
        <td colspan="2">
            <%=r.getSelect("plod")%>
        </td>
    </tr>
    <tr>
        <td>Положение</td>
        <td colspan="2">
            <%=r.getSelect("poloj")%>
        </td>
    </tr>
    <tr>
        <td>Органы и системы</td>
        <td colspan="2">
            <%=r.getSelect("organ")%>
            <%=r.getTextInput("organ_text")%>
        </td>
    </tr>
    <tr>
        <td>Сердцебиение</td>
        <td colspan="2">
            <%=r.getSelect("serdce")%>
        </td>
    </tr>
    <tr>
        <td>Длина костной части спинки носа плода</td>
        <td colspan="2">
            <%=r.getSizeInput("nos")%>мм.
        </td>
    </tr>
    <tr>
        <td>Диаметр глазницы</td>
        <td colspan="2">
            <%=r.getSizeInput("diam_glaz")%>мм.
        </td>
    </tr>
    <tr>
        <td>Воротниковие пространство</td>
        <td colspan="2">
            <%=r.getSizeInput("vorot")%>мм.
        </td>
    </tr>
    <tr>
        <td colspan="3">Размеры(первый плод):
            BPD <%=r.getSizeInput("bpd1")%>мм
            FL <%=r.getSizeInput("fl1")%>мм
            AC <%=r.getSizeInput("ac1")%>мм
        </td>
    </tr>
    <tr>
        <td colspan="3">Масса(первый плод):
            <%=r.getSizeInput("massa1")%>гр.
        </td>
    </tr>
    <tr>
        <td>По всем параметрам соответствует</td>
        <td colspan="2">
            <%=r.getSizeInput("srok1")%>нед.
        </td>
    </tr>
    <tr>
        <td colspan="3">Размеры(второй плод):
            BPD <%=r.getSizeInput("bpd2")%>мм
            FL <%=r.getSizeInput("fl2")%>мм
            AC <%=r.getSizeInput("ac2")%>мм
        </td>
    </tr>
    <tr>
        <td colspan="3">Масса(второй плод):
            <%=r.getSizeInput("massa2")%>гр.
        </td>
    </tr>
    <tr>
        <td>По всем параметрам соответствует</td>
        <td colspan="2">
            <%=r.getSizeInput("srok2")%>нед.
        </td>
    </tr>
    <tr>
        <td>Локализация плаценты</td>
        <td colspan="2">
            <%=r.getSelect("plac")%> по
            <%=r.getSelect("perehod")%> с переходом на<%=r.getSelect("perehod_na")%><%=r.getTextInput("plac_text")%>
        </td>
    </tr>
    <tr>
        <td>Степень зрелости</td>
        <td colspan="2">
            <%=r.getSelect("second_zrelost")%>
        </td>
    </tr>
    <tr> 
        <td>Толщина плаценты</td>
        <td colspan="2">
            <%=r.getSelect("second_tolshina")%>
            <span class="simple_str">до</span> 
            <%=r.getSizeInput("second_tolshina_how")%>
            <font class="ed_izm">мм</font>
            <%=r.getTextInput("second_tolshina_text")%>
        </td>
    </tr>
    <tr>
        <td>Количество околоплодных вод</td>
        <td colspan="2">
            <%=r.getSelect("water")%>
        </td>
    </tr>
    <tr>
        <td colspan="3">Кровоток в венозном протоке плода (первого)
            <%=r.getSelect("krovotok1")%>
        </td>
    </tr>
    <tr>
        <td colspan="3">Кровоток в венозном протоке плода (второго)
            <%=r.getSelect("krovotok2")%>
        </td>
    </tr>
    <tr>
        <td>Внутренний зев</td>
        <td colspan="2">
            <%=r.getSelect("zev")%>
        </td>
    </tr>
</table>

<%@include file="footer.jsp"%>
