<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title">УЗИ мочеполовой системы</H3>

<span class="bold_str"><b>Правая почка</b></span> 
<%=r.getSelect("rpochka")%>
<div id="display60" style="display:none;position:relative; left:0;">
<%=r.getSizeInput("r_pochka_how")%>мм
<SCRIPT LANGUAGE="JavaScript">
document.protocol.rpochka.focus();
</script>
<table width="100%" border="1">
    <tr> 
        <td width="9%" class="simple_str">Размеры
        </td>
        <td class="bold_str" width="14%">почка
        </td>
        <td colspan="2"> 
            <%=r.getSizeInput("r_pochka_razmer1")%>*
            <%=r.getSizeInput("r_pochka_razmer2")%>
        <SCRIPT LANGUAGE="JavaScript">
            if (document.protocol.r_pochka_razmer1.value == "") document.protocol.r_pochka_razmer1.value = "100";
            if (document.protocol.r_pochka_razmer2.value == "") document.protocol.r_pochka_razmer2.value = "45";
        </script>
            <span class="ed_izm">мм</span>
        </td>
    </tr>
    <tr> 
        <td width="9%" class="simple_str">&nbsp;
        </td>
        <td class="simple_str" width="14%">паренхима
        </td>
        <td colspan="2"> 
            <%=r.getSizeInput("r_parenhima")%>
        <SCRIPT LANGUAGE="JavaScript">
            if (document.protocol.r_parenhima.value == "") document.protocol.r_parenhima.value = "18";
        </script>

            <span class="ed_izm"> мм</span>
        </td>
    </tr>
    <tr> 
        <td colspan="3" class="simple_str">Полостная система<br> 
            <%=r.getSelect("rpolost")%>
        </td>
        <td width="66%">
            <%=r.getChangeHidden("rpolost", "10", "221")%>
                <span class="simple_str">за счет</span><br>
                <%=r.getCheckbox("rchash")%>
                <%=r.getTextInput("r_shasheshki_how")%><br>
                <%=r.getCheckbox("rlohanki")%>
                <%=r.getTextInput("r_lohanki_how")%>
            </div>
        </td>
    </tr>
    <tr> 
        <td colspan="4" class="simple_str"> 
            <%=r.getSelect("rstru")%>
        </td>
    </tr>
    <tr> 
        <td colspan="4" class="simple_str">
            <%=r.getChangeHidden("rstru", "1", "224")%>
                <span class="simple_str">за счет</span><br>
                <%=r.get("r_stru_sel")%>
                <%=r.getCheckbox("roovp")%> 
                <%=r.getTextInput("r_obem_verh_how")%><br>
                <%=r.getCheckbox("roost")%>
                <%=r.getTextInput("r_obem_sredn_how")%><br>
                <%=r.getCheckbox("roonp")%>
                <%=r.getTextInput("r_obem_niz_how")%><br>
                <%=r.getCheckbox("rjovp")%>
                <%=r.getTextInput("r_jid_verh_how")%><br>
                <%=r.getCheckbox("rjost")%>
                <%=r.getTextInput("r_jid_sredn_how")%><br>
                <%=r.getCheckbox("rjonp")%>
                <%=r.getTextInput("r_jid_niz_how")%><br>
                <%=r.getCheckbox("rjop")%>
                <%=r.getTextInput("r_jid_paralel_how")%>
            </div>
        </td>
    </tr>
    <tr> 
        <td colspan="4" class="simple_str">Конкременты 
            <%=r.getSelect("rkonkrim")%>
        </td>
    </tr>
    <tr> 
        <td colspan="4" class="simple_str">
            <%=r.getChangeHidden("rkonkrim", "2", "227")%>
                <%=r.getCheckbox("rvgch")%>
                <%=r.getSizeInput("r_verh_how")%>мм<br>
                <%=r.getCheckbox("rsgch")%>
                <%=r.getSizeInput("r_sred_how")%>мм<br>
                <%=r.getCheckbox("rngch")%>
                <%=r.getSizeInput("r_niz_how")%>мм<br>
                <%=r.getCheckbox("rpl")%>
                <%=r.getSizeInput("r_proekcii_how")%>мм
            </div>
        </td>
    </tr>
    <tr>
        <td colspan="4">
            <font class="underline_str">правый надпочечник </font> 
            <%=r.getSelect("rnadpoch")%>
            <%=r.getSizeInput("r_nadpoch_how")%>мм
            <%=r.getTextInput("r_nadpochechnik_how")%>
        </td>
    </tr>
