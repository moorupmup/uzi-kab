<%@page import = "java.util.Date" import="my_pack.beans.*" import="my_pack.tools.* java.text.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title" align="center"><%=r.get("research")%></H3>
<table width="90%" border="1">
    <tr><td colspan="2" align="center"><b>Печень</b> <%=r.getSelect("pechen")%></td></tr>
        <SCRIPT LANGUAGE="JavaScript">
                document.protocol.pechen.focus();
        </script>
    <tr><td colspan="2"><b>Размеры:</b></td></tr>
    <tr><td width="40%">Косой вертикальный размер правой доли</td>
        <td><%=r.getSizeInput("kosoi_r")%> мм</td>
    </tr>
    <tr><td>Кранио-каудальный размер левой доли</td>
        <td><%=r.getSizeInput("kosoi_l")%> мм</td>
    </tr>
    <tr><td>Толщина правой доли</td>
        <td><%=r.getSizeInput("tolsh_r")%> мм</td>
    </tr>
    <tr><td>Толщина левой доли</td>
        <td><%=r.getSizeInput("tolsh_l")%> мм</td>
    </tr>
    <tr><td><b>Контуры</b></td>
        <td><%=r.getSelect("kontur")%></td>
    </tr>
    <tr><td><b>Структура</b></td>
        <td><%=r.getSelect("struktura")%></td>
    </tr>
</table>
                            
<div id="display1" style="display:none;position:relative; left:12;">
    <table width="90%" border="1">
        <tr><td><b><%=r.getCheckbox("one_o")%></b></td></tr>
    </table>
    
    <div id="display2" style="display:none;position:relative; left:12;">
        <table width="90%" border="1">
            <tr><td rowspan="4" width="10%" align="center"><b>1</b></td>
                <td><%=r.getSelect("one_obraz1")%></td>
                <td><%=r.getSelect("eho_obraz1")%></td>
                <td><%=r.getSelect("str_obraz1")%></td>
            </tr>
            <tr>
                <td><%=r.getCheckbox("vkl_obraz1")%></td>
                <td><%=r.getSelect("kontur_obraz1")%></td>
                <td><%=r.getSelect("obod_obraz1")%></td>
            </tr>
            <tr>
                <td><%=r.getSelect("gde_obraz1")%></td>
                <td colspan="2">При ЦДК <%=r.getSelect("cdk_obraz1")%></td>
            </tr>
            <tr>
                <td>Размером <%=r.getSizeInput("r1_obraz1")%> x <%=r.getSizeInput("r2_obraz1")%> x <%=r.getSizeInput("r3_obraz1")%> мм</td>
                <td colspan="2">до <%=r.getSizeInput("do_obraz1")%> мм </td>
            </tr>
            <tr><td rowspan="4"width="10%" align="center"><b>2</b></td>
                <td><%=r.getSelect("one_obraz2")%></td>
                <td><%=r.getSelect("eho_obraz2")%></td>
                <td><%=r.getSelect("str_obraz2")%></td>
            </tr>
            <tr>
                <td><%=r.getCheckbox("vkl_obraz2")%></td>
                <td><%=r.getSelect("kontur_obraz2")%></td>
                <td><%=r.getSelect("obod_obraz2")%></td>
            </tr>
            <tr>
                <td><%=r.getSelect("gde_obraz2")%></td>
                <td colspan="2">При ЦДК <%=r.getSelect("cdk_obraz2")%></td>
            </tr>
            <tr>
                <td>Размером <%=r.getSizeInput("r1_obraz2")%> x <%=r.getSizeInput("r2_obraz2")%> x <%=r.getSizeInput("r3_obraz2")%> мм</td>
                <td colspan="2">до <%=r.getSizeInput("do_obraz2")%> мм </td>
            </tr>
            <tr><td rowspan="4" width="10%" align="center"><b>3</b></td>
                <td><%=r.getSelect("one_obraz3")%></td>
                <td><%=r.getSelect("eho_obraz3")%></td>
                <td><%=r.getSelect("str_obraz3")%></td>
            </tr>
            <tr>
                <td><%=r.getCheckbox("vkl_obraz3")%></td>
                <td><%=r.getSelect("kontur_obraz3")%></td>
                <td><%=r.getSelect("obod_obraz3")%></td>
            </tr>
            <tr>
                <td><%=r.getSelect("gde_obraz3")%></td>
                <td colspan="2">При ЦДК <%=r.getSelect("cdk_obraz3")%></td>
            </tr>
            <tr>
                <td>Размером <%=r.getSizeInput("r1_obraz3")%> x <%=r.getSizeInput("r2_obraz3")%> x <%=r.getSizeInput("r3_obraz3")%> мм</td>
                <td colspan="2">до <%=r.getSizeInput("do_obraz3")%> мм </td>
            </tr>
        </table>
    </div>
    
    <script LANGUAGE="JavaScript">
    changeHidden2();    
    document.protocol.one_o.onclick  = changeHidden2
    function changeHidden2() 
        {
        if(document.protocol.one_o.checked == true)
            display2.style.display = "";
        else
            display2.style.display = "none";
        }
    </script>

    <table width="90%" border="1">
        <tr><td><b><%=r.getCheckbox("many_o")%></b></td></tr>
    </table>

    <div id="display3" style="display:none;position:relative; left:12;">
        <table width="90%" border="1">
            <tr><td><%=r.getCheckbox("m_ochag")%><br>
                    <%=r.getCheckbox("m_obem")%><br>
                    <%=r.getCheckbox("m_jid")%><br>
                    <%=r.getCheckbox("m_kalc")%>                                                        
                </td>
                <td><%=r.getCheckbox("m_gipo")%><br>
                    <%=r.getCheckbox("m_giper")%><br>
                    <%=r.getCheckbox("m_izo")%><br>
                    <%=r.getCheckbox("m_aneho")%>                                                        
                </td>
            </tr>
            <tr><td><%=r.getSelect("m_str")%></td>
                <td><%=r.getCheckbox("m_jid_vkl")%></td>
            </tr>
            <tr><td><%=r.getSelect("m_dolja")%></td>
                <td>В <%=r.getCheckbox("m_seg1")%>
                    <%=r.getCheckbox("m_seg2")%>
                    <%=r.getCheckbox("m_seg3")%>
                    <%=r.getCheckbox("m_seg4")%>
                    <%=r.getCheckbox("m_seg5")%>
                    <%=r.getCheckbox("m_seg6")%>
                    <%=r.getCheckbox("m_seg7")%>
                    <%=r.getCheckbox("m_seg8")%> сегментах
                </td>
            </tr>
            <tr><td>При ЦДК <%=r.getSelect("m_cdk")%></td>
                <td>Размерами от <%=r.getSizeInput("m_razot")%> мм до <%=r.getSizeInput("m_razdo")%> мм</td>
            </tr>
        </table>
    </div>

    <script LANGUAGE="JavaScript">
    changeHidden3();    
    document.protocol.many_o.onclick  = changeHidden3
    function changeHidden3() 
        {
        if(document.protocol.many_o.checked == true)
            display3.style.display = "";
        else
            display3.style.display = "none";
        }                                               
    </script>

