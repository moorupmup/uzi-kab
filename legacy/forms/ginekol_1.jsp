<%@page import = "java.util.Date" import="my_pack.beans.*" import="my_pack.tools.* java.text.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title" align="center"><%=r.get("research")%></H3>
<table width="90%" border="1">
    <tr><td width="65%">Первый день последней менструации <%=r.getTextInput("faza_c")%></td>
        <SCRIPT LANGUAGE="JavaScript">
            document.protocol.faza_c.focus();
        </script>
        <td>Менопауза <%=r.getSizeInput("payza")%> лет
    </tr>
    <tr><td colspan="2"><%=r.getTextAreaInput("krov",2,80)%></td></tr>
    <tr><td colspan="2"><b>Тело матки</b> <%=r.getSelect("telo_matki")%></td>
    </tr>
</table>

<div id="display1" style="display:none;position:relative; left:0;">
    <table width="90%" border="1">
        <tr><td colspan="2"> в <%=r.getSizeInput("del_matka")%> году</td></tr>
        <tr><td colspan="2"><b>Культя:</b> размеры:</td></tr>
        <tr><td width="25%">&nbsp;</td>
            <td>Длина <%=r.getSizeInput("kyl_dl")%> мм</td>
        </tr>
        <tr><td>&nbsp;</td>
            <td>Толщина <%=r.getSizeInput("kyl_tol")%> мм</td>
        </tr>
        <tr><td>&nbsp;</td>
            <td>Ширина <%=r.getSizeInput("kyl_sh")%> мм</td>
        </tr>
        <tr><td>Строение </td>
            <td><%=r.getSelect("kyl_stroi")%> <%=r.getTextInput("kyl_stroi_text")%></td>
        </tr>
        <tr><td>Цервикальный канал </td>
            <td> <%=r.getSelect("cer_kanal")%></td>
        </tr>
    </table>
</div>

<div id="display2" style="display:none;position:relative; left:0;">
    <table width="90%" border="1">
        <tr><td><%=r.get("matka_neopred")%></td></tr>
    </table>
</div>


<div id="display3" style="display:none;position:relative; left:0;">
    <table width="90%" border="1">
        <tr><td colspan="2">Размеры</td></tr>
        <tr><td width="25%">&nbsp;</td>
            <td>длина <%=r.getSizeInput("matka_dl")%> мм</td>
        </tr>
        <tr><td>&nbsp;</td>
            <td>толщина <%=r.getSizeInput("matka_tol")%> мм</td>
        </tr>
        <tr><td>&nbsp;</td>
            <td>ширина <%=r.getSizeInput("matka_sh")%> мм</td>
        </tr>
        <tr><td>Форма</td>
            <td><%=r.getSelect("forma_matka")%> <%=r.getTextInput("forma_matka_text")%></td>
        </tr>
        <tr><td>Строение миометрия</td>
            <td><%=r.getSelect("struct_matka")%></td>
        </tr>
        <tr><td colspan="2"><%=r.get("str_miom")%></td>
        </tr>
        <tr><td colspan="2"><b>Эндометрий</b> <%=r.getSelect("endometrii")%></td></tr>
        <tr><td>Соответствует</td>
            <td><%=r.getSelect("endom_soot")%> <%=r.getTextInput("endom_soot_text")%></td>
        </tr>
        <tr><td>Толщина</td>
            <td><%=r.getSizeInput("endom_tol")%> мм</td>
        </tr>
        <tr><td>Строение</td>
            <td><%=r.getSelect("endom_struct")%></td>
        </tr>
        <tr><td colspan="2"><%=r.get("endom_text")%></td>
        </tr>
        <tr><td colspan="2">Контуры эндометрия на границе с внутренним мышечным слоем 
            <%=r.getSelect("endom_kontur")%> <%=r.getTextInput("endom_kontur_text")%></td>
        </tr>
        <tr><td colspan="2"><b>Полость матки</b></td></tr>
        <tr><td><%=r.getSelect("polost_m")%></td>
            <td><%=r.getSizeInput("polost_m_raz")%></td>
        </tr>
        <tr><td colspan="2"><%=r.get("polost_m_text")%></td>
        <tr><td colspan="2"><b>Шейка матки</b> <%=r.getSelect("sheika_m")%></td></tr>
    </table>
</div>

<div id="display4" style="display:none;position:relative; left:0;">
    <table width="90%" border="1">
        <tr><td><%=r.get("sheika_m_net")%></td></tr>
    </table>
</div>

