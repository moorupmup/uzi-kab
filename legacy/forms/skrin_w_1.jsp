<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>

 <H3 class="p_title">УЗИ-скрининг для диспансерного осмотра (женщины)</H3>



<table width="90%" border="1">
    <tr>
        <td colspan="4" class="p_title"><b>ЩИТОВИДНАЯ ЖЕЛЕЗА</b></td>
    </tr>
    
    
    <tr>
        <td colspan="4" class="simple_str">Щитовидная железа
            <%=r.getSelect("jeleza")%>
        </td>
    </tr>
    <tr>
        <td width="17%" class="simple_str">Контур
        </td>
        <td colspan="3">
            <%=r.getSelect("kontur")%>
    </tr>
    <tr>
        <td colspan="4" class="simple_str">Размеры
        </td>
    </tr>
    <tr>
        <td width="17%" class="simple_str">Правая доля
        </td>
        <td colspan="3">
            Ширина<%=r.getSizeInput("rdolaj_sh")%>
            Толщина<%=r.getSizeInput("rdolaj_tol")%>
            Длина<%=r.getSizeInput("rdolaj_dl")%>
            <font class="ed_izm">(мм)</font>
        </td>
    </tr>
    <tr>
        <td width="17%" class="simple_str">Левая доля
        </td>
        <td colspan="3">
            Ширина<%=r.getSizeInput("ldolaj_sh")%>
            Толщина<%=r.getSizeInput("ldolaj_tol")%>
            Длина<%=r.getSizeInput("ldolaj_dl")%>
            <font class="ed_izm">(мм)</font>
        </td>
    </tr>
    <tr>                                        
        <td width="17%" class="simple_str">Перешеек
        </td>
        <td colspan="3">
            <%=r.getSizeInput("peresheek")%>
            <font class="ed_izm">(мм)</font>
    </tr>
    <tr>
        <td width="17%" class="simple_str">Тиреоидный объем
        </td>
        <td colspan="3">
            <%=r.getSizeInput("tir_obem")%>
            <font class="ed_izm">(мл)</font>
        </td>
    </tr>
    <tr>
        <td width="17%" class="simple_str">Эхогенность
        </td>
        <td colspan="3">
            <%=r.getSelect("ehogennost")%>
        </td>
    </tr>
    <tr>
        <td colspan="4" class="simple_str">Эхоструктура
            <%=r.getSelect("ehostructura")%>в сочетании с <%=r.getSelect("sochetanie")%>
        </td>
    </tr>
    <tr>
        <td colspan="4">
            Шейные лимфоузлы <%=r.getSelect("sh_limfoyzli")%>
        </td>
    </tr>
</table>

     <div id="display1" style="display:none;position:relative; left:0;">
        <table width="90%" border="1">
        <tr><td>расположены цепочкой, обычной эхоструктуры, с четкими контурами</td>
        </tr>
        </table>
     </div>

     <div id="display2" style="display:none;position:relative; left:0;">
        <table width="90%" border="1">
        <tr><td><%=r.getCheckbox("sh_gde1")%>
            <br><%=r.getCheckbox("sh_gde2")%>
            <br><%=r.getCheckbox("sh_gde3")%> <%=r.getSizeInput("limf_v")%>
            <br><%=r.getCheckbox("sh_gde4")%> <%=r.getSizeInput("limf_s")%>
            <br><%=r.getCheckbox("sh_gde5")%> <%=r.getSizeInput("limf_n")%>
            <br>структура <%=r.getSelect("sh_str_limfoyzli")%> 
            <br>контур <%=r.getSelect("sh_kontur_limfoyzli")%> 
            </td>
        </tr>
        </table>
     </div>

<SCRIPT LANGUAGE="JavaScript">
    changeHidden1();
    document.protocol.sh_limfoyzli.onchange  = changeHidden1
    function changeHidden1()
    {
        if(document.protocol.sh_limfoyzli.value == "8249"){
            display1.style.display = "";
            display2.style.display = "none";

        }if(document.protocol.sh_limfoyzli.value == "8250"){
            display2.style.display = "";
            display1.style.display = "none";

        }
    }