</table>
</div><br>
<SCRIPT LANGUAGE="JavaScript">
    changeHidden60();
    document.protocol.rpochka.onchange  = changeHidden60
    function changeHidden60()
    {
        if(document.protocol.rpochka.value == "215" || document.protocol.rpochka.value == "6601"){
            display60.style.display = "none";
        }else{
            display60.style.display = "";
        }
    }
</SCRIPT>

<span class="bold_str"><b>Левая почка</b></span> 
<%=r.getSelect("lpochka")%>
<div id="display61" style="display:none;position:relative; left:0;">
<%=r.getSizeInput("l_pochka_how")%>мм
<table width="100%" border="1">
    <tr> 
        <td width="9%" class="simple_str">Размеры
        </td>
        <td class="bold_str" width="14%">почка
        </td>
        <td colspan="2"> 
          <%=r.getSizeInput("l_pochka_razmer1")%>*
          <%=r.getSizeInput("l_pochka_razmer2")%>
        <SCRIPT LANGUAGE="JavaScript">
            if (document.protocol.l_pochka_razmer1.value == "") document.protocol.l_pochka_razmer1.value = "100";
            if (document.protocol.l_pochka_razmer2.value == "") document.protocol.l_pochka_razmer2.value = "45";
        </script>

            <span class="ed_izm">мм</span>
        </td>
    </tr>
    <tr> 
        <td width="9%" class="simple_str">&nbsp;
        </td>
        <td class="simple_str" width="14%">паренхима
        </td>
        <td colspan="2"> 
          <%=r.getSizeInput("l_parenhima")%>
        <SCRIPT LANGUAGE="JavaScript">
            if (document.protocol.l_parenhima.value == "") document.protocol.l_parenhima.value = "18";
        </script>
            <span class="ed_izm"> мм</span>
        </td>
    </tr>
    <tr> 
        <td colspan="3" class="simple_str">Полостная система<br> 
            <%=r.getSelect("lpolost")%>
        </td>
        <td width="66%">
            <%=r.getChangeHidden("lpolost", "11", "221")%>
                <span class="simple_str">за счет</span><br>
                <%=r.getCheckbox("lchash")%>
                <%=r.getTextInput("l_shasheshki_how")%><br>
                <%=r.getCheckbox("llohanki")%>
                <%=r.getTextInput("l_lohanki_how")%>
            </div>
        </td>
    </tr>
    <tr> 
        <td colspan="4" class="simple_str"> 
            <%=r.getSelect("lstru")%>
        </td>
    </tr>
    <tr> 
        <td colspan="4" class="simple_str">
            <%=r.getChangeHidden("lstru", "3", "224")%>
                <span class="simple_str">за счет</span><br>
                <%=r.getCheckbox("loovp")%>
                <%=r.getTextInput("l_obem_verh_how")%><br>
                <%=r.getCheckbox("loost")%>
                <%=r.getTextInput("l_obem_sredn_how")%><br>
                <%=r.getCheckbox("loonp")%>
                <%=r.getTextInput("l_obem_niz_how")%><br>
                <%=r.getCheckbox("ljovp")%>
                <%=r.getTextInput("l_jid_verh_how")%><br>
                <%=r.getCheckbox("ljost")%>
                <%=r.getTextInput("l_jid_sredn_how")%><br>
                <%=r.getCheckbox("ljonp")%>
                <%=r.getTextInput("l_jid_niz_how")%><br>
                <%=r.getCheckbox("ljop")%>
                <%=r.getTextInput("l_jid_paralel_how")%>
            </div>
        </td>
    </tr>
    <tr> 
        <td colspan="4" class="simple_str">Конкременты 
            <%=r.getSelect("lkonkrim")%>
        </td>
    </tr>
    <tr> 
        <td colspan="4" class="simple_str">
            <%=r.getChangeHidden("lkonkrim", "4", "227")%>
                <%=r.getCheckbox("lvgch")%>
                <%=r.getSizeInput("l_verh_how")%>мм<br>
                <%=r.getCheckbox("lsgch")%>
                <%=r.getSizeInput("l_sred_how")%>мм<br>
                <%=r.getCheckbox("lngch")%>
                <%=r.getSizeInput("l_niz_how")%>мм<br>
                <%=r.getCheckbox("lpl")%>
                <%=r.getSizeInput("l_proekcii_how")%>мм
            </div>
        </td>
    </tr>
    <tr>
        <td colspan="4">
            <font class="underline_str">левый надпочечник </font> 
            <%=r.getSelect("lnadpoch")%>
            <%=r.getSizeInput("l_nadpoch_how")%>мм
            <%=r.getTextInput("l_nadpochechnik_how")%>
        </td>
    </tr>
