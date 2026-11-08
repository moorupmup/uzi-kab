<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title" align="center">Ультразвуковое исследование плечевых суставов</H3>

<table width="100%" border="1">
    <tr> 
        <td colspan="3" class="simple_str" align="center"><b>Правый плечевой сустав</b>
        </td>
    <tr> 
        <td colspan="2" class="simple_str">Целостность ротарной манжетки
        </td>
        <td width="50%"><%=r.getSelect("mang_r")%></td>
        <SCRIPT LANGUAGE="JavaScript">
            document.protocol.mang_r.focus();
        </script>
    </tr>
    <tr> 
        <td colspan="3" class="simple_str"><b>Структура сухожилий</b></td>
    </tr>
    <tr> 
        <td width="25%" class="simple_str">&nbsp;</td>
        <td colspan="2">
            надостной мышцы
            <%=r.getSelect("nadost_r")%>
        </td>
    </tr>
    <tr> 
        <td width="25%" class="simple_str">&nbsp;</td>
        <td colspan="2">
            подостной мышцы
            <%=r.getSelect("podost_r")%>
        </td>
    </tr>
    <tr> 
        <td width="25%" class="simple_str">&nbsp;</td>
        <td colspan="2">
            подлопаточной мышцы
            <%=r.getSelect("podlop_r")%>
        </td>
    </tr>
    <tr> 
        <td colspan="2" class="simple_str">Поддельтовидная сумка</td>
        <td>
            <%=r.getSelect("poddelto_r")%>
        </td>
    </tr>
    <tr>
        <td colspan="3" class="simple_str">
            Дельтовидная мышца <%=r.getSelect("delto_r")%>, ход волокон ее <%=r.getSelect("volokna_r")%>
        </td>
    </tr>
    <tr>
        <td colspan="2" class="simple_str">Контур плечевой кости</td>
        <td>
            <%=r.getSelect("kontur_r")%>
        </td>
    </tr>
    <tr>
        <td colspan="2" class="simple_str">Сухожилие двуглавой мышцы плеча</td>
        <td>
            <%=r.getSelect("dvuglavo_r")%>
        </td>
    </tr>
    <tr>
        <td colspan="2" class="simple_str">Целостность ключично - акромиального сочленения</td>
        <td>
            <%=r.getSelect("sochlen_r")%>
        </td>
    </tr>
    <tr>
        <td colspan="2" class="simple_str">Свободной жидкости</td>
        <td>
            <%=r.getSelect("gidkost_r")%>
        </td>
    </tr>

</table>


<table width="100%" border="1">
    <tr> 
        <td colspan="3" class="simple_str" align="center"><b>Левый плечевой сустав</b>
        </td>
    <tr> 
        <td colspan="2" class="simple_str">Целостность ротарной манжетки
        </td>
        <td width="50%"><%=r.getSelect("mang_l")%></td>
    </tr>
    <tr> 
        <td colspan="3" class="simple_str"><b>Структура сухожилий</b></td>
    </tr>
    <tr> 
        <td width="25%" class="simple_str">&nbsp;</td>
        <td colspan="2">
            надостной мышцы
            <%=r.getSelect("nadost_l")%>
        </td>
    </tr>
    <tr> 
        <td width="25%" class="simple_str">&nbsp;</td>
        <td colspan="2">
            подостной мышцы
            <%=r.getSelect("podost_l")%>
        </td>
    </tr>
    <tr> 
        <td width="25%" class="simple_str">&nbsp;</td>
        <td colspan="2">
            подлопаточной мышцы
            <%=r.getSelect("podlop_l")%>
        </td>
    </tr>
    <tr> 
        <td colspan="2" class="simple_str">Поддельтовидная сумка</td>
        <td>
            <%=r.getSelect("poddelto_l")%>
        </td>
    </tr>
    <tr>
        <td colspan="3" class="simple_str">
            Дельтовидная мышца <%=r.getSelect("delto_l")%>, ход волокон ее <%=r.getSelect("volokna_l")%>
        </td>
    </tr>
    <tr>
        <td colspan="2" class="simple_str">Контур плечевой кости</td>
        <td>
            <%=r.getSelect("kontur_l")%>
        </td>
    </tr>
    <tr>
        <td colspan="2" class="simple_str">Сухожилие двуглавой мышцы плеча</td>
        <td>
            <%=r.getSelect("dvuglavo_l")%>
        </td>
    </tr>
    <tr>
        <td colspan="2" class="simple_str">Целостность ключично - акромиального сочленения</td>
        <td>
            <%=r.getSelect("sochlen_l")%>
        </td>
    </tr>
    <tr>
        <td colspan="2" class="simple_str">Свободной жидкости</td>
        <td>
            <%=r.getSelect("gidkost_l")%>
        </td>
    </tr>

</table>

<%@include file="footer.jsp"%>
