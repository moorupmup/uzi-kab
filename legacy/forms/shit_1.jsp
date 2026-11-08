<%@page import = "java.util.Date" import="my_pack.beans.*" import="my_pack.tools.* java.text.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<SCRIPT language="JavaScript" src="/uzi/js/validations.js"></SCRIPT>
<SCRIPT language="JavaScript" src="/uzi/js/tabnext.js "></SCRIPT>
<H3 class="p_title" align="center"><%=r.get("research")%></H3>

<table width="90%" border="1">
    <tr><td><%=r.getSelect("del")%></td></tr>
    <SCRIPT LANGUAGE="JavaScript">
    document.protocol.del.focus();
    </script>
</table>

<div id="display5" style="display:none;position:relative; left:12;">
    <table width="90%" border="1">
        <tr><td>в <%=r.getSizeInput("del_god")%> году</td></tr>
        <tr><td><%=r.getSelect("del_loje")%><br>
                <%=r.getTextAreaInput("loje_text",2,80)%></td></tr>
        <tr><td><%=r.getSelect("del_proek")%> <%=r.getSelect("del_potolog")%><br>
                <%=r.getTextAreaInput("proek_text",2,80)%></td></tr>
    </table>
</div>

<div id="display6" style="display:none;position:relative; left:12;">
    <table width="90%" border="1">
        <tr><td><%=r.getCheckbox("del1")%> <br>
                <%=r.getCheckbox("del2")%> <br>
                <%=r.getCheckbox("del3")%>
            </td></tr>
        <tr><td><%=r.getTextAreaInput("del_text",2,80)%></td></tr>
    </table>
</div>

<div id="display7" style="display:none;position:relative; left:12;">
    <table width="90%" border="1">
        <tr><td>Локализация железы</td>
            <td><%=r.getSelect("local")%></td>
            <td><%=r.getChangeHidden("local", "1", "47")%><%=r.getSizeInput("local_size")%> мм</div></td></tr>
        <tr><td>Правая доля</td>
                <td colspan="2">
                a = <%=r.getSizeInput("r_dolya_1")%> мм
                b = <%=r.getSizeInput("r_dolya_2")%> мм
                c = <%=r.getSizeInput("r_dolya_3")%> мм
                V1 = <%=r.getHidden("v1")%> см
            </td></tr>
        <tr><td>Левая доля</td>
            <td>
                a = <%=r.getSizeInput("l_dolya_1")%> мм
                b = <%=r.getSizeInput("l_dolya_2")%> мм
                c = <%=r.getSizeInput("l_dolya_3")%> мм
                V2 = <%=r.getHidden("v2")%> см
            </td>
            <td>Vсумм = <%=r.getHidden("sum")%> см</td></tr>
        <tr><td>Перешеек</td>
            <td colspan="2">
                <%=r.getSizeInput("peresh")%> мм
            </td></tr>
        <tr><td>Границы</td>
            <td colspan="2">
                <%=r.getSelect("gran")%>
            </td></tr>
        <tr><td>Эхогенность</td>
            <td colspan="2">
                <%=r.getSelect("plot")%>
            </td></tr>
        <tr><td>Структура</td>
            <td colspan="2"><%=r.getSelect("shit_struct")%></td>
        </tr>
        <tr><td colspan="3"><%=r.get("vkluch")%></td></tr>
    </table>
</div>

<div id="display8" style="display:none;position:relative; left:12;">
    <table width="90%" border="1">
        <tr><td>Лимфоузлы</td>
            <td><%=r.getSelect("limf")%></td>
            <td><%=r.getChangeHidden("limf", "3", "58")%><%=r.getSizeInput("limf_size_do")%>мм</div></td></tr>
    </table>
</div>

<div id="display9" style="display:none;position:relative; left:12;">
    <table width="90%" border="1">
        <tr><td>При ЦДК кровоток <%=r.getSelect("sim")%> <%=r.getSelect("usilen")%> <%=r.getTextInput("krov_text")%>
            </td></tr>
    </table>
</div>

<SCRIPT LANGUAGE="JavaScript">
    changeHidden4();
    document.protocol.del.onchange  = changeHidden4
    function changeHidden4()
    {
        if(document.protocol.del.value == "1030")
        {   display5.style.display = "none";
            display6.style.display = "none";
            display7.style.display = "";
            display8.style.display = "";
            display9.style.display = "";
        }
        if(document.protocol.del.value == "1031")
        {   display5.style.display = "";
            display6.style.display = "none";
            display7.style.display = "none";
            display8.style.display = "";
            display9.style.display = "none";
        }
        if(document.protocol.del.value == "1032")
        {   display5.style.display = "none";
            display6.style.display = "";
            display7.style.display = "";
            display8.style.display = "";
            display9.style.display = "";
        }
    }
</SCRIPT>


<script>
    document.protocol.r_dolya_1.onchange = ExecutRv1
    document.protocol.r_dolya_2.onchange = ExecutRv1
    document.protocol.r_dolya_3.onchange = ExecutRv1
    document.protocol.l_dolya_1.onchange = ExecutLv2
    document.protocol.l_dolya_2.onchange = ExecutLv2
    document.protocol.l_dolya_3.onchange = ExecutLv2
        function ExecutRv1()
    {
        StrToFloat(document.protocol.r_dolya_1);
        StrToFloat(document.protocol.r_dolya_2);
        StrToFloat(document.protocol.r_dolya_3);
        var r_dolya_1 = parseFloat(document.protocol.r_dolya_1.value);
        var r_dolya_2 = parseFloat(document.protocol.r_dolya_2.value);
        var r_dolya_3 = parseFloat(document.protocol.r_dolya_3.value);
        if(document.protocol.r_dolya_1.value != "" && document.protocol.r_dolya_2.value != "" && document.protocol.r_dolya_3.value != ""){
            val = Math.round((0.479 * r_dolya_1 * r_dolya_2 * r_dolya_3/1000)*100);
            document.protocol.v1.value = val/100;
            ExecutSum();
        }

    }

    function ExecutLv2()
    {
        StrToFloat(document.protocol.l_dolya_1);
        StrToFloat(document.protocol.l_dolya_2);
        StrToFloat(document.protocol.l_dolya_3);
        var l_dolya_1 = parseFloat(document.protocol.l_dolya_1.value);
        var l_dolya_2 = parseFloat(document.protocol.l_dolya_2.value);
        var l_dolya_3 = parseFloat(document.protocol.l_dolya_3.value);
        if(document.protocol.l_dolya_1.value != "" && document.protocol.l_dolya_2.value != "" && document.protocol.l_dolya_3.value != ""){
            val = Math.round((0.479 * l_dolya_1 * l_dolya_2 * l_dolya_3/1000)*100);
            document.protocol.v2.value = val/100;
            ExecutSum();
        }
    }
    function ExecutSum()
    {
        var v1 = parseFloat(document.protocol.v1.value);
        var v2 = parseFloat(document.protocol.v2.value);
        if(document.protocol.v1.value != "" && document.protocol.v2.value != ""){
            document.protocol.sum.value = Math.round((v1 + v2)*100)/100;
        }
    }
    function StrToFloat(f_name){
      var val;
      var field;
      var array;
      field = eval(f_name);
      val = field.value;
      field.value = "";
      array = val.split(",");
      for(var i = 0; i < array.length; i++) if(i != array.length - 1) field.value += array[i] + "."; else field.value += array[i];
    }

</script>
<%@include file="footer.jsp"%>