</div>

<SCRIPT LANGUAGE="JavaScript">
    changeHidden1();
    document.protocol.struktura.onchange  = changeHidden1
    function changeHidden1()
    {
        if(document.protocol.struktura.value == "125")
            display1.style.display = "";
        else display1.style.display = "none";
    }
</SCRIPT>


<table width="90%" border="1">
    <tr><td colspan="2"><%=r.get("pechen_str_text")%></td></tr>
    <tr><td width="40%"><b>Эхогенность</b></td>
        <td><%=r.getSelect("ehogen")%></td>
    <tr><td><b>Внутрипеченочные желчные протоки</b></td>
        <td><%=r.getSelect("jelch_prot")%></td></tr>
    <tr><td><b>Портальная вена</b></td>
        <td><%=r.getSelect("port_vena")%> <%=r.getSizeInput("port_vena_text")%> мм</td></tr>
    <tr><td><b>Нижняя полая вена</b></td>
        <td><%=r.getSelect("polaj_vena")%> 
            <%=r.getSizeInput("polaj_vena1")%> мм на вдохе
            <%=r.getSizeInput("polaj_vena2")%> мм на выдохе
        </td></tr>
    <tr><td colspan="2"><%=r.get("pechen_text")%></td></tr>
</table>

<table width="90%" border="1">
    <tr><td align="center"><b>Желчный пузырь</b> <%=r.getSelect("forma_izm")%></td></tr>
</table>

<div id="display4" style="display:none;position:relative; left:12;">
    <table width="90%" border="1">
        <tr><td><%=r.get("jelch_p")%></td></tr>
    </table>
</div>
 
