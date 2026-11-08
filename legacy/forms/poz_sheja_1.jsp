<%@page import = "java.util.Date" import="my_pack.beans.*" import="my_pack.tools.* java.text.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title" align="center"><%=r.get("research")%></H3>

<table width="90%" border="1">
    <tr><td width="40%"><b>Непрозрачны на уровне:</b> </td>
        <td><%=r.getCheckbox("nep_disk")%> </td>
        <td><%=r.getCheckbox("nep_disk1")%></td>
        <td><%=r.getCheckbox("nep_disk2")%></td>
        <td><%=r.getCheckbox("nep_disk3")%></td>
        <td><%=r.getCheckbox("nep_disk4")%></td>
        <td><%=r.getCheckbox("nep_disk5")%></td>
    </tr>
    <tr><td><b>Не выявлено структурных изменений дисков:</b></td> 
        <td><%=r.getCheckbox("izm_disk")%> </td>
        <td><%=r.getCheckbox("izm_disk1")%></td>
        <td><%=r.getCheckbox("izm_disk2")%></td> 
        <td><%=r.getCheckbox("izm_disk3")%></td> 
        <td><%=r.getCheckbox("izm_disk4")%></td> 
        <td><%=r.getCheckbox("izm_disk5")%></td>
    </tr>
    <tr><td><b><%=r.getCheckbox("struk_izm")%></b></td>
        <td colspan="6">
            <%=r.getCheckbox("struk1")%><br>
            <%=r.getCheckbox("struk2")%><br>
            <%=r.getCheckbox("struk3")%>
        </td> 
    </tr>
</table>

<div id="display1" style="display:none;position:relative; left:12;">
    <table width="90%" border="1">  
        <tr><td>на уровне:</td>
            <td><%=r.getCheckbox("str_disk")%> </td>
            <td><%=r.getCheckbox("str_disk1")%></td>
            <td><%=r.getCheckbox("str_disk2")%></td> 
            <td><%=r.getCheckbox("str_disk3")%></td> 
            <td><%=r.getCheckbox("str_disk4")%></td> 
            <td><%=r.getCheckbox("str_disk5")%></td>
        </tr>
        <tr><td colspan="7">Степень выраженности указанных изменений <%=r.getSelect("vir_izm")%></td></tr>
    </table>
</div>

<SCRIPT LANGUAGE="JavaScript">
    changeHidden1();
    document.protocol.struk_izm.onclick  = changeHidden1
    function changeHidden1()
    {
        if(document.protocol.struk_izm.checked == true)
            display1.style.display = "";
        else
            display1.style.display = "none";
    }
</SCRIPT>