</table>
</div><br>
<SCRIPT LANGUAGE="JavaScript">
    changeHidden61();
    document.protocol.lpochka.onchange  = changeHidden61
    function changeHidden61()
    {
        if(document.protocol.lpochka.value == "215" || document.protocol.lpochka.value == "6601"){
            display61.style.display = "none";
        }else{
            display61.style.display = "";
        }
    }
</SCRIPT>

<font class="underline_str"><b>Яички <%=r.getSelect("jaichki")%></b></font>
<div id="display62" style="display:none;position:relative; left:0;">
<table width="100%" border="1">
    <tr> 
        <td colspan="2"> 
            <%=r.getSelect("jaichkigde")%>
        </td>
    </tr>
    <tr> 
        <td class="simple_str" width="32%">Эхоструктура 
            <%=r.getSelect("jaichkieho")%>
        </td>
        <td width="68%"> 
            <%=r.getChangeHidden("jaichkieho", "5", "300")%>
                за счет<br>
                <%=r.getCheckbox("jidkost")%>
                <br>
                <%=r.getCheckbox("kalcinat")%>
                <br>
                <%=r.getCheckbox("ychastok")%>
            </div>
        </td>
    </tr>
    <tr> 
        <td class="simple_str" colspan="2">Эхогенность 
            <%=r.getSelect("jaichehogen")%>
        </td>
    </tr>
    <tr> 
        <td colspan="2" class="simple_str">Избыточное количество свободной жидкости в оболочках яичек 
            <%=r.getSelect("izbitokjid")%>
            <%=r.getSelect("izbitokjidgde")%>
        </td>
    </tr>
    <tr> 
        <td colspan="2" class="simple_str">Придатки яичек 
            <%=r.getSelect("pridatki")%>
            <%=r.getSelect("pridatkigde")%>
        </td>
    </tr>
    <tr> 
        <td colspan="2" class="simple_str">Эхогенность 
            <%=r.getSelect("pridatehogen")%>
        </td>
    </tr>
    <tr> 
        <td class="simple_str" width="32%">Структура 
            <%=r.getSelect("jaistru")%>
        </td>
        <td width="68%"> 
            <%=r.getChangeHidden("jaistru", "9", "300")%>
                за cчет<br>
                <%=r.getCheckbox("ksprava")%><br>
                <%=r.getCheckbox("ksleva")%>
            </div>
        </td>
    </tr>
    <tr>
        <td class="simple_str" colspan="2">Расширение вен семенного канатика<br>
            <%=r.getSelect("rashirven")%>
            <%=r.getSizeInput("rash_do")%>мм
        </td>
    </tr>
    <tr>
        <td class="simple_str" colspan="2">Регургитация кровотока при пробе Вальсальвы
            <%=r.getSelect("regir")%>
        </td>
    </tr>
</table>
</div><br>
<SCRIPT LANGUAGE="JavaScript">
    changeHidden62();
    document.protocol.jaichki.onchange  = changeHidden62
    function changeHidden62()
    {
        if(document.protocol.jaichki.value == "292"){
            display62.style.display = "none";
        }else{
            display62.style.display = "";
        }
    }
</SCRIPT>

<font class="underline_str"><b>Предстательная железа</b></font> 
    <%=r.getSelect("predstat")%><br>