<div id="display5" style="display:none;position:relative; left:12;">
    <table width="90%" border="1">
        <tr><td>&nbsp;</td>
            <td><%=r.getSelect("forma")%></td>
        </tr>   
        <tr><td width="25"><b>Размеры</b></td>
            <td>Длина <%=r.getSizeInput("jelch_dl")%> мм </td>
        </tr>
        <tr><td>&nbsp;</td>
            <td>Ширина <%=r.getSizeInput("jelch_sh")%> мм</td>
        </tr>
        <tr><td>&nbsp;</td>
            <td>Толщина <%=r.getSizeInput("jelch_tol")%> мм</td>
        </tr>
        <tr><td>&nbsp;</td>
            <td>Объем <%=r.getSizeInput("jelch_ob")%> мл</td>
        </tr>
        <tr><td><b>Стенки</b></td>
            <td><%=r.getSelect("stenki")%> <%=r.getSizeInput("stenki_size")%> мм</td>
        </tr>
        <tr><td><b>В полости</b> </td>
            <td><%=r.getSelect("soderg")%></td>
        </tr>
        <tr><td colspan="2"><%=r.get("v_polosti")%></td>
        </tr>
        <tr><td><b>Общий желчный проток</b></td>
            <td><%=r.getSelect("jelch_protok")%> <%=r.getSizeInput("protok_mm")%> мм </td>
        </tr>
    </table>
</div>

<SCRIPT LANGUAGE="JavaScript">
    changeHidden4();
    document.protocol.forma_izm.onchange  = changeHidden4
    function changeHidden4()
    {
        if(document.protocol.forma_izm.value == "654")
        {    display4.style.display = "none";
             display5.style.display = "";
        }
        else 
        {   display4.style.display = "";
            display5.style.display = "none";
        }
    }
</SCRIPT>

<table width="90%" border="1">
    <tr><td align="center"><b>Поджелудочная Железа</b> <%=r.getSelect("pod_jel")%> </td></tr>
</table>

<div id="display6" style="display:none;position:relative; left:12;">
    <table width="90%" border="1">
        <tr><td><%=r.get("jel_net")%></td></tr>
    </table>
</div>

<div id="display7" style="display:none;position:relative; left:12;">
    <table width="90%" border="1">
        <tr><td colspan="3"><b>Размеры</b></td></tr>
        <tr><td width="25%">&nbsp;</td>
            <td width="20%">Головка</td>
            <td><%=r.getSizeInput("golov")%> мм</td>
        </tr>
        <tr><td>&nbsp;</td>
            <td>Тело</td>
            <td><%=r.getSizeInput("telo")%> мм</td>
        </tr>
        <tr><td>&nbsp;</td>
            <td >Хвост</td>
            <td><%=r.getSizeInput("hvost")%> мм</td>
        </tr>
        <tr><td><b>Контуры</b> </td>
            <td colspan="2"><%=r.getSelect("kontur_pod")%></td>
        </tr>
        <tr><td><b>Структура</b> </td>
            <td colspan="2"><%=r.getSelect("struktura_pod")%></td>
        </tr>
        <tr><td colspan="3"><%=r.get("str_pod_jel")%></td></tr>
        <tr><td><b>Эхогенность</b></td>
            <td colspan="2"><%=r.getSelect("eho_pod")%></td>
        </tr>
        <tr><td><b>Вирсунгов проток</b></td>
            <td><%=r.getSelect("virs_rash")%></td>
            <td><%=r.getSizeInput("virs_size")%> мм</td>
        </tr>
        <tr><td><b>Селезеночная вена</b></td>
            <td colspan="2"><%=r.getSizeInput("sel_vena")%> мм</td>
        </tr>
    </table>
</div>

<SCRIPT LANGUAGE="JavaScript">
    changeHidden6();
    document.protocol.pod_jel.onchange  = changeHidden6
    function changeHidden6()
    {
        if(document.protocol.pod_jel.value == "666")
        {   display6.style.display = "none";
            display7.style.display = "";
        }
        if(document.protocol.pod_jel.value == "667" || document.protocol.pod_jel.value == "668")
        {   display6.style.display = "";
            display7.style.display = "none";
        }
    }
</SCRIPT>

<table width="90%" border="1">
    <tr><td colspan="2" align="center"><b>Селезенка</b> <%=r.getSelect("selez")%></td></tr>
</table>

<div id="display14" style="display:none;position:relative; left:12;">
    <table width="90%" border="1">
        <tr><td width="20%"><b>Размеры:</b></td>
            <td>&nbsp;</td>
        </tr>
        <tr><td align="right"> Длина</td>
            <td><%=r.getSizeInput("sel_dl")%> мм </td>
        </tr>
        <tr><td align="right">Толщина</td>
            <td><%=r.getSizeInput("sel_tol")%> мм </td>
        </tr>
        <tr><td align="right">Ширина</td>
            <td><%=r.getSizeInput("sel_sh")%> мм </td>
        </tr>
        <tr><td align="right">Площадь</td>
            <td><%=r.getSizeInput("sel_obem")%> см2 </td>
        </tr>
        <tr><td><b>Контуры</b></td>
            <td><%=r.getSelect("sel_kon")%></td>
        </tr>
        <tr><td><b>Структура</b></td>
            <td><%=r.getSelect("struktura_sel")%></td>
        </tr>
        <tr><td colspan="2"><%=r.get("str_sel")%></td></tr>
        <tr><td><b>Эхогенность</b></td>
            <td><%=r.getSelect("eho_sel")%></td>
        </tr>
    </table>
