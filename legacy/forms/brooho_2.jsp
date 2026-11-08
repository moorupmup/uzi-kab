<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>

<H3 class="p_title">Ультразвуковое исследование органов брюшной полости</H3>
<br>
<font class="underline_str"><b>Печень</b></font> 
  <%=r.getSelect("pech_kak")%>
  <SCRIPT LANGUAGE="JavaScript">
  document.protocol.pech_kak.focus();
  </script>
  <%=r.getSizeInput("yvel")%>мм
<br>

<table width="90%" border="1">
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
        <%=r.getSelect("eho")%>
    </td>
  </tr>
  <tr> 
    <td colspan="2" class="simple_str">Внутрипеченочные желчные протоки</td>
    <td width="426"> 
        <%=r.getSelect("protok")%>
    </td>
  </tr>
  <tr> 
    <td colspan="2" class="simple_str">Холедох</td>
    <td width="426"> 
      <%=r.getSizeInput("hole")%>мм
  <SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.hole.value == "") document.protocol.hole.value = "4";
  </script>
    </td>
  </tr>
  <tr> 
    <td colspan="2" class="simple_str">Сосуды печени </td>
    <td width="426"> 
        <%=r.getSelect("pechen")%>
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
        <%=r.getSelect("vena")%>
    </td>
  </tr>
  <tr> 
    <td colspan="2" class="simple_str">В воротах печени л/узлы </td>
    <td width="426"> 
        <%=r.getSelect("yzli")%>
    </td>
  </tr>
</table>

<font class="underline_str"><b>Желчный пузырь</b></font>
    <%=r.getSelect("puzir")%>
<br>

<table width="90%" border="1">
  <tr> 
    <td width="36%" class="simple_str">Размеры</td>
    <td width="64%"> 
      <%=r.getSizeInput("puzr_raz1")%>*
      <%=r.getSizeInput("puzr_raz2")%>
  <SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.puzr_raz1.value == "") document.protocol.puzr_raz1.value = "35";
    if (document.protocol.puzr_raz2.value == "") document.protocol.puzr_raz2.value = "68";
  </script>

      <span class="ed_izm">мм</span></td>
  </tr>
  <tr> 
    <td width="36%" class="simple_str">Стенка</td>
    <td width="64%"> 
        <%=r.getSelect("stenka")%>
    </td>
  </tr>
  <tr> 
    <td width="36%" class="simple_str">Толщина стенки желчного пузыря</td>
    <td width="64%"> 
      <%=r.getSizeInput("jel")%>
  <SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.jel.value == "") document.protocol.jel.value = "2";
  </script>
      <span class="ed_izm">мм</span></td>
  </tr>
  <tr> 
    <td width="36%" class="simple_str">В полости</td>
    <td width="64%"> 
        <%=r.getSelect("polos")%>
    </td>
  </tr>
  <tr> 
    <td width="36%" class="simple_str">Конкременты</td>
    <td width="64%"> 
        <%=r.getSelect("konkrement")%> 
        <%=r.getSizeInput("konkrement_how")%>мм
    </td>
  </tr>
</table>

<font class="underline_str"><b>Поджелудочная железа</b></font> 
    <%=r.getSelect("jelez")%>
<br>