</SCRIPT>

    <table width="90%" border="1">
    <tr><td colspan="4">
            Подчелюстные лимфоузлы <%=r.getSelect("chel_limfoyzli")%>
        </td>
    </tr>
    </table>

     <div id="display3" style="display:none;position:relative; left:0;">
        <table width="90%" border="1">
        <tr><td><%=r.getSizeInput("chel_size")%>
        <br>структура <%=r.getSelect("chel_str_limfoyzli")%> 
            <br>контур <%=r.getSelect("chel_kontur_limfoyzli")%> 
            </td>
        </tr>
        </table>
     </div>

<SCRIPT LANGUAGE="JavaScript">
    changeHidden3();
    document.protocol.chel_limfoyzli.onchange  = changeHidden3
    function changeHidden3()
    {
        if(document.protocol.chel_limfoyzli.value == "8263"){
            display3.style.display = "none";

        }if(document.protocol.chel_limfoyzli.value == "8264"){
            display3.style.display = "";

        }
    }
</SCRIPT>

    <table width="90%" border="1">
        <tr>
        <td colspan="4">
            Надключичные лимфоузлы <%=r.getSelect("nadkl_limfoyzli")%>
        </td>
        </tr>
    </table>

     <div id="display4" style="display:none;position:relative; left:0;">
        <table width="90%" border="1">
        <tr><td><%=r.getSizeInput("nadkl_size")%>
        <br>структура <%=r.getSelect("nadkl_str_limfoyzli")%> 
            <br>контур <%=r.getSelect("nadkl_kontur_limfoyzli")%> 
            </td>
        </tr>
        </table>
     </div>

<SCRIPT LANGUAGE="JavaScript">
    changeHidden4();
    document.protocol.nadkl_limfoyzli.onchange  = changeHidden4
    function changeHidden4()
    {
        if(document.protocol.nadkl_limfoyzli.value == "8263"){
            display4.style.display = "none";

        }if(document.protocol.nadkl_limfoyzli.value == "8264"){
            display4.style.display = "";

        }
    }
</SCRIPT>

    <table width="90%" border="1">
        <tr>
        <td colspan="4">
            Подключичные лимфоузлы <%=r.getSelect("podkl_limfoyzli")%>
        </td>
        </tr> 
    </table>

     <div id="display5" style="display:none;position:relative; left:0;">
        <table width="90%" border="1">
        <tr><td><%=r.getSizeInput("podkl_size")%>
        <br>структура <%=r.getSelect("podkl_str_limfoyzli")%> 
            <br>контур <%=r.getSelect("podkl_kontur_limfoyzli")%> 
            </td>
        </tr>
        </table>
     </div>

<SCRIPT LANGUAGE="JavaScript">
    changeHidden5();
    document.protocol.podkl_limfoyzli.onchange  = changeHidden5
    function changeHidden5()
    {
        if(document.protocol.podkl_limfoyzli.value == "8263"){
            display5.style.display = "none";

        }if(document.protocol.podkl_limfoyzli.value == "8264"){
            display5.style.display = "";

        }
    }
</SCRIPT>






<table width="90%" border="1">
    <tr><td><b><%=r.getCheckbox("moloch")%></b></td></tr>
</table>

<div id="display100" style="display:none;position:relative; left:0;">

<table width="90%" border="1">
<tr> 
    <td class="simple_str">День цикла
        <%=r.getSizeInput("den")%>
    </td>
</tr>
<tr> 
    <td class="simple_str">Кожный покров
        <%=r.getSelect("pokrov")%>
        <%=r.getSizeInput("pokrov_how")%>мм
    </td>
</tr>
<tr> 
    <td class="simple_str">Область соска
        <%=r.getSelect("sosok")%>
    </td>
</tr>
<tr> 
    <td class="simple_str">Молочные железы представлены 
        <%=r.getSelect("m_jeleza")%>
    </td>
</tr>
<tr>
    <td> Паренхима
        <%=r.getSelect("parenhima")%>
    </td>