<div id="display63" style="display:none;position:relative; left:0;">
<table width="100%" border="1">
    <tr> 
        <td class="simple_str" width="24%">Размеры 
        </td>
        <td width="22%"> 
          <%=r.getSizeInput("jeleza_r1")%>*
          <%=r.getSizeInput("jeleza_r2")%>*
          <%=r.getSizeInput("jeleza_r3")%>
        </td>
        <td class="simple_str" width="54%">Объем 
          <%=r.getSizeInput("jeleza_obem")%>мл
        </td>
    </tr>
    <tr> 
        <td class="simple_str" width="24%">Форма 
        </td>
        <td colspan="2"> 
            <%=r.getSelect("forma")%>
        </td>
    <tr> 
        
        <td width="24%">
            <%=r.getSelect("vdaetsja")%>
        </td>
        <td colspan="2" class="simple_str">в просвет мочевого пузыря
        </td>
    </tr>
    <tr> 
        <td class="simple_str" width="24%">Капсула на всем протяжении 
        </td>
        <td colspan="2"> 
            <%=r.getSelect("kapsula")%>
        </td>
    </tr>
    <tr> 
        <td class="simple_str" width="24%">Контур 
        </td>
        <td width="22%"> 
            <%=r.getSelect("kontur")%>
        </td>
        <td width="54%"> 
            <%=r.getSelect("kontursim")%>
        </td>
    </tr>   
    <tr>
        <td class="simple_str" width="24%">Эхогенность 
        </td>
        <td colspan="2">
            <%=r.getSelect("ehogennost")%>
        </td>
    </tr>
    <tr> 
        <td class="simple_str" width="24%">
            <span class="simple_str">Эхоструктура</span>
            <%=r.getSelect("ehostru")%>
        </td>
        <td colspan="2"> 
            <%=r.getChangeHidden("ehostru", "6", "255")%>
                <%=r.getCheckbox("cgvpz")%>
                <br>
                <%=r.getCheckbox("ppebat")%>
                <br>
                <%=r.getCheckbox("gy")%>
                <br>
                <%=r.getCheckbox("jv")%>
                <br>
                <%=r.getCheckbox("ret")%>
                <br>
                <%=r.getCheckbox("mr")%>
                <br>
                <%=r.getCheckbox("pdafz")%>
                <br>
                <%=r.getCheckbox("paej")%>
                <br>
                <%=r.getCheckbox("kp")%>
                <%=r.getTextInput("poloct_kistoz_how")%><br>
                <%=r.getCheckbox("pmpbooj")%>
                <br>                                                            
                <%=r.getCheckbox("kk")%>
                <%=r.getTextInput("big_kalcinat_how")%><br>
            </div>
        </td>
    </tr>
    <tr> 
        <td colspan="3" class="simple_str">Простатическая часть уретры
            <%=r.getSelect("yretra")%>
            <font class="simple_str">на всем протяжении</font>
        </td>
    </tr>
    <tr>
        <td colspan="3" class="simple_str">Уретро-простатический угол      
            <%=r.getSelect("yretra_ygol")%>
        </td>
    </tr>
    <tr>
        <td colspan="3" class="simple_str">Везикуло-простатические углы
            <%=r.getSelect("vezikylo_ygol")%>
        </td>
    </tr>
    <tr> 
        <td colspan="3" class="simple_str">Парапростатическое венозное сплетение
            <%=r.getSelect("spletenie")%>
        </td>
    </tr>
    <tr> 
        <td class="simple_str" width="24%">Гиперплазия 
            <%=r.getSelect("giperplaz")%>
        </td>
        <td colspan="2"> 
            <%=r.getChangeHidden("giperplaz", "7", "1742")%>
                за счет<br>
                <%=r.getCheckbox("cz")%>
                <br>
                <%=r.getCheckbox("zpj")%>
                <br>
                <%=r.getCheckbox("pz")%>
                <br>
                <%=r.getCheckbox("ipz")%>
                <br>
                <%=r.getCheckbox("withy")%>
                <%=r.getTextInput("yzloobraz_how")%><br>
                <%=r.getCheckbox("perehod")%>
            </div>
        </td>
    </tr>
    <tr>
        <td colspan="3"> 
            <%=r.getCheckbox("perefir")%>
        </td>
    </tr>
    <tr>
        <td width="24%" class="simple_str">Очаговые изменения 
            <%=r.getSelect("ochagi")%>
        </td>
        <td colspan="2">
            <%=r.getChangeHidden("ochagi", "8", "267")%>
                <%=r.getCheckbox("inpz")%>
                <br>
                <%=r.getCheckbox("incz")%>
                <br>
                <%=r.getCheckbox("inpfz")%>
                <br>
                <%=r.getCheckbox("pebchkr")%>
                <%=r.getSizeInput("ehogennosti_how")%>мм<br>
            </div>
        </td>
    </tr>