<table width="90%" border="1">
  <tr> 
    <td width="13%" class="simple_str">Размер</td>
    <td width="12%" class="simple_str">головка</td>
    <td> 
      <%=r.getSizeInput("golov")%>
  <SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.golov.value == "") document.protocol.golov.value = "25";
  </script>

      <span class="ed_izm">мм</span></td>
  </tr>
  <tr> 
    <td width="13%" class="simple_str">&nbsp;</td>
    <td width="12%" class="simple_str">тело</td>
    <td> 
      <%=r.getSizeInput("telo")%>
  <SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.telo.value == "") document.protocol.telo.value = "12";
  </script>

      <span class="ed_izm">мм</span></td>
  </tr>
  <tr> 
    <td width="13%" class="simple_str">&nbsp;</td>
    <td width="12%" class="simple_str">хвост</td>
    <td> 
      <%=r.getSizeInput("hvost")%>
  <SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.hvost.value == "") document.protocol.hvost.value = "19";
  </script>

      <span class="ed_izm">мм</span></td>
  </tr>
  <tr> 
    <td colspan="2" class="simple_str">Контур</td>
    <td> 
        <%=r.getSelect("kontur_jel")%>
    </td>
  </tr>
  <tr> 
    <td colspan="2" class="simple_str">Структура</td>
    <td> 
        <%=r.getSelect("strukt_jel")%>
    </td>
  </tr>
  <tr> 
    <td colspan="2" class="simple_str">Эхогенность</td>
    <td> 
        <%=r.getSelect("ehog")%>
    </td>
  </tr>
  <tr> 
    <td colspan="2" class="simple_str">Вирсунгов проток</td>
    <td> 
        <%=r.getSelect("prot")%>
      <%=r.getSizeInput("rash")%>
      <span class="ed_izm">мм</span></td>

    </td>
  </tr>
  <tr> 
    <td colspan="2" class="simple_str">Диаметр селезеночной вены </td>
    <td> 
      <%=r.getSizeInput("diam_selez")%>мм
  <SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.diam_selez.value == "") document.protocol.diam_selez.value = "7";
  </script>

    </td>
  </tr>
</table>

<font class="underline_str"><b>Брюшной отдел аорты</b></font> 
    <%=r.getSelect("aorta")%>
<br>

<table width="90%" border="1">
  <tr> 
    <td width="29%" class="simple_str">Диаметр</td>
    <td width="71%"> 
      <%=r.getSizeInput("diam")%>мм
  <SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.diam.value == "") document.protocol.diam.value = "15";
  </script>

  <tr> 
    <td width="29%" class="simple_str">Склеротические изменения</td>
    <td width="71%"> 
        <%=r.getSelect("skler")%>
    </td>
  </tr>
</table>

<font class="underline_str"><b>Селезенка</b></font>
    <%=r.getSelect("selez")%>
<br>

<table width="90%" border="1">
  <tr> 
    <td width="12%" class="simple_str">Структура</td>
    <td> 
        <%=r.getSelect("strukt_sel")%>
    </td>
  </tr>
  <tr> 
    <td width="12%" class="simple_str">Площадь</td>
    <td > 
      <%=r.getSizeInput("pl")%>
  <SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.pl.value == "") document.protocol.pl.value = "36";
  </script>
      <span class="ed_izm">см2</span></td>
  </tr>
</table>

