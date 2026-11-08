<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title">Ультразвуковое гинекологическое исследование (трансабдоминальное/трансвагинальное)</H3>
<br><br>

<table width="90%" border="1">
  <tr> 
    <td width="18%" class="simple_str">День цикла</td>
    <td> 
        <%=r.getSizeInput("dayc")%>
        <SCRIPT LANGUAGE="JavaScript">
            document.protocol.dayc.focus();
            document.protocol.dayc.onkeyup = point
            function point(){
                checkDate("document.protocol.dayc");
            }
        </script>
    </td>
  </tr>
  <tr> 
    <td width="18%" class="simple_str">Менопауза</td>
    <td> 
      <%=r.getSizeInput("menop")%>
      <font class="simple_str">лет</font></td></tr></table>

<font class="underline_str"><b>Тело матки</b></font>
    <%=r.getSelect("polojen")%>

<table width="90%" border="1">
  <tr> 
    <td width="28%" class="bold_str">размеры</td>
    <td width="72%"> 
      <%=r.getSelect("razmeri")%></td>
  </tr>
  <tr> 
    <td class="simple_str" width="28%">длина</td>
    <td width="72%"> 
      <%=r.getSizeInput("dlina_m")%>
      <font class="ed_izm">мм</font> <span class="simple_str">(N от 40 до 60 мм)</span></td>
  </tr>
  <tr> 
    <td class="simple_str" width="28%">толщина</td>
    <td width="72%"> 
      <%=r.getSizeInput("tolshina_m")%>
      <font class="ed_izm">мм</font> <span class="simple_str">(N от 30 до 45 мм)</span></td>
  </tr>
  <tr> 
    <td class="simple_str" width="28%">толщина передней стенки</td>
    <td width="72%"> 
      <%=r.getSizeInput("persten_m")%>
      <font class="ed_izm">мм</font></td>
  </tr>
  <tr> 
    <td class="simple_str" width="28%">толщина задней стенки</td>
    <td width="72%"> 
      <%=r.getSizeInput("zadsten_m")%>
      <font class="ed_izm">мм</font></td>
  </tr>
  <tr> 
    <td class="simple_str" width="28%">ширина</td>
    <td width="72%"> 
      <%=r.getSizeInput("shir_m")%>
      <font class="ed_izm">мм</font> <span class="simple_str">(N от 45 до 60 мм)</span></td>
  </tr>
  <tr> 
    <td class="simple_str" width="28%">форма</td>
    <td width="72%">
      <%=r.getSelect("forma_gl")%>
    </td>
  </tr>
</table>
<%=r.get("miom")%><br>
<font class="underline_str"><b>Эндометрий</b></font><%=r.getSelect("endom_vyr")%>
<%=r.getChangeHidden("endom_vyr", "0", "5947")%>
    <table width="90%" border="1">
      <tr> 
        <td width="18%" class="bold_str">толщина</td>
        <td width="19%"> 
          <%=r.getSizeInput("tolshina_e")%>
          <font class="ed_izm">мм</font></td>
        <td colspan="2">
          <%=r.getSelect("endom")%>
        </td>
      </tr>
      <tr> 
        <td width="18%" class="bold_str">структура</td>
        <td width="19%"> 
          <%=r.getSelect("struct_e")%>          
        </td>
        <td colspan="2">&nbsp;</td>
      </tr>
      <tr> 
        <td width="18%" class="bold_str">контуры</td>
        <td colspan="2" class="simple_str">эндометрия на границе с внутренним мышечным 
          слоем</td>
        <td class="simple_str" width="24%"> 
          <%=r.getSelect("gran")%>          
        </td>
      </tr>
      <tr> 
        <td width="18%">&nbsp;</td>
        <td colspan="3" class="simple_str">кальцинаты 
          <%=r.getSelect("kalch")%>
        </td>
      </tr>
    </table>
