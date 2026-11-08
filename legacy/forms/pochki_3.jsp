<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>

<H3 class="p_title" align="center">Узи почек</H3>
<br>
<span class="bold_str"><b>ПРАВАЯ ПОЧКА</b></span> 
<%=r.getSelect("r_pochka")%>
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
            <%=r.getChangeHidden("r_polost", "1", "6170")%>
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
            <%=r.getChangeHidden("r_stru", "2", "6175")%>
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
            <%=r.getChangeHidden("r_konkrim", "3", "6185")%>
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
    <tr><td colspan="4"><%=r.getCheckbox("r_krovis")%></td></tr>
</table>

<div id="display100" style="display:none;position:relative; left:0;">

<table width="90%" border="1">
    <tr> 
        <td colspan="3" class="simple_str"><b>Ангиоархитектоника</b>
            <%=r.getSelect("r_angi")%>
        </td>
        <td colspan="1" class="simple_str"> 
            <%=r.getChangeHidden("r_angi", "7", "6197")%>
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
            <%=r.getChangeHidden("r_ustj", "9", "6209")%>
                <%=r.getSelect("r_osmotr")%>
                <%=r.getChangeHidden("r_osmotr", "11", "6213")%>
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
</div>

<SCRIPT LANGUAGE="JavaScript">
    changeHidden100();
    document.protocol.r_krovis.onclick  = changeHidden100
    function changeHidden100()
    {
        if(document.protocol.r_krovis.checked == true){
            display100.style.display = "";
        }else{
            display100.style.display = "none";
        }
    }
</SCRIPT>



<span class="bold_str"><b>ЛЕВАЯ ПОЧКА</b></span> 
<%=r.getSelect("l_pochka")%>
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
            <%=r.getChangeHidden("l_polost", "4", "6170")%>
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
            <%=r.getChangeHidden("l_stru", "5", "6175")%>
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
            <%=r.getChangeHidden("l_konkrim", "6", "6185")%>
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
    <tr><td colspan="4"><%=r.getCheckbox("l_krovis")%></td></tr>
</table>

<div id="display101" style="display:none;position:relative; left:0;">

<table width="90%" border="1">
    <tr> 
        <td colspan="3" class="simple_str"><b>Ангиоархитектоника</b>
            <%=r.getSelect("l_angi")%>
        </td>
        <td colspan="1" class="simple_str"> 
            <%=r.getChangeHidden("l_angi", "8", "6197")%>
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
            <%=r.getChangeHidden("l_ustj", "12", "6209")%>
                <%=r.getSelect("l_osmotr")%>
                <%=r.getChangeHidden("l_osmotr", "13", "6213")%>
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
</div>

<SCRIPT LANGUAGE="JavaScript">
    changeHidden101();
    document.protocol.l_krovis.onclick  = changeHidden101
    function changeHidden101()
    {
        if(document.protocol.l_krovis.checked == true){
            display101.style.display = "";
        }else{
            display101.style.display = "none";
        }
    }
</SCRIPT>

<%@include file="footer.jsp"%>