<span class="bold_str"><b>ПРАВАЯ ПОЧКА</b></span> 
<%=r.getSelect("r_pochka")%>
<div id="display60" style="display:none;position:relative; left:0;">
<%=r.getSizeInput("r_pochka_how")%>мм
<table width="90%" border="1">
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
            <%=r.getSelect("r_polost")%>
        </td>
        <td width="66%">
            <%=r.getChangeHidden("r_polost", "1", "871")%>
                <span class="simple_str">за счет</span><br>
                <%=r.getCheckbox("r_chash")%>
                <%=r.getTextInput("r_shasheshki_how")%><br>
                <%=r.getCheckbox("r_lohanki")%>
                <%=r.getTextInput("r_lohanki_how")%>
            </div>
        </td>
    </tr>
    <tr> 
        <td colspan="4" class="simple_str"> 
            <%=r.getSelect("r_stru")%>
        </td>
    </tr>
    <tr> 
        <td colspan="4" class="simple_str">
            <%=r.getChangeHidden("r_stru", "2", "868")%>
                <span class="simple_str">за счет</span><br>
                <%=r.getCheckbox("r_oovp")%> 
                <%=r.getTextInput("r_obem_verh_how")%><br>
                <%=r.getCheckbox("r_oost")%>
                <%=r.getTextInput("r_obem_sredn_how")%><br>
                <%=r.getCheckbox("r_oonp")%>
                <%=r.getTextInput("r_obem_niz_how")%><br>
                <%=r.getCheckbox("r_jovp")%>
                <%=r.getTextInput("r_jid_verh_how")%><br>
                <%=r.getCheckbox("r_jost")%>
                <%=r.getTextInput("r_jid_sredn_how")%><br>
                <%=r.getCheckbox("r_jonp")%>
                <%=r.getTextInput("r_jid_niz_how")%><br>
                <%=r.getCheckbox("r_jop")%>
                <%=r.getTextInput("r_jid_paralel_how")%>
            </div>
        </td>
    </tr>
    <tr> 
        <td colspan="4" class="simple_str">Конкременты 
            <%=r.getSelect("r_konkrim")%>
        </td>
    </tr>
    <tr> 
        <td colspan="4" class="simple_str"> 
            <%=r.getChangeHidden("r_konkrim", "3", "875")%>
                <%=r.getCheckbox("r_vgch")%>
                <%=r.getSizeInput("r_verh_how")%>мм<br>
                <%=r.getCheckbox("r_sgch")%>
                <%=r.getSizeInput("r_sred_how")%>мм<br>
                <%=r.getCheckbox("r_ngch")%>
                <%=r.getSizeInput("r_niz_how")%>мм<br>
                <%=r.getCheckbox("r_pl")%>
                <%=r.getSizeInput("r_proekcii_how")%>мм
            </div>
        </td>
    </tr>
    <tr>
        <td colspan="4">
            <font class="underline_str">правый надпочечник </font> 
            <%=r.getSelect("r_nadpoch")%>
            <%=r.getSizeInput("r_nadpoch_how")%>мм
            <%=r.getTextInput("r_nadpochechnik_how")%>
        </td>
    </tr>
    <tr> 
        <td colspan="3" class="simple_str"><b>Ангиоархитектоника</b>
            <%=r.getSelect("r_angi")%>
        </td>
        <td colspan="1" class="simple_str"> 
            <%=r.getChangeHidden("r_angi", "7", "6076")%>
                Сосудистый рисунок:<%=r.getSelect("r_obogashen")%>
            </div>
        </td>
    </tr>
    <tr>
        <td colspan="4">
            <b>Ствол почечной артерии</b>
        </td>
    </tr>
    <tr>
        <td colspan="3">
            Тип кровотока
        </td>
        <td colspan="1">
            <%=r.getSelect("r_stvol_krovotok")%>
        </td>
    </tr>
    <tr>
        <td colspan="3">
            Пиковая систолическая скорость кровотока
        </td>
        <td colspan="1">
            <%=r.getSizeInput("r_stvol_sist_how")%>см/c (норма 73.6 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 26.4 см/с)
        </td>
    </tr>
    <tr>
        <td colspan="3">
            Конечная диастолическая скорость кровотока
        </td>
        <td colspan="1">
            <%=r.getSizeInput("r_stvol_diastol_how")%>см/c (норма 37.2 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 11.7 см/с)
        </td>
    </tr>
    <tr>
        <td colspan="3">
            Индекс резистентности
        </td>
        <td colspan="1">
            <%=r.getSizeInput("r_stvol_rezis_how")%> (норма 0.62 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 0.05)
        </td>
    </tr>
    <tr>
        <td colspan="4">
            <b>Сегментарные артерии</b>
        </td>
    </tr>
    <tr>
        <td colspan="3">
            Тип кровотока
        </td>
        <td colspan="1">
            <%=r.getSelect("r_arter_krovotok")%>
        </td>
    </tr>
    <tr>
        <td colspan="3">
            Пиковая систолическая скорость кровотока
        </td>
        <td colspan="1">
            <%=r.getSizeInput("r_arter_sist_how")%>см/c (норма 47 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 6 см/с)
        </td>
    </tr>
    <tr>
        <td colspan="3">
            Конечная диастолическая скорость кровотока
        </td>
        <td colspan="1">
            <%=r.getSizeInput("r_arter_diastol_how")%>см/c (норма 20 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 3 см/с)
        </td>
    </tr>
    <tr>
        <td colspan="3">
            Индекс резистентности
        </td>
        <td colspan="1">
            <%=r.getSizeInput("r_arter_rezis_how")%> (норма 0.6 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 0.05)
        </td>
    </tr>
    <tr>
        <td colspan="4">
            <b>Междолевые артерии</b>
        </td>
    </tr>
    <tr>
        <td colspan="3">
            Тип кровотока
        </td>
        <td colspan="1">
            <%=r.getSelect("r_megdol_krovotok")%>
        </td>
    </tr>
    <tr>
        <td colspan="3">
            Пиковая систолическая скорость кровотока
        </td>
        <td colspan="1">
            <%=r.getSizeInput("r_megdol_sist_how")%>см/c (норма 34 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 4 см/с)
        </td>
    </tr>
    <tr>
        <td colspan="3">
            Конечная диастолическая скорость кровотока
        </td>
        <td colspan="1">
            <%=r.getSizeInput("r_megdol_diastol_how")%>см/c (норма 14 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 2 см/с)
        </td>
    </tr>
    <tr>
        <td colspan="3">
            Индекс резистентности
        </td>
        <td colspan="1">
            <%=r.getSizeInput("r_megdol_rezis_how")%> (норма 0.59 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 0.04)
        </td>
    </tr>
    <tr>
        <td colspan="4">
            <b>Дуговые артерии</b>
        </td>
    </tr>
    <tr>
        <td colspan="3">
            Тип кровотока
        </td>
        <td colspan="1">
            <%=r.getSelect("r_dugov_krovotok")%>
        </td>
    </tr>
    <tr>
        <td colspan="3">
            Пиковая систолическая скорость кровотока
        </td>
        <td colspan="1">
            <%=r.getSizeInput("r_dugov_sist_how")%>см/c (норма 25 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 4 см/с)
        </td>
    </tr>
    <tr>
        <td colspan="3">
            Конечная диастолическая скорость кровотока
        </td>
        <td colspan="1">
            <%=r.getSizeInput("r_dugov_diastol_how")%>см/c (норма 11 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 2 см/с)
        </td>
    </tr>
    <tr>
        <td colspan="3">
            Индекс резистентности
        </td>
        <td colspan="1">
            <%=r.getSizeInput("r_dugov_rezis_how")%> (норма 0.59 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 0.02)
        </td>
    </tr>
    <tr>
        <td colspan="4">
            Устья почечной артерии
            <%=r.getSelect("r_ustj")%>
        </td>
    </tr>
    <tr>
        <td colspan="4">
            <%=r.getChangeHidden("r_ustj", "9", "6088")%>
                <%=r.getSelect("r_osmotr")%>
                <%=r.getChangeHidden("r_osmotr", "11", "6092")%>
                    Пиковая систолическая скорость кровотока
                    <%=r.getSizeInput("r_ustj_sist_how")%> см/с<br>
                    Конечная диастолическая скорость кровотока
                    <%=r.getSizeInput("r_ustj_diastol_how")%> см/с<br>
                    Рено - артальное соотношение
                    <%=r.getSizeInput("r_reno_how")%> (норма < 3.5)
                </div>
            </div>
        </td>
    </tr>
