<%@page import = "java.util.Date" import="my_pack.beans.*" import="my_pack.tools.* java.text.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title" align="center"><%=r.get("research")%></H3>

<table width="90%" border="1">
    <tr><td align="center"><b>Правая почка</b> <%=r.getSelect("r_pochka")%></td></tr>
</table>

<div id="display8" style="display:none;position:relative; left:12;">
    <table width="90%" border="1">
        <tr><td><%=r.get("r_pochka_izm")%></td></tr>        
    </table>
</div>

<div id="display9" style="display:none;position:relative; left:12;">
    <table width="90%" border="1">
        <tr><td width="35%">Размеры</td>
            <td colspan="2"><%=r.getSizeInput("r_razm_poch_1")%> мм <%=r.getSizeInput("r_razm_poch_2")%> мм</td>
        </tr>
        <tr><td>Контуры</td>
            <td colspan="2"><%=r.getSelect("r_kontur_poch")%></td>
        </tr>
        <tr><td>Толщина паренхимы в средней трети</td>
            <td colspan="2"><%=r.getSizeInput("r_tolsh_paren_1")%> мм <%=r.getSizeInput("r_tolsh_paren_2")%> мм <%=r.getSizeInput("r_tolsh_paren_3")%> мм</td>
        </tr>
        <tr><td>Эхогенность паренхимы</td>
            <td colspan="2"><%=r.getSelect("r_eho_paren")%> </td>
        </tr>
        <tr><td>Кортико-медуллярная дифференциация</td>
            <td colspan="2"><%=r.getSelect("r_differ")%> </td>
        </tr>
        <tr><td>Чашечно - лоханочная система</td>
            <td><%=r.getSelect("r_chash")%></td>
            <td><%=r.getChangeHidden("r_chash", "10", "935")%>
                    за счет<br>
                    <%=r.getCheckbox("r_chash_check")%> <%=r.getSelect("r_chash_local")%>
                    до <%=r.getSizeInput("r_chash_size")%> мм<br>
                    <%=r.getCheckbox("r_lohanki")%> до <%=r.getSizeInput("r_lohan_size")%> мм
                </div>
            </td></tr>
        <tr><td colspan="3"> <%=r.get("r_pochka_text")%></td></tr>
        <tr><td>В проекции надпочечников </td>
            <td colspan="2"><%=r.getSelect("r_nadpoch")%> </td>
        </tr>
        <tr><td colspan="3"> <%=r.get("r_nadpoch_text")%></td></tr>
    </table>
</div>

<SCRIPT LANGUAGE="JavaScript">
    changeHidden9();
    document.protocol.r_pochka.onchange  = changeHidden9
    function changeHidden9()
    {
        if(document.protocol.r_pochka.value == "922" || document.protocol.r_pochka.value == "923" || document.protocol.r_pochka.value == "924")
        {   display8.style.display = "none";
            display9.style.display = "";
        }
        if(document.protocol.r_pochka.value == "925" || document.protocol.r_pochka.value == "926" || document.protocol.r_pochka.value == "927")
        {   display8.style.display = "";
            display9.style.display = "";
        }
        if(document.protocol.r_pochka.value == "928")
        {   display8.style.display = "";
            display9.style.display = "none";
        }
    }
</SCRIPT>

<table width="90%" border="1">
    <tr><td align="center"><b>Левая почка</b> <%=r.getSelect("l_pochka")%></td></tr>
</table>

<div id="display11" style="display:none;position:relative; left:12;">
    <table width="90%" border="1">
        <tr><td><%=r.get("l_pochka_izm")%></td></tr>        
    </table>
</div>

<div id="display12" style="display:none;position:relative; left:12;">
    <table width="90%" border="1">
        <tr><td width="35%">Размеры</td>
            <td colspan="2"><%=r.getSizeInput("l_razm_poch_1")%> мм <%=r.getSizeInput("l_razm_poch_2")%> мм</td>
        </tr>
        <tr><td>Контуры</td>
            <td colspan="2"><%=r.getSelect("l_kontur_poch")%></td>
        </tr>
        <tr><td>Толщина паренхимы в средней трети</td>
            <td colspan="2"><%=r.getSizeInput("l_tolsh_paren_1")%> мм <%=r.getSizeInput("l_tolsh_paren_2")%> мм <%=r.getSizeInput("l_tolsh_paren_3")%> мм</td>
        </tr>
        <tr><td>Эхогенность паренхимы</td>
            <td colspan="2"><%=r.getSelect("l_eho_paren")%> </td>
        </tr>
        <tr><td>Кортико-медуллярная дифференциация</td>
            <td colspan="2"><%=r.getSelect("l_differ")%> </td>
        </tr>
        <tr><td>Чашечно - лоханочная система</td>
            <td><%=r.getSelect("l_chash")%></td>
            <td><%=r.getChangeHidden("l_chash", "13", "935")%>
                    за счет<br>
                    <%=r.getCheckbox("l_chash_check")%> <%=r.getSelect("l_chash_local")%>
                    до <%=r.getSizeInput("l_chash_size")%> мм<br>
                    <%=r.getCheckbox("l_lohanki")%> до <%=r.getSizeInput("l_lohan_size")%> мм
                </div>
            </td></tr>
        <tr><td colspan="3"> <%=r.get("l_pochka_text")%></td></tr>
        <tr><td>В проекции надпочечников </td>
            <td colspan="2"><%=r.getSelect("l_nadpoch")%> </td>
        </tr>
        <tr><td colspan="3"> <%=r.get("l_nadpoch_text")%></td></tr>
    </table>
</div>

<SCRIPT LANGUAGE="JavaScript">
    changeHidden12();
    document.protocol.l_pochka.onchange  = changeHidden12
    function changeHidden12()
    {
        if(document.protocol.l_pochka.value == "922" || document.protocol.l_pochka.value == "923" || document.protocol.l_pochka.value == "924")
        {   display11.style.display = "none";
            display12.style.display = "";
        }
        if(document.protocol.l_pochka.value == "925" || document.protocol.l_pochka.value == "926" || document.protocol.l_pochka.value == "927")
        {   display11.style.display = "";
            display12.style.display = "";
        }
        if(document.protocol.l_pochka.value == "928")
        {   display11.style.display = "";
            display12.style.display = "none";
        }
    }
</SCRIPT>

<%@include file="footer.jsp"%>