</div>
<table width="90%" border="1">
    <tr> 
      <td width="18%" class="simple_str">Полость матки</td>
      <td colspan="3"> 
        <%=r.getSelect("polost")%>
        <span class="simple_str">до</span> 
          <%=r.getSizeInput("ras")%>
        <font class="ed_izm">мм</font></td>
    </tr>
    <tr> 
      <td width="18%">&nbsp;</td>
      <td width="19%"> 
        <%=r.getSelect("deform")%>
      </td>
      <td colspan="2" class="simple_str">
          <%=r.getChangeHidden("deform", "1", "773")%>
              за счет<br>
              <%=r.getCheckbox("polipo")%>
              <%=r.getSizeInput("polipo_how")%>мм<br>
              <%=r.getCheckbox("yzel")%>
              <%=r.getSizeInput("yzel_how")%>мм<br>
              <%=r.getCheckbox("obem")%>
              <%=r.getSizeInput("obem_how")%>мм<br>
              <%=r.getCheckbox("ottesn")%>
          </div>
      </td>
    </tr>
</table>
<font class="underline_str"><b>Шейка матки</b><%=r.getSelect("ydalena")%></font>

<table width="90%" border="1">
  <tr> 
    <td width="15%" class="bold_str">размеры</td>
    <td width="11%" class="simple_str">длина </td>
    <td colspan="2"> 
      <%=r.getSizeInput("dl_sm")%>
        <font class="ed_izm">мм</font></td>
    <td width="61%" class="simple_str">(N от 20 до 30 мм)</td></tr>
  <tr> 
    <td width="15%">&nbsp;</td>
    <td width="11%" class="simple_str">ширина</td>
    <td colspan="2"> 
      <%=r.getSizeInput("shir_sm")%>
        <font class="ed_izm">мм</font></td>
    <td width="61%" class="simple_str">(N от 20 до 30 мм)</td></tr>
  <tr> 
    <td width="15%">&nbsp;</td>
    <td width="11%" class="simple_str">толщина</td>
    <td colspan="2"> 
      <%=r.getSizeInput("tol_sm")%>
        <font class="ed_izm">мм</font></td>
    <td width="61%" class="simple_str">(N от 15 до 20 мм)</td></tr></table>

<table width="90%" border="1">
  <tr>
    <td width="15%">Структура</td>
    <td width="24%">
      <%=r.getSelect("struct_sm")%></td>
    <td width="61%"> 
      <%=r.getSelect("zach")%></td></tr>
  <tr>
    <td width="15%">&nbsp;</td>
    <td width="24%"> 
      <%=r.getSelect("odn")%></td>
    <td width="61%" class="simple_str">структуры размерами 
      <%=r.getSizeInput("raz")%>
        <font class="ed_izm">мм</font>
    </td>
  </tr>
  <tr>
    <td>Контуры</td>
    <td colspan="2">
      <%=r.getSelect("kontur")%>
    </td>
  </tr>
  <tr>
    <td colspan="2" class="bold_str">цервикальный канал</td>
    <td> 
      <%=r.getSelect("cerv")%> до 
      <%=r.getSizeInput("kanal")%>
        <font class="ed_izm">мм</font><br>
      <%=r.getTextInput("kanal_text")%>
    </td>
  </tr>
  <tr>
    <td colspan="2" class="bold_str">Эндоцервикс</td>
    <td> 
      <%=r.getSelect("cerviks")%> 
      <%=r.getSizeInput("cerviks_how")%>
        <font class="ed_izm">мм</font>
    </td>
  </tr>
</table>
      
<font class="underline_str"><b>Правый яичник</b><%=r.getSelect("r_ydalen")%></font>

<table width="90%" border="1">
  <tr> 
    <td width="18%" class="simple_str">размеры</td>
    <td width="13%" class="simple_str">длина</td>
    <td width="17%"> 
      <%=r.getSizeInput("dl_rj")%>
        <font class="ed_izm">мм</font></td>
    <td width="52%" class="simple_str">(N от 20 до 35 мм)</td></tr>
  <tr> 
    <td width="18%" class="simple_str">&nbsp;</td>
    <td width="13%" class="simple_str">толщина</td>
    <td width="17%"> 
      <%=r.getSizeInput("tolh_rj")%>
        <font class="ed_izm">мм</font></td>
    <td width="52%" class="simple_str">(N от 15 до 25 мм)</td></tr>
  <tr> 
    <td width="18%" class="simple_str">&nbsp;</td>
    <td width="13%" class="simple_str">ширина</td>
    <td width="17%"> 
      <%=r.getSizeInput("shir_rj")%>
        <font class="ed_izm">мм</font></td>
    <td width="52%" class="simple_str">(N от 20 до 30 мм)</td></tr>
   <tr>
   <td width="18%" class="simple_str">&nbsp;</td>
   <td width="13%" class="simple_str">Объем</td>
    <td width="17%"> 
      <%=r.getSizeInput("rj_obem")%>
        <font class="ed_izm">мм3</font></td>
    <td width="52%" class="simple_str">&nbsp;</td></tr>
    </table>