</table>
</div><br>
<SCRIPT LANGUAGE="JavaScript">
    changeHidden60();
    document.protocol.r_pochka.onchange  = changeHidden60
    function changeHidden60()
    {
        if(document.protocol.r_pochka.value == "1875" || document.protocol.r_pochka.value == "6603"){
            display60.style.display = "none";
        }else{
            display60.style.display = "";
        }
    }
</SCRIPT>

<span class="bold_str"><b>ЛЕВАЯ ПОЧКА</b></span> 
<%=r.getSelect("l_pochka")%>
<div id="display61" style="display:none;position:relative; left:0;">
<%=r.getSizeInput("l_pochka_how")%>мм
<table width="90%" border="1">
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
            <%=r.getSelect("l_polost")%>
        </td>
        <td width="66%">
            <%=r.getChangeHidden("l_polost", "4", "871")%>
                <span class="simple_str">за счет</span><br>
                <%=r.getCheckbox("l_chash")%>
                <%=r.getTextInput("l_shasheshki_how")%><br>
                <%=r.getCheckbox("l_lohanki")%>
                <%=r.getTextInput("l_lohanki_how")%>
            </div>
        </td>
    </tr>
    <tr> 
        <td colspan="4" class="simple_str"> 
            <%=r.getSelect("l_stru")%>
        </td>
    </tr>
    <tr> 
        <td colspan="4" class="simple_str">
            <%=r.getChangeHidden("l_stru", "5", "868")%>
                <span class="simple_str">за счет</span><br>
                <%=r.getCheckbox("l_oovp")%> 
                <%=r.getTextInput("l_obem_verh_how")%><br>
                <%=r.getCheckbox("l_oost")%>
                <%=r.getTextInput("l_obem_sredn_how")%><br>
                <%=r.getCheckbox("l_oonp")%>
                <%=r.getTextInput("l_obem_niz_how")%><br>
                <%=r.getCheckbox("l_jovp")%>
                <%=r.getTextInput("l_jid_verh_how")%><br>
                <%=r.getCheckbox("l_jost")%>
                <%=r.getTextInput("l_jid_sredn_how")%><br>
                <%=r.getCheckbox("l_jonp")%>
                <%=r.getTextInput("l_jid_niz_how")%><br>
                <%=r.getCheckbox("l_jop")%>
                <%=r.getTextInput("l_jid_paralel_how")%>
            </div>
        </td>
    </tr>
    <tr> 
        <td colspan="4" class="simple_str">Конкременты 
            <%=r.getSelect("l_konkrim")%>
        </td>
    </tr>
    <tr> 
        <td colspan="4" class="simple_str"> 
            <%=r.getChangeHidden("l_konkrim", "6", "875")%>
                <%=r.getCheckbox("l_vgch")%>
                <%=r.getSizeInput("l_verh_how")%>мм<br>
                <%=r.getCheckbox("l_sgch")%>
                <%=r.getSizeInput("l_sred_how")%>мм<br>
                <%=r.getCheckbox("l_ngch")%>
                <%=r.getSizeInput("l_niz_how")%>мм<br>
                <%=r.getCheckbox("l_pl")%>
                <%=r.getSizeInput("l_proekcii_how")%>мм
            </div>
        </td>
    </tr>
    <tr>
        <td colspan="4" class="simple_str">
            <font class="underline_str">левый надпочечник </font> 
            <%=r.getSelect("l_nadpoch")%>
            <%=r.getSizeInput("l_nadpoch_how")%>мм
            <%=r.getTextInput("l_nadpochechnik_how")%>
        </td>
    </tr>
    <tr> 
        <td colspan="3" class="simple_str"><b>Ангиоархитектоника</b>
            <%=r.getSelect("l_angi")%>
        </td>
        <td colspan="1" class="simple_str"> 
            <%=r.getChangeHidden("l_angi", "8", "6076")%>
                Сосудистый рисунок:<%=r.getSelect("l_obogashen")%>
            </div>
        </td>
    </tr>
    <tr>
        <td colspan="4">
            <b>Ствол почечной артерии</b>
        </td>
    </tr>
    <tr>
        <td colspan="3">
            Тип кровотока
        </td>
        <td colspan="1">
            <%=r.getSelect("l_stvol_krovotok")%>
        </td>
    </tr>
    <tr>
        <td colspan="3">
            Пиковая систолическая скорость кровотока
        </td>
        <td colspan="1">
            <%=r.getSizeInput("l_stvol_sist_how")%>см/c (норма 73.6 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 26.4 см/с)
        </td>
    </tr>
    <tr>
        <td colspan="3">
            Конечная диастолическая скорость кровотока
        </td>
        <td colspan="1">
            <%=r.getSizeInput("l_stvol_diastol_how")%>см/c (норма 37.2 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 11.7 см/с)
        </td>
    </tr>
    <tr>
        <td colspan="3">
            Индекс резистентности
        </td>
        <td colspan="1">
            <%=r.getSizeInput("l_stvol_rezis_how")%> (норма 0.62 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 0.05)
        </td>
    </tr>
    <tr>
        <td colspan="4">
            <b>Сегментарные артерии</b>
        </td>
    </tr>
    <tr>
        <td colspan="3">
            Тип кровотока
        </td>
        <td colspan="1">
            <%=r.getSelect("l_arter_krovotok")%>
        </td>
    </tr>
    <tr>
        <td colspan="3">
            Пиковая систолическая скорость кровотока
        </td>
        <td colspan="1">
            <%=r.getSizeInput("l_arter_sist_how")%>см/c (норма 47 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 6 см/с)
        </td>
    </tr>
    <tr>
        <td colspan="3">
            Конечная диастолическая скорость кровотока
        </td>
        <td colspan="1">
            <%=r.getSizeInput("l_arter_diastol_how")%>см/c (норма 20 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 3 см/с)
        </td>
    </tr>
    <tr>
        <td colspan="3">
            Индекс резистентности
        </td>
        <td colspan="1">
            <%=r.getSizeInput("l_arter_rezis_how")%> (норма 0.6 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 0.05)
        </td>
    </tr>
    <tr>
        <td colspan="4">
            <b>Междолевые артерии</b>
        </td>
    </tr>
    <tr>
        <td colspan="3">
            Тип кровотока
        </td>
        <td colspan="1">
            <%=r.getSelect("l_megdol_krovotok")%>
        </td>
    </tr>
    <tr>
        <td colspan="3">
            Пиковая систолическая скорость кровотока
        </td>
        <td colspan="1">
            <%=r.getSizeInput("l_megdol_sist_how")%>см/c (норма 34 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 4 см/с)
        </td>
    </tr>
    <tr>
        <td colspan="3">
            Конечная диастолическая скорость кровотока
        </td>
        <td colspan="1">
            <%=r.getSizeInput("l_megdol_diastol_how")%>см/c (норма 14 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 2 см/с)
        </td>
    </tr>
    <tr>
        <td colspan="3">
            Индекс резистентности
        </td>
        <td colspan="1">
            <%=r.getSizeInput("l_megdol_rezis_how")%> (норма 0.59 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 0.04)
        </td>
    </tr>
    <tr>
        <td colspan="4">
            <b>Дуговые артерии</b>
        </td>
    </tr>
    <tr>
        <td colspan="3">
            Тип кровотока
        </td>
        <td colspan="1">
            <%=r.getSelect("l_dugov_krovotok")%>
        </td>
    </tr>
    <tr>
        <td colspan="3">
            Пиковая систолическая скорость кровотока
        </td>
        <td colspan="1">
            <%=r.getSizeInput("l_dugov_sist_how")%>см/c (норма 25 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 4 см/с)
        </td>
    </tr>
    <tr>
        <td colspan="3">
            Конечная диастолическая скорость кровотока
        </td>
        <td colspan="1">
            <%=r.getSizeInput("l_dugov_diastol_how")%>см/c (норма 11 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 2 см/с)
        </td>
    </tr>
    <tr>
        <td colspan="3">
            Индекс резистентности
        </td>
        <td colspan="1">
            <%=r.getSizeInput("l_dugov_rezis_how")%> (норма 0.59 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 0.02)
        </td>
    </tr>
    <tr>
        <td colspan="4">
            Устья почечной артерии
            <%=r.getSelect("l_ustj")%>
        </td>
    </tr>
    <tr>
        <td colspan="4">
            <%=r.getChangeHidden("l_ustj", "12", "6088")%>
                <%=r.getSelect("l_osmotr")%>
                <%=r.getChangeHidden("l_osmotr", "13", "6092")%>
                    Пиковая систолическая скорость кровотока
                    <%=r.getSizeInput("l_ustj_sist_how")%> см/с<br>
                    Конечная диастолическая скорость кровотока
                    <%=r.getSizeInput("l_ustj_diastol_how")%> см/с<br>
                    Рено - артальное соотношение
                    <%=r.getSizeInput("l_reno_how")%> (норма < 3.5)
                </div>
            </div>
        </td>
    </tr>
</table>
</div><br>
<SCRIPT LANGUAGE="JavaScript">
    changeHidden61();
    document.protocol.l_pochka.onchange  = changeHidden61
    function changeHidden61()
    {
        if(document.protocol.l_pochka.value == "1875" || document.protocol.l_pochka.value == "6603"){
            display61.style.display = "none";
        }else{
            display61.style.display = "";
        }
    }
</SCRIPT>

<%@include file="footer.jsp"%>