<div id="display5" style="display:none;position:relative; left:0;">
    <table width="90%" border="1">
        <tr><td colspan="2">Размеры:</td></tr>
        <tr><td width="25%">Длина</td>
            <td><%=r.getSizeInput("sheika_dl")%> мм</td>
        </tr>
        <tr><td>Ширина</td>
            <td><%=r.getSizeInput("sheika_sh")%> мм</td>
        </tr>
        <tr><td>Форма</td>
            <td><%=r.getSelect("sheika_forma")%></td>
        </tr>
        <tr><td>Строение</td>
            <td><%=r.getSelect("sheika_str")%></td>
        </tr>
    </table>
</div>

<div id="display6" style="display:none;position:relative; left:0;">
    <table width="90%" border="1">
        <tr><td><%=r.getSelect("sheika_str_izm")%></td>
            <td>кистозных включений до <%=r.getSizeInput("sheika_kist")%> мм </td>
        </tr>
    </table>
</div>

<SCRIPT LANGUAGE="JavaScript">
    changeHidden1();
    document.protocol.telo_matki.onchange = changeHidden1

   function changeHidden1()
   {
       if(document.protocol.telo_matki.value == "724" || document.protocol.telo_matki.value == "725" || document.protocol.telo_matki.value == "726" || document.protocol.telo_matki.value == "727" )
       {
            display1.style.display = "none";
            display2.style.display = "none";
            display3.style.display = "";
            display4.style.display = "none";
            display5.style.display = "";
            display6.style.display = "none";
       }
       if(document.protocol.telo_matki.value == "728")
       {
            display1.style.display = "";
            display2.style.display = "none";
            display3.style.display = "none";
            display4.style.display = "none";
            display5.style.display = "none";
            display6.style.display = "none";
       }
       if(document.protocol.telo_matki.value == "729")
       {
            display1.style.display = "none";
            display2.style.display = "";
            display3.style.display = "none";
            display4.style.display = "none";
            display5.style.display = "none";
            display6.style.display = "none";
       }

   }
</SCRIPT>

<SCRIPT LANGUAGE="JavaScript">
    changeHidden4();
    document.protocol.sheika_m.onchange = changeHidden4

   function changeHidden4()
   {
       if(document.protocol.sheika_m.value == "768")
       {
            display4.style.display = "none";
            display5.style.display = "";
       }
       if(document.protocol.sheika_m.value == "769")
       {
            display4.style.display = "";
            display5.style.display = "none";
       }
   }
</SCRIPT>

<SCRIPT LANGUAGE="JavaScript">
    changeHidden6();
    document.protocol.sheika_str.onchange = changeHidden6

   function changeHidden6()
   {
       if(document.protocol.sheika_str.value == "776")
            display6.style.display = "";
       else 
            display6.style.display = "none";
   }
</SCRIPT>

<table width="90%" border="1">
    <tr><td align="center"><b>Правый яичник</b> <%=r.getSelect("r_ja")%> </td></tr>
</table>

<div id="display7" style="display:none;position:relative; left:0;">
    <table width="90%" border="1">
        <tr><td>оперативно удален в <%=r.getSizeInput("r_god")%> году</td></tr>
    </table>
</div>

<div id="display8" style="display:none;position:relative; left:0;">
    <table width="90%" border="1">
        <tr><td width="20%">Размеры</td>
            <td width="20%">Длина</td>
            <td><%=r.getSizeInput("r_dlina")%> мм</td>
        </tr>
        <tr><td>&nbsp;</td>
            <td>Толщина</td>
            <td><%=r.getSizeInput("r_tolsh")%> мм</td>
        </tr>
        <tr><td>&nbsp;</td>
            <td>Ширина</td>
            <td><%=r.getSizeInput("r_shir")%> мм</td>
        </tr>
        <tr><td>&nbsp;</td>
            <td>Объем</td>
            <td><%=r.getSizeInput("r_obem")%> мл</td>
        </tr>
        <tr><td>&nbsp;</td>
            <td colspan="2"><%=r.getSelect("r_yvelich")%></td></tr>
        <tr><td>Форма</td>
            <td><%=r.getSelect("r_form")%></td>
            <td><%=r.getTextInput("r_form_text")%></td>
        </tr>
        <tr><td>Строение</td>
            <td colspan="2"><%=r.getSelect("r_str")%></td>
        </tr>
        <tr><td colspan="3"><%=r.get("r_structura")%></td></tr>
    </table>
</div>