<table width="90%" border="1">
    <tr><td colspan="7"><b>Спинномозговой канал не изменен на уровне:</b></td></tr>
    <tr><td width="5%">&nbsp;</td>
        <td width="25 %"><%=r.getCheckbox("kanal_disk")%> </td>
        <td width="10%"><%=r.getCheckbox("kanal_disk1")%></td>
        <td width="10%"><%=r.getCheckbox("kanal_disk2")%></td> 
        <td width="10%"><%=r.getCheckbox("kanal_disk3")%></td> 
        <td width="10%"><%=r.getCheckbox("kanal_disk4")%></td> 
        <td><%=r.getCheckbox("kanal_disk5")%><br>
            каналы корешковых нервов симметричны</td>
    </tr>
    <tr><td colspan="7"><b>Спинномозговой канал подвержен сужению и деформации на уровне:</b></td></tr>
    <tr><td>&nbsp;</td>
        <td><%=r.getCheckbox("def_disk")%> </td>
        <td><%=r.getCheckbox("def_disk1")%></td>
        <td><%=r.getCheckbox("def_disk2")%></td> 
        <td><%=r.getCheckbox("def_disk3")%></td> 
        <td><%=r.getCheckbox("def_disk4")%></td> 
        <td><%=r.getCheckbox("def_disk5")%></td>
    </tr>
    <tr><td colspan="7"><b>Пролабирование контура диска без разрыва фиброзного кольца по дуге большого радиуса до <%=r.getSizeInput("prolab_mm")%> мм</b></td></tr>
    <tr><td>&nbsp;</td>
        <td>на уровне: <%=r.getCheckbox("prol_disk")%> </td>
        <td><%=r.getCheckbox("prol_disk1")%></td>
        <td><%=r.getCheckbox("prol_disk2")%></td> 
        <td><%=r.getCheckbox("prol_disk3")%></td> 
        <td><%=r.getCheckbox("prol_disk4")%></td> 
        <td><%=r.getCheckbox("prol_disk5")%>
    </tr>
    <tr><td colspan="7"><b>Выявлен разрыв фиброзного кольца и выбухание контура диска по дуге малого радиуса до <%=r.getSizeInput("raz_vib_mm")%> мм</b></td></tr>
    <tr><td>&nbsp;</td>
        <td>на уровне: <%=r.getCheckbox("raz_disk")%> </td>
        <td><%=r.getCheckbox("raz_disk1")%></td>
        <td><%=r.getCheckbox("raz_disk2")%></td> 
        <td><%=r.getCheckbox("raz_disk3")%></td> 
        <td><%=r.getCheckbox("raz_disk4")%></td> 
        <td><%=r.getCheckbox("raz_disk5")%>
    </tr>
    <tr><td colspan="7"><b>Гипертрофия желтой связки на уровне</B></td></tr>
    <tr><td>&nbsp;</td>
        <td><%=r.getCheckbox("gip_disk")%> </td>
        <td><%=r.getCheckbox("gip_disk1")%></td>
        <td><%=r.getCheckbox("gip_disk2")%></td> 
        <td><%=r.getCheckbox("gip_disk3")%></td> 
        <td><%=r.getCheckbox("gip_disk4")%></td> 
        <td><%=r.getCheckbox("gip_disk5")%>
    </tr>
    <tr><td colspan="7"><b>Признаки рубцового эпидурита на уровне</b></td></tr>
    <tr><td>&nbsp;</td>
        <td><%=r.getCheckbox("rub_disk")%> </td>
        <td><%=r.getCheckbox("rub_disk1")%></td>
        <td><%=r.getCheckbox("rub_disk2")%></td> 
        <td><%=r.getCheckbox("rub_disk3")%></td> 
        <td><%=r.getCheckbox("rub_disk4")%></td> 
        <td><%=r.getCheckbox("rub_disk5")%>
    </tr>
    <tr><td colspan="7"><b>Костная деформация</b></td></tr>
    <tr><td>&nbsp;</td>
        <td><%=r.getCheckbox("def_1")%><br>
            <%=r.getCheckbox("def_2")%><br>
            <%=r.getCheckbox("def_3")%><br>
            <%=r.getCheckbox("def_4")%><br>
            <%=r.getCheckbox("def_5")%></td>
        <td>на уровне</td>
        <td colspan="5">
            <%=r.getCheckbox("kost_disk")%> <br>
            <%=r.getCheckbox("kost_disk1")%><br>
            <%=r.getCheckbox("kost_disk2")%><br> 
            <%=r.getCheckbox("kost_disk3")%><br> 
            <%=r.getCheckbox("kost_disk4")%><br> 
            <%=r.getCheckbox("kost_disk5")%>
        </td>
    </tr>
    <tr><td colspan="7"><b>При осмотре из заднего доступа <%=r.getSelect("zad_sel")%></b><br>                               
        <%=r.getTextAreaInput("zad_txt",3,80)%></td>
    </tr>
</table>

<table width="90%" border="1">
    <tr><td><b>Функциональные пробы</b></td></tr>
    <tr><td><%=r.getSelect("f_proba")%></td></tr>
</table>

<div id="display2" style="display:none;position:relative; left:12;">
    <table width="90%" border="1">  
        <tr><td colspan="7"><b>сгибательной пробе - антелистез</b> на <%=r.getSizeInput("ant_proba")%> мм</td></tr>
        <tr><td width="20%" align="right">на уровне:</td>
            <td><%=r.getCheckbox("ant_disk")%> </td>
            <td><%=r.getCheckbox("ant_disk1")%></td>
            <td><%=r.getCheckbox("ant_disk2")%></td> 
            <td><%=r.getCheckbox("ant_disk3")%></td> 
            <td><%=r.getCheckbox("ant_disk4")%></td> 
            <td><%=r.getCheckbox("ant_disk5")%></td>
        </tr>
        <tr><td colspan="7"><b>разгибательной пробе - ретролистез</b> на <%=r.getSizeInput("ret_proba")%> мм</td></tr>
        <tr><td align="right">на уровне:</td>
            <td><%=r.getCheckbox("ret_disk")%> </td>
            <td><%=r.getCheckbox("ret_disk1")%></td>
            <td><%=r.getCheckbox("ret_disk2")%></td> 
            <td><%=r.getCheckbox("ret_disk3")%></td> 
            <td><%=r.getCheckbox("ret_disk4")%></td> 
            <td><%=r.getCheckbox("ret_disk5")%></td>
        </tr>
    </table>
</div>

<SCRIPT LANGUAGE="JavaScript">
    changeHidden2();
    document.protocol.f_proba.onchange  = changeHidden2
    function changeHidden2()
    {
        if(document.protocol.f_proba.value == "1002")
            display2.style.display = "";
        else
            display2.style.display = "none";
    }
</SCRIPT>

<%@include file="footer.jsp"%>