</div>

<div id="display15" style="display:none;position:relative; left:12;">
    <table width="90%" border="1">
        <tr><td><%=r.get("selez_text")%></td></tr>
    </table>
</div>

<SCRIPT LANGUAGE="JavaScript">
    changeHidden14();
    document.protocol.selez.onchange  = changeHidden14
    function changeHidden14()
    {
        if(document.protocol.selez.value == "1018")
        {   display14.style.display = "none";
            display15.style.display = "";
        }
        if(document.protocol.selez.value == "1016" || document.protocol.selez.value == "1017")
        {   display14.style.display = "";
            display15.style.display = "";
        }
    }
</SCRIPT>


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
            <td><%=r.getChangeHidden("r_chash", "10", "140")%>за счет<br>
                <%=r.getCheckbox("r_chash_check")%> <%=r.getSelect("r_chash_local")%>
                до <%=r.getSizeInput("r_chash_size")%> мм<br>
                <%=r.getCheckbox("r_lohanki")%> до <%=r.getSizeInput("r_lohan_size")%> мм</td></tr>
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
        if(document.protocol.r_pochka.value == "670" || document.protocol.r_pochka.value == "671" || document.protocol.r_pochka.value == "672")
        {   display8.style.display = "none";
            display9.style.display = "";
        }
        if(document.protocol.r_pochka.value == "673" || document.protocol.r_pochka.value == "674" || document.protocol.r_pochka.value == "675")
        {   display8.style.display = "";
            display9.style.display = "";
        }
        if(document.protocol.r_pochka.value == "676")
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
            <td><%=r.getChangeHidden("l_chash", "13", "140")%>за счет<br>
                <%=r.getCheckbox("l_chash_check")%> <%=r.getSelect("l_chash_local")%>
                до <%=r.getSizeInput("l_chash_size")%> мм<br>
                <%=r.getCheckbox("l_lohanki")%> до <%=r.getSizeInput("l_lohan_size")%> мм</td></tr>
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
        if(document.protocol.l_pochka.value == "670" || document.protocol.l_pochka.value == "671" || document.protocol.l_pochka.value == "672")
        {   display11.style.display = "none";
            display12.style.display = "";
        }
        if(document.protocol.l_pochka.value == "1053" || document.protocol.l_pochka.value == "1054" || document.protocol.l_pochka.value == "675")
        {   display11.style.display = "";
            display12.style.display = "";
        }
        if(document.protocol.l_pochka.value == "676")
        {   display11.style.display = "";
            display12.style.display = "none";
        }
    }
</SCRIPT>

<script>
    document.protocol.jelch_dl.onchange = ObemJP
    document.protocol.jelch_tol.onchange = ObemJP
    document.protocol.jelch_sh.onchange = ObemJP
    document.protocol.sel_dl.onchange = ObemSel
    document.protocol.sel_tol.onchange = ObemSel
    document.protocol.sel_sh.onchange = ObemSel

    function ObemJP()
    {
        StrToFloat(document.protocol.jelch_dl);
        StrToFloat(document.protocol.jelch_tol);
        StrToFloat(document.protocol.jelch_sh);
        var jelch_dl = parseFloat(document.protocol.jelch_dl.value);
        var jelch_tol = parseFloat(document.protocol.jelch_tol.value);
        var jelch_sh = parseFloat(document.protocol.jelch_sh.value);
        if(document.protocol.jelch_dl.value != "" && document.protocol.jelch_tol.value != "" && document.protocol.jelch_sh.value != ""){
            val = Math.round((0.523 * jelch_dl * jelch_tol * jelch_sh/1000)*100);
            document.protocol.jelch_ob.value = val/100;
        }
        else document.protocol.jelch_ob.value="";
        
    }

    function ObemSel()
    {
        StrToFloat(document.protocol.sel_dl);
        StrToFloat(document.protocol.sel_tol);
        StrToFloat(document.protocol.sel_sh);
        var sel_dl = parseFloat(document.protocol.sel_dl.value);
        var sel_tol = parseFloat(document.protocol.sel_tol.value);
        var sel_sh = parseFloat(document.protocol.sel_sh.value);
        if(document.protocol.sel_dl.value != "" && document.protocol.sel_tol.value != "" && document.protocol.sel_sh.value != ""){
            val = Math.round((0.523 * sel_dl * sel_tol * sel_sh/1000)*100);
            document.protocol.sel_obem.value = val/100;
        }
        else document.protocol.sel_obem.value = "";

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