<SCRIPT LANGUAGE="JavaScript">
    changeHidden8();
    document.protocol.r_ja.onchange = changeHidden8
   function changeHidden8()
   {
       if(document.protocol.r_ja.value == "313")
       {    display7.style.display = "";
            display8.style.display = "none";}
       if(document.protocol.r_ja.value == "312")
       {    display7.style.display = "none";
            display8.style.display = "";}            
   }
</SCRIPT>


<table width="90%" border="1">
    <tr><td> <%=r.get("r_text")%> </td></tr>
    <tr><td align="center"><b>Левый яичник</b> <%=r.getSelect("l_ja")%></td></tr>
</table>

<div id="display9" style="display:none;position:relative; left:0;">
    <table width="90%" border="1">
        <tr><td>оперативно удален в <%=r.getSizeInput("l_god")%> году</td></tr>
    </table>
</div>

<div id="display10" style="display:none;position:relative; left:0;">
    <table width="90%" border="1">
        <tr><td width="20%">Размеры</td>
            <td width="20%">Длина</td>
            <td><%=r.getSizeInput("l_dlina")%> мм</td>
        </tr>
        <tr><td>&nbsp;</td>
            <td>Толщина</td>
            <td><%=r.getSizeInput("l_tolsh")%> мм</td>
        </tr>
        <tr><td>&nbsp;</td>
            <td>Ширина</td>
            <td><%=r.getSizeInput("l_shir")%> мм</td>
        </tr>
        <tr><td>&nbsp;</td>
            <td>Объем</td>
            <td><%=r.getSizeInput("l_obem")%> мл</td>
        </tr>
        <tr><td>&nbsp;</td>
            <td colspan="2"><%=r.getSelect("l_yvelich")%></td></tr>
        <tr><td>Форма</td>
            <td><%=r.getSelect("l_form")%></td>
            <td><%=r.getTextInput("l_form_text")%></td>
        </tr>
        <tr><td>Строение</td>
            <td colspan="2"><%=r.getSelect("l_str")%></td>
        </tr>
        <tr><td colspan="3"><%=r.get("l_structura")%></td></tr>
    </table>
</div>

<SCRIPT LANGUAGE="JavaScript">
    changeHidden10();
    document.protocol.l_ja.onchange = changeHidden10
   function changeHidden10()
   {
       if(document.protocol.l_ja.value == "313")
       {    display9.style.display = "";
            display10.style.display = "none";}
       if(document.protocol.l_ja.value == "312")
       {    display9.style.display = "none";
            display10.style.display = "";}            
   }
</SCRIPT>

<table width="90%" border="1">
    <tr><td colspan="2"> <%=r.get("l_text")%> </td></tr>
    <tr><td> <%=r.getCheckbox("jidkost")%> </td>
        <td><%=r.getSelect("svob_jid")%> <%=r.getSelect("svob_jid_sel")%></td>
    </tr>
</table>

<script>
    document.protocol.r_dlina.onchange = ObemR
    document.protocol.r_shir.onchange = ObemR
    document.protocol.r_tolsh.onchange = ObemR
    document.protocol.l_dlina.onchange = ObemL
    document.protocol.l_shir.onchange = ObemL
    document.protocol.l_tolsh.onchange = ObemL

    function ObemR()
    {
        StrToFloat(document.protocol.r_dlina);
        StrToFloat(document.protocol.r_shir);
        StrToFloat(document.protocol.r_tolsh);
        var r_dlina = parseFloat(document.protocol.r_dlina.value);
        var r_tolsh = parseFloat(document.protocol.r_tolsh.value);
        var r_shir = parseFloat(document.protocol.r_shir.value);
        if(document.protocol.r_dlina.value != "" && document.protocol.r_tolsh.value != "" && document.protocol.r_shir.value != ""){
            val = Math.round((0.523 * r_dlina * r_tolsh * r_shir/1000)*100);
            document.protocol.r_obem.value = val/100;
        }
        else document.protocol.r_obem.value="";
        
    }

    function ObemL()
    {
        StrToFloat(document.protocol.l_dlina);
        StrToFloat(document.protocol.l_tolsh);
        StrToFloat(document.protocol.l_shir);
        var l_dlina = parseFloat(document.protocol.l_dlina.value);
        var l_tolsh = parseFloat(document.protocol.l_tolsh.value);
        var l_shir = parseFloat(document.protocol.l_shir.value);
        if(document.protocol.l_dlina.value != "" && document.protocol.l_tolsh.value != "" && document.protocol.l_shir.value != ""){
            val = Math.round((0.523 * l_dlina * l_tolsh * l_shir/1000)*100);
            document.protocol.l_obem.value = val/100;
        }
        else document.protocol.l_obem.value = "";

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
                                        