<Script>
  document.protocol.dl_rj.onchange = executeRange1
  document.protocol.tolh_rj.onchange = executeRange1
  document.protocol.shir_rj.onchange = executeRange1
  function executeRange1()
  { jeleza_r1 = parseFloat(document.protocol.dl_rj.value);
    jeleza_r2 = parseFloat(document.protocol.tolh_rj.value);
    jeleza_r3 = parseFloat(document.protocol.shir_rj.value);

    if (isNaN(parseFloat(document.protocol.dl_rj.value)) && document.protocol.dl_rj.value!="") {notFloat(); document.protocol.rj_obem.value = "";}
    if (isNaN(parseFloat(document.protocol.tolh_rj.value)) && document.protocol.tolh_rj.value!="") {notFloat(); document.protocol.rj_obem.value = "";}
    if (isNaN(parseFloat(document.protocol.shir_rj.value)) && document.protocol.shir_rj.value!="") {notFloat(); document.protocol.rj_obem.value = "";}

    if(document.protocol.dl_rj.value != "" && document.protocol.tolh_rj.value != "" && document.protocol.shir_rj.value != ""){
        document.protocol.rj_obem.value = cut(((jeleza_r1 * jeleza_r2 * jeleza_r3)/1000)*0.479);
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

<table width="90%" border="1">
  <tr> 
    <td width="18%" class="bold_str">форма</td>
    <td width="30%"> 
      <%=r.getSelect("forma_rj")%></td>
    <td width="52%">&nbsp;</td></tr>
  <tr> 
    <td width="18%" class="simple_str">Структура</td>
    <td width="30%">
      <%=r.getSelect("struct_rj")%></td>
    <td width="52%" class="simple_str">
        <%=r.getChangeHidden("struct_rj", "2", "791")%>
            за счет<br>
            <%=r.getCheckbox("r_jidkostnogo")%><%=r.getSizeInput("r_jidkostnogo_how")%>мм.<br>
            <%=r.getCheckbox("r_jidkost")%><%=r.getSizeInput("r_jidkost_how")%>мм.<br>
            <%=r.getCheckbox("r_difuziy")%><br>
            <%=r.getCheckbox("r_kalcinat")%><br>
            <%=r.getCheckbox("r_kista")%><%=r.getSizeInput("r_kista_how")%>мм. <%=r.getSelect("sel1")%> 
        </div>
    </td>
  </tr>
  <tr> 
    <td colspan="3" class="simple_str">Объемные образования в проекции правых придатков
      <%=r.getSelect("kist_rj")%>
      <%=r.getTextInput("kist_rj_text")%>
    </td>
  </tr>
  <tr>
    <td colspan="2" class="simple_str">Антральные фолликулы</td>
    <td><%=r.getSelect("r_follik")%></td>
  </tr>
  <tr> 
    <td colspan="3">
      <%=r.getTextInput("dop_rj")%>
    </td>
  </tr>
</table>

<font class="underline_str"><b>Левый яичник</b><%=r.getSelect("l_ydalen")%></font>

<table width="90%" border="1">
  <tr> 
    <td width="18%" class="simple_str">размеры</td>
    <td width="13%" class="simple_str">длина</td>
    <td width="17%"> 
      <%=r.getSizeInput("dl_lj")%>
        <font class="ed_izm">мм</font></td>
    <td width="52%" class="simple_str">(N от 20 до 35 мм)</td></tr>
  <tr> 
    <td width="18%" class="simple_str">&nbsp;</td>
    <td width="13%" class="simple_str">толщина</td>
    <td width="17%"> 
      <%=r.getSizeInput("tolh_lj")%>
        <font class="ed_izm">мм</font></td>
    <td width="52%" class="simple_str">(N от 15 до 25 мм)</td></tr>
  <tr> 
    <td width="18%" class="simple_str">&nbsp;</td>
    <td width="13%" class="simple_str">ширина</td>
    <td width="17%"> 
      <%=r.getSizeInput("shir_lj")%>
        <font class="ed_izm">мм</font></td>
    <td width="52%" class="simple_str">(N от 20 до 30 мм)</td></tr>
       <tr>
   <td width="18%" class="simple_str">&nbsp;</td>
   <td width="13%" class="simple_str">Объем</td>
    <td width="17%"> 
      <%=r.getSizeInput("lj_obem")%>
        <font class="ed_izm">мм3</font></td>
    <td width="52%" class="simple_str">&nbsp;</td></tr>
    </table>
<Script>
  document.protocol.dl_lj.onchange = executeRange1
  document.protocol.tolh_lj.onchange = executeRange1
  document.protocol.shir_lj.onchange = executeRange1
  function executeRange1()
  { jeleza_r1 = parseFloat(document.protocol.dl_lj.value);
    jeleza_r2 = parseFloat(document.protocol.tolh_lj.value);
    jeleza_r3 = parseFloat(document.protocol.shir_lj.value);

    if (isNaN(parseFloat(document.protocol.dl_lj.value)) && document.protocol.dl_lj.value!="") {notFloat(); document.protocol.lj_obem.value = "";}
    if (isNaN(parseFloat(document.protocol.tolh_lj.value)) && document.protocol.tolh_lj.value!="") {notFloat(); document.protocol.lj_obem.value = "";}
    if (isNaN(parseFloat(document.protocol.shir_lj.value)) && document.protocol.shir_lj.value!="") {notFloat(); document.protocol.lj_obem.value = "";}

    if(document.protocol.dl_lj.value != "" && document.protocol.tolh_lj.value != "" && document.protocol.shir_lj.value != ""){
        document.protocol.lj_obem.value = cut(((jeleza_r1 * jeleza_r2 * jeleza_r3)/1000)*0.479);
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

<table width="90%" border="1">
  <tr> 
    <td width="18%" class="bold_str">форма</td>
    <td width="30%"> 
      <%=r.getSelect("forma_lj")%></td>
    <td width="52%">&nbsp;</td></tr>
  <tr> 
    <td width="18%" class="simple_str">Структура</td>
    <td width="30%">
      <%=r.getSelect("struct_lj")%></td>
    <td width="52%" class="simple_str">
        <%=r.getChangeHidden("struct_lj", "3", "791")%>
            за счет<br>
            <%=r.getCheckbox("l_jidkostnogo")%><%=r.getSizeInput("l_jidkostnogo_how")%>мм.<br>
            <%=r.getCheckbox("l_jidkost")%><%=r.getSizeInput("l_jidkost_how")%>мм.<br>
            <%=r.getCheckbox("l_difuziy")%><br>
            <%=r.getCheckbox("l_kalcinat")%><br>
            <%=r.getCheckbox("l_kista")%><%=r.getSizeInput("l_kista_how")%>мм. <%=r.getSelect("sel3")%> 
        </div>
    </td>
  </tr>
  <tr> 
    <td colspan="3" class="simple_str">Объемные образования в проекции левых придатков
      <%=r.getSelect("kist_lj")%>
      <%=r.getTextInput("kist_lj_text")%>
    </td>
  </tr>
  <tr>
    <td colspan="2" class="simple_str">Антральные фолликулы</td>
    <td><%=r.getSelect("l_follik")%></td>
  </tr>
  <tr> 
    <td colspan="3">
      <%=r.getTextInput("dop_lj")%></td></tr></table>

<table width="90%" border="1">
  <tr> 
    <td width="52%" class="underline_str"><b>Жидкость в позадиматочном пространстве</b></td>
    <td width="48%"> 
      <%=r.getSelect("jid")%></td>
  </tr>
  <tr> 
    <td class="simple_str" width="52%"><b>Признаки спаечного процесса малого таза</b></td>
    <td width="20%"> 
      <%=r.getSelect("spai")%></td>
  </tr>
</table>

<table width="90%"><br>

<%@include file="footer.jsp"%>