</tr>
<tr> 
    <td class="simple_str">Млечные протоки
          <%=r.getSelect("protoki")%>
        до
          <%=r.getSizeInput("protoki_how")%>     
      <font class="ed_izm">мм</font>
    </td>
</tr>
<tr> 
    <td class="simple_str">Региональные лимфатические узлы
         <%=r.getSelect("limf")%>
        до 
        <%=r.getSizeInput("limf_how")%>      
        <font class="ed_izm">мм</font>
    </td>
</tr>
<tr>
    <td>Соединительная ткань
        <%=r.getSelect("tkani")%>
    </td>
</tr>
</table>
</div>

<SCRIPT LANGUAGE="JavaScript">
    changeHidden100();
    document.protocol.moloch.onclick  = changeHidden100
    function changeHidden100()
    {
        if(document.protocol.moloch.checked == true){
            display100.style.display = "";
        }else{
            display100.style.display = "none";
        }
    }
</SCRIPT>









<table width="90%" border="1">

  <tr> 
    <td colspan="3" class="simple_str"><b>ОРГАНЫ БРЮШНОЙ ПОЛОСТИ</b> 
  </tr>
  <tr> 
    <td colspan="3" class="simple_str"><b>Печень</b> 
    <%=r.getSelect("pech_kak")%>
    <%=r.getSizeInput("yvel")%>мм</td>
  </tr>
  
  <tr> 
    <td width="135" class="simple_str">Толщина</td>
    <td width="118" class="simple_str">правой доли</td>
    <td width="426"> 
      <%=r.getSizeInput("tol_prav")%>мм
  <SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.tol_prav.value == "") document.protocol.tol_prav.value = "125";
  </script>
    </td>
  </tr>
  <tr> 
    <td width="135">&nbsp;</td>
    <td width="118" class="simple_str">левой доли</td>
    <td width="426"> 
      <%=r.getSizeInput("tol_lev")%>мм
  <SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.tol_lev.value == "") document.protocol.tol_lev.value = "44";
  </script>
    </td>
  </tr>
  <tr> 
    <td colspan="2" class="simple_str">Контур</td>
    <td> 
        <%=r.getSelect("kontur_pech")%>
    </td>
  </tr>

  <tr> 
    <td colspan="2" class="simple_str">Структура</td>
    <td width="426"> 
        <%=r.getSelect("strukt_pech")%>
    </td>
  </tr>
  <tr> 
    <td colspan="2" class="simple_str">Эхогенность</td>
    <td width="426"> 
        <%=r.getSelect("eho_pech")%>
    </td>
  </tr>
  <tr> 
    <td colspan="2" class="simple_str">Внутрипеченочные желчные протоки</td>
    <td width="426"> 
        <%=r.getSelect("protok_pech")%>
    </td>
  </tr>
  <tr> 
    <td colspan="2" class="simple_str">Холедох</td>
    <td width="426"> 
      <%=r.getSizeInput("hole_pech")%>мм
  <SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.hole_pech.value == "") document.protocol.hole_pech.value = "4";
  </script>
    </td>
  </tr>
  <tr> 
    <td colspan="2" class="simple_str">Сосуды печени </td>
    <td width="426"> 
        <%=r.getSelect("sos_pechen")%>
    </td>
  </tr>
  <tr> 
    <td colspan="2" class="simple_str">Портальная вена </td>
    <td width="426"> 
      <%=r.getSizeInput("portal")%>мм
  <SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.portal.value == "") document.protocol.portal.value = "10";
  </script>
    </td>
  </tr>
  <tr> 
    <td colspan="2" class="simple_str">На высоте максимального вдоха диаметр портальной 
      вены</td>
    <td width="426"> 
      <%=r.getSizeInput("vena_st")%>
  <SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.vena_st.value == "") document.protocol.vena_st.value = "9";
  </script>                                                                     
        <%=r.getSelect("vena_pech")%>
    </td>
  </tr>
  <tr> 
    <td colspan="2" class="simple_str">В воротах печени л/узлы </td>
    <td width="426"> 
        <%=r.getSelect("yzli_pech")%>
    </td>
  </tr>
