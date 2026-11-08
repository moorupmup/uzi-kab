<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title" align="center">Ультразвуковое исследование плечевого сустава</H3>

<table width="100%" border="1">
    <tr> 
        <td colspan="2" class="simple_str">Целостность ротарной манжетки
        </td>
        <td width="50%"><%=r.getSelect("mang")%></td>
        <SCRIPT LANGUAGE="JavaScript">
            document.protocol.mang.focus();
        </script>
    </tr>
    <tr> 
        <td colspan="3" class="simple_str"><b>Структура сухожилий</b></td>
    </tr>
    <tr> 
        <td width="25%" class="simple_str">&nbsp;</td>
        <td colspan="2">
            надостной мышцы
            <%=r.getSelect("nadost")%>
        </td>
    </tr>
    <tr> 
        <td width="25%" class="simple_str">&nbsp;</td>
        <td colspan="2">
            подостной мышцы
            <%=r.getSelect("podost")%>
        </td>
    </tr>
    <tr> 
        <td width="25%" class="simple_str">&nbsp;</td>
        <td colspan="2">
            подлопаточной мышцы
            <%=r.getSelect("podlop")%>
        </td>
    </tr>
    <tr> 
        <td colspan="2" class="simple_str">Поддельтовидная сумка</td>
        <td>
            <%=r.getSelect("poddelto")%>
        </td>
    </tr>
    <tr>
        <td colspan="3" class="simple_str">
            Дельтовидная мышца <%=r.getSelect("delto")%>, ход волокон ее <%=r.getSelect("volokna")%>
        </td>
    </tr>
    <tr>
        <td colspan="2" class="simple_str">Контур плечевой кости</td>
        <td>
            <%=r.getSelect("kontur")%>
        </td>
    </tr>
    <tr>
        <td colspan="2" class="simple_str">Сухожилие двуглавой мышцы плеча</td>
        <td>
            <%=r.getSelect("dvuglavo")%>
        </td>
    </tr>
    <tr>
        <td colspan="2" class="simple_str">Целостность ключично - акромиального сочленения</td>
        <td>
            <%=r.getSelect("sochlen")%>
        </td>
    </tr>
    <tr>
        <td colspan="2" class="simple_str">Свободной жидкости</td>
        <td>
            <%=r.getSelect("gidkost")%>
        </td>
    </tr>

</table>

<%@include file="footer.jsp"%>