</table>
</div><br>
<SCRIPT LANGUAGE="JavaScript">
    changeHidden63();
    document.protocol.predstat.onchange  = changeHidden63
    function changeHidden63()
    {
        if(document.protocol.predstat.value == "6602"){
            display63.style.display = "none";
        }else{
            display63.style.display = "";
        }
    }
</SCRIPT>

<table width="100%" border="1">
    <tr> 
        <td class="underline_str">Семенные пузырьки
            <%=r.getSizeInput("puzirki_how")%>мм
            <%=r.getSelect("puzirkisim")%>
        </td>
    </tr>
</table>

<font class="underline_str"><b>Мочевой пузырь</b></font>
    <%=r.getSelect("mochpuzir")%><br>

<table width="100%" border="1">
    <tr> 
        <td class="simple_str">Стенка
        </td>
        <td>
            <%=r.getSelect("stenka")%>
        </td>
    </tr>
    <tr>
        <td class="simple_str">Содержимое
        </td>
        <td>
            <%=r.getSelect("soderjimoe")%>
        </td>   
    <tr> 
        <td class="simple_str">Объемные образования
        </td>
        <td>
            <%=r.getSelect("obrazovanija")%>
            <%=r.getSizeInput("obrazov1")%>
            <%=r.getSizeInput("obrazov2")%>
        </td>
    </tr>
    <tr>
        <td class="simple_str">Конкременты
        </td>
        <td>
            <%=r.getSelect("konkrimenti")%>
            <%=r.getSizeInput("konkrim1")%>
            <%=r.getSizeInput("konkrim2")%>
        </td>
    </tr>
    <tr> 
        <td class="simple_str">Шейка мочевого пузыря
        </td>
        <td>
            <%=r.getSelect("sheika")%>
        </td>
    </tr>
    <tr> 
        <td class="simple_str">Объем остаточной мочи составляет
        </td>
        <td><%=r.getSizeInput("obiem_mochi")%>мл
        </td>
    </tr>
</table>
<Script>
  document.protocol.jeleza_r1.onchange = executeRange
  document.protocol.jeleza_r2.onchange = executeRange
  document.protocol.jeleza_r3.onchange = executeRange
  function executeRange()
  { jeleza_r1 = parseFloat(document.protocol.jeleza_r1.value);
    jeleza_r2 = parseFloat(document.protocol.jeleza_r2.value);
    jeleza_r3 = parseFloat(document.protocol.jeleza_r3.value);

    if (isNaN(parseFloat(document.protocol.jeleza_r1.value)) && document.protocol.jeleza_r1.value!="") {notFloat(); document.protocol.jeleza_obem.value = "";}
    if (isNaN(parseFloat(document.protocol.jeleza_r2.value)) && document.protocol.jeleza_r2.value!="") {notFloat(); document.protocol.jeleza_obem.value = "";}
    if (isNaN(parseFloat(document.protocol.jeleza_r3.value)) && document.protocol.jeleza_r3.value!="") {notFloat(); document.protocol.jeleza_obem.value = "";}

    if(document.protocol.jeleza_r1.value != "" && document.protocol.jeleza_r2.value != "" && document.protocol.jeleza_r3.value != ""){
        document.protocol.jeleza_obem.value = cut(((jeleza_r1 * jeleza_r2 * jeleza_r3)/1000)*0.479);
    }
  }
  function cut(arg){
    arg = arg.toString();
    array_arg = arg.split(".");
    if (array_arg[1]){
      vr = array_arg[1];
      vr = vr.substring(0,2);
      arg = array_arg[0] + "." + vr;
    }
    return arg;
  }
  function notFloat(){
    alert("Необходимо ввести число. Знаком разделения целой и дробной части служит точка.")
  }
</Script>

<%@include file="footer.jsp"%>