</table>


<table width="90%" border="1">
  <tr> 
    <td colspan="2" class="simple_str"><b>Желчный пузырь</b><%=r.getSelect("puzir")%> </td>
  </tr>
  <tr> 
    <td width="36%" class="simple_str">Размеры</td>
    <td width="64%"> 
      <%=r.getSizeInput("puzr_raz1_puz")%>*
      <%=r.getSizeInput("puzr_raz2_puz")%>
  <SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.puzr_raz1_puz.value == "") document.protocol.puzr_raz1_puz.value = "35";
    if (document.protocol.puzr_raz2_puz.value == "") document.protocol.puzr_raz2_puz.value = "68";
  </script>

      <span class="ed_izm">мм</span></td>
  </tr>
  <tr> 
    <td width="36%" class="simple_str">Стенка</td>
    <td width="64%"> 
        <%=r.getSelect("stenka_puz")%>
    </td>
  </tr>
  <tr> 
    <td width="36%" class="simple_str">Толщина стенки желчного пузыря</td>
    <td width="64%"> 
      <%=r.getSizeInput("jel_puz")%>
  <SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.jel_puz.value == "") document.protocol.jel_puz.value = "2";
  </script>
      <span class="ed_izm">мм</span></td>
  </tr>
  <tr> 
    <td width="36%" class="simple_str">В полости</td>
    <td width="64%"> 
        <%=r.getSelect("polos_puz")%>
    </td>
  </tr>
  <tr> 
    <td width="36%" class="simple_str">Конкременты</td>
    <td width="64%"> 
        <%=r.getSelect("konkrement_puz")%> 
        <%=r.getSizeInput("konkrement_how_puz")%>мм
    </td>
  </tr>
</table>



<table width="90%" border="1">
  <tr> 
    <td colspan="3" class="simple_str"><b>Поджелудочная железа</b><%=r.getSelect("pod_jelez")%></td>
  </tr>
  <tr> 
    <td width="13%" class="simple_str">Размер</td>
    <td width="12%" class="simple_str">головка</td>
    <td> 
      <%=r.getSizeInput("golov_podj")%>
  <SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.golov_podj.value == "") document.protocol.golov_podj.value = "25";
  </script>

      <span class="ed_izm">мм</span></td>
  </tr>
  <tr> 
    <td width="13%" class="simple_str">&nbsp;</td>
    <td width="12%" class="simple_str">тело</td>
    <td> 
      <%=r.getSizeInput("telo_podj")%>
  <SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.telo_podj.value == "") document.protocol.telo_podj.value = "12";
  </script>

      <span class="ed_izm">мм</span></td>
  </tr>
  <tr> 
    <td width="13%" class="simple_str">&nbsp;</td>
    <td width="12%" class="simple_str">хвост</td>
    <td> 
      <%=r.getSizeInput("hvost_podj")%>
  <SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.hvost_podj.value == "") document.protocol.hvost_podj.value = "19";
  </script>

      <span class="ed_izm">мм</span></td>
  </tr>
  <tr> 
    <td colspan="2" class="simple_str">Контур</td>
    <td> 
        <%=r.getSelect("kontur_podj")%>
    </td>
  </tr>
  <tr> 
    <td colspan="2" class="simple_str">Структура</td>
    <td> 
        <%=r.getSelect("strukt_podj")%>
    </td>
  </tr>
  <tr> 
    <td colspan="2" class="simple_str">Эхогенность</td>
    <td> 
        <%=r.getSelect("ehog_podj")%>
    </td>
  </tr>
  <tr> 
    <td colspan="2" class="simple_str">Вирсунгов проток</td>
    <td> 
        <%=r.getSelect("prot_podj")%>
      <%=r.getSizeInput("rash_podj")%>
      <span class="ed_izm">мм</span></td>

    </td>
  </tr>
  <tr> 
    <td colspan="2" class="simple_str">Диаметр селезеночной вены </td>
    <td> 
      <%=r.getSizeInput("diam_selez_podj")%>мм
  <SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.diam_selez_podj.value == "") document.protocol.diam_selez_podj.value = "7";
  </script>

    </td>
  </tr>
</table>


<table width="90%" border="1">
  <tr> 
    <td colspan="2" class="simple_str"><b>Брюшной отдел аорты</b> <%=r.getSelect("aorta_bru")%></td>
    <td> 
  </tr>
  <tr> 
    <td width="29%" class="simple_str">Диаметр</td>
    <td width="71%"> 
      <%=r.getSizeInput("diam_bru")%>мм
  <SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.diam_bru.value == "") document.protocol.diam_bru.value = "15";
  </script>

  <tr> 
    <td width="29%" class="simple_str">Склеротические изменения</td>
    <td width="71%"> 
        <%=r.getSelect("skler_bru")%>
    </td>
  </tr>
</table>


<table width="90%" border="1">
  <tr> 
    <td colspan="2" class="simple_str"><b>Селезенка</b><%=r.getSelect("selezen")%></td>
    <td> 
  </tr>
  <tr> 
    <td width="12%" class="simple_str">Структура</td>
    <td> 
        <%=r.getSelect("strukt_selezen")%>
    </td>
  </tr>
  <tr> 
    <td width="12%" class="simple_str">Площадь</td>
    <td > 
      <%=r.getSizeInput("pl_selezen")%>
  <SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.pl_selezen.value == "") document.protocol.pl_selezen.value = "36";
  </script>
      <span class="ed_izm">см2</span></td>
  </tr>
</table>












<Script>
  document.protocol.rdolaj_sh.onchange = executeRange
  document.protocol.rdolaj_tol.onchange = executeRange
  document.protocol.rdolaj_dl.onchange = executeRange
  document.protocol.ldolaj_sh.onchange = executeRange
  document.protocol.ldolaj_tol.onchange = executeRange
  document.protocol.ldolaj_dl.onchange = executeRange
 
  function executeRange()
  { r_dol_sh = parseFloat(document.protocol.rdolaj_sh.value);
    r_dol_tol = parseFloat(document.protocol.rdolaj_tol.value);
    r_dol_dl = parseFloat(document.protocol.rdolaj_dl.value);
    l_dol_sh = parseFloat(document.protocol.ldolaj_sh.value);
    l_dol_tol = parseFloat(document.protocol.ldolaj_tol.value);
    l_dol_dl = parseFloat(document.protocol.ldolaj_dl.value);

    if (isNaN(parseFloat(document.protocol.rdolaj_sh.value)) && document.protocol.rdolaj_sh.value!="") {notFloat();}
    if (isNaN(parseFloat(document.protocol.rdolaj_tol.value)) && document.protocol.rdolaj_tol.value!="") {notFloat();}
    if (isNaN(parseFloat(document.protocol.rdolaj_dl.value)) && document.protocol.rdolaj_dl.value!="") {notFloat();}
    if (isNaN(parseFloat(document.protocol.ldolaj_sh.value)) && document.protocol.ldolaj_sh.value!="") {notFloat();}
    if (isNaN(parseFloat(document.protocol.ldolaj_tol.value)) && document.protocol.ldolaj_tol.value!="") {notFloat();}
    if (isNaN(parseFloat(document.protocol.ldolaj_dl.value)) && document.protocol.ldolaj_dl.value!="") {notFloat();}

    if(document.protocol.rdolaj_sh.value != "" && document.protocol.rdolaj_tol.value != "" && document.protocol.rdolaj_dl.value != "" && document.protocol.ldolaj_sh.value != "" && document.protocol.ldolaj_tol.value != "" && document.protocol.ldolaj_dl.value != ""){
        r_dol = cut(r_dol_sh * r_dol_tol * r_dol_dl)/1000;
        l_dol = cut(l_dol_sh * l_dol_tol * l_dol_dl)/1000;
        document.protocol.tir_obem.value = cut((r_dol + l_dol)*0.479);
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
