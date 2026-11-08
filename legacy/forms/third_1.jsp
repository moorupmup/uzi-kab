<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title"> Протокол третьего триместра беременности</H3>
<table width="90%" border="1">
    <tr> 
        <td class="simple_str" width="35%">1-й день последней менструации
        </td>
        <td colspan="2">
            <%=r.getSizeInput("last_mens")%>
            <SCRIPT LANGUAGE="JavaScript">
                document.protocol.last_mens.focus();
                document.protocol.last_mens.onkeyup = point
                function point(){
                    checkDate("document.protocol.last_mens");
                }
            </script>
        </td>
    </tr>
    <tr> 
        <td class="simple_str" width="35%">срок беременности
        </td>
        <td colspan="2"> 
            <%=r.getSizeInput("srok_ber")%>
            <font class="simple_str">нед.</font>
        </td>
    </tr>
    <tr> 
        <td class="simple_str" width="35%">В матке определяется
        </td>
        <td colspan="2">
            <%=r.getSelect("plod")%>
        </td>
    </tr>
    <tr> 
        <td colspan="3">
            <%=r.getSelect("predlej")%>
            <%=r.getSelect("poza")%>
        </td>
    </tr>
</table>

<font class="underline_str"><b>Фетометрия (первого плода)</b></font><br>

<table border="1">
    <tr> 
        <td class="simple_str">Бипариетальный размер головки
        </td>
        <td colspan="1"> 
            <%=r.getSizeInput("biparietalnii1")%>
            <font class="ed_izm">мм</font>
        </td>
        <td colspan="1" class="simple_str">Окружность головы
            <%=r.getSizeInput("okrujnost1")%>
            <font class="ed_izm">мм</font>
        </td>
    </tr>
    <tr> 
        <td class="simple_str">Лобно-затылочный размер
        </td>
        <td colspan="1">
            <%=r.getSizeInput("lobnii_r1")%>
            <font class="ed_izm">мм</font>
        </td>
        <td colspan="1" class="simple_str">Окружность живота
            <%=r.getSizeInput("okrujnost_jivot1")%>
            <font class="ed_izm">мм</font>
        </td>
    </tr>
    <tr> 
        <td class="simple_str">Длина бедренной кости
        </td>
        <td width="20%" class="simple_str"> левой
            <%=r.getSizeInput("bedro_l1")%>
            <font class="ed_izm">мм</font> 
        </td>
        <td class="simple_str">правой 
            <%=r.getSizeInput("bedro_r1")%>
            <font class="ed_izm">мм</font>
        </td>
    </tr>
    <tr> 
        <td class="simple_str">Длина костей голени
        </td>
        <td class="simple_str"> левой 
            <%=r.getSizeInput("golen_l1")%>
            <font class="ed_izm">мм</font>
        </td>
        <td class="simple_str">правой 
            <%=r.getSizeInput("golen_r1")%>
            <font class="ed_izm">мм</font>
        </td>
    </tr>
    <tr> 
        <td class="simple_str">Длина плечевой кости
        </td>
        <td class="simple_str"> левой
            <%=r.getSizeInput("plecho_l1")%>
            <font class="ed_izm">мм</font>
        </td>
        <td class="simple_str">правой
            <%=r.getSizeInput("plecho_r1")%>
            <font class="ed_izm">мм</font>
        </td>
    </tr>
    <tr> 
        <td class="simple_str">Длина костей предплечья
        </td>
        <td class="simple_str"> левой
            <%=r.getSizeInput("predplechie_l1")%>
            <font class="ed_izm">мм</font>
        </td>
        <td class="simple_str">правой
            <%=r.getSizeInput("predplechie_r1")%>
            <font class="ed_izm">мм</font>
        </td>
    </tr>
    <tr> 
        <td class="simple_str">Масса
        </td>
        <td colspan="2">
            <%=r.getSizeInput("massa1")%>
            <font class="ed_izm">гр</font>
        </td>
    </tr>
    <tr> 
        <td class="simple_str">Размеры плода соответствуют
        </td>
        <td>
            <%=r.getSizeInput("razmer_ploda1")%>
            <font class="simple_str">нед</font> 
        </td>
        <td>
            <%=r.getCheckbox("srokneopred1")%>
        </td>
  </tr>
</table>
<%=r.getChangeHidden("plod", "3", "6650")%>
    <font class="underline_str"><b>Фетометрия второго плода</b></font><br>

    <table border="1">
        <tr> 
            <td class="simple_str">Бипариетальный размер головки
            </td>
            <td colspan="1"> 
                <%=r.getSizeInput("biparietalnii2")%>
                <font class="ed_izm">мм</font>
            </td>
            <td colspan="1" class="simple_str">Окружность головы
                <%=r.getSizeInput("okrujnost2")%>
                <font class="ed_izm">мм</font>
            </td>
        </tr>
        <tr> 
            <td class="simple_str">Лобно-затылочный размер
            </td>
            <td colspan="1">
                <%=r.getSizeInput("lobnii_r2")%>
                <font class="ed_izm">мм</font>
            </td>
            <td colspan="1" class="simple_str">Окружность живота
                <%=r.getSizeInput("okrujnost_jivot2")%>
                <font class="ed_izm">мм</font>
            </td>
        </tr>
        <tr> 
            <td class="simple_str">Длина бедренной кости
            </td>
            <td width="20%" class="simple_str"> левой
                <%=r.getSizeInput("bedro_l2")%>
                <font class="ed_izm">мм</font> 
            </td>
            <td class="simple_str">правой 
                <%=r.getSizeInput("bedro_r2")%>
                <font class="ed_izm">мм</font>
            </td>
        </tr>
        <tr> 
            <td class="simple_str">Длина костей голени
            </td>
            <td class="simple_str"> левой 
                <%=r.getSizeInput("golen_l2")%>
                <font class="ed_izm">мм</font>
            </td>
            <td class="simple_str">правой 
                <%=r.getSizeInput("golen_r2")%>
                <font class="ed_izm">мм</font>
            </td>
        </tr>
        <tr> 
            <td class="simple_str">Длина плечевой кости
            </td>
            <td class="simple_str"> левой
                <%=r.getSizeInput("plecho_l2")%>
                <font class="ed_izm">мм</font>
            </td>
            <td class="simple_str">правой
                <%=r.getSizeInput("plecho_r2")%>
                <font class="ed_izm">мм</font>
            </td>
        </tr>
        <tr> 
            <td class="simple_str">Длина костей предплечья
            </td>
            <td class="simple_str"> левой
                <%=r.getSizeInput("predplechie_l2")%>
                <font class="ed_izm">мм</font>
            </td>
            <td class="simple_str">правой
                <%=r.getSizeInput("predplechie_r2")%>
                <font class="ed_izm">мм</font>
            </td>
        </tr>
        <tr> 
            <td class="simple_str">Масса
            </td>
            <td colspan="2">
                <%=r.getSizeInput("massa2")%>
                <font class="ed_izm">гр</font>
            </td>
        </tr>
        <tr> 
            <td class="simple_str">Размеры плода соответствуют
            </td>
            <td>
                <%=r.getSizeInput("razmer_ploda2")%>
                <font class="simple_str">нед</font> 
            </td>
            <td>
                <%=r.getCheckbox("srokneopred2")%>
            </td>
      </tr>
    </table>
</div>
<font class="underline_str"><b>Анатомия плода</b></font><br>

<table width="90%" border="1">
    <tr> 
        <td colspan="2" class="simple_str">Боковые желудочки мозга
        </td>
        <td width="17%"> 
            <%=r.getSelect("mozg")%>
        </td>
        <td width="54%">
            <%=r.getSizeInput("mozg_how")%>
            <span class="ed_izm">мм</span>
            <%=r.getTextInput("mozg_text")%>
        </td>
    </tr>
    <tr> 
        <td colspan="2" class="simple_str">Мозжечок
        </td>
        <td> 
            <%=r.getSelect("mozjechok")%>
        </td>
        <td>
            <%=r.getTextInput("mozjechok_how")%>
        </td>
    </tr>
    <tr> 
        <td colspan="2" class="simple_str">Большая цистерна
        </td>
        <td> 
            <%=r.getSelect("cisterna")%>
        </td>
        <td>
            <%=r.getSizeInput("cisterna_how")%>
            <span class="ed_izm">мм</span>
        </td>
    </tr>
    <tr> 
        <td rowspan="3" width="11%" class="simple_str">Лицевые структуры
        </td>
        <td width="18%" class="simple_str">профиль
        </td>
        <td> 
            <%=r.getSelect("profil")%>
        </td>
        <td>
            <%=r.getTextInput("profil_how")%>
        </td>
    </tr>
    <tr> 
        <td width="18%" class="simple_str">носогубный треугольник
        </td>
        <td> 
            <%=r.getSelect("nos")%>
        </td>
        <td>
            <%=r.getTextInput("nos_how")%>
        </td>
    </tr>
    <tr> 
        <td width="18%" class="simple_str">глазницы
        </td>
        <td> 
            <%=r.getSelect("glaznica")%>
        </td>
        <td>
            <%=r.getSizeInput("glaznica_how")%>мм
            <%=r.getTextInput("glaznica_text")%>
        </td>
    </tr>
    <tr> 
        <td colspan="2" class="simple_str">Позвоночник
        </td>
        <td> 
            <%=r.getSelect("pozvonochnik")%>
        </td>
        <td> 
            <%=r.getSelect("defectpoz")%><br>
            <%=r.getTextInput("pozv_how")%>
        </td>
    </tr>
    <tr> 
        <td colspan="2" class="simple_str">Легкие
        </td>
        <td> 
            <%=r.getSelect("legkie")%>
        </td>
        <td>
            <%=r.getSelect("stadlegkie")%><br>
            <%=r.getTextInput("legkie_how")%>
        </td>
    </tr>
    <tr> 
        <td colspan="4" class="simple_str">Эхокардиография
        </td>
    </tr>
    <tr> 
        <td colspan="4" class="simple_str"> 
            <%=r.getSelect("ehokard")%><br>
            <%=r.getTextInput("ehokardio_how")%>
        </td>
    </tr>
    <tr> 
        <td colspan="2" class="simple_str">Желудок
        </td>
        <td colspan="2"> 
            <%=r.getSelect("jeludok")%>
            <%=r.getTextInput("jeludok_how")%>
        </td>
    </tr>
    <tr> 
        <td colspan="2" class="simple_str">Мочевой пузырь
        </td>
        <td colspan="2"> 
            <%=r.getSelect("mocha")%>
            <%=r.getTextInput("mocha_how")%>
        </td>
    </tr>
    <tr> 
        <td width="11%" class="simple_str">Кишечник
        </td>
        <td colspan="3"> 
            <%=r.getSelect("kishki")%>
            <%=r.getSelect("stadkishki")%>
            <%=r.getTextInput("kishki_how")%>
        </td>
    </tr>
    <tr> 
        <td width="11%" class="simple_str">Почки
        </td>
        <td colspan="3"> 
            <%=r.getSelect("pochki")%>
            <br>
            <%=r.getCheckbox("lohankar")%>
            <%=r.getSizeInput("lohanka_r")%>мм<br>
            <%=r.getCheckbox("lohankal")%>
            <%=r.getSizeInput("lohanka_l")%>мм<br>
            <%=r.getTextInput("lohanka_how")%>
        </td>
    </tr>
    <tr> 
        <td colspan="2" class="simple_str">Место прикрепления пуповины к передней брюшной стенке
        </td>
        <td class="simple_str" colspan="2"> 
            <%=r.getSelect("mesto")%>
            <%=r.getSizeInput("mesto_how")%>мм
        </td>
    </tr>
</table>

<font class="underline_str"><b>Плацента (первого плода)</b></font><%=r.getSelect("kolplacent")%><br>

<table width="90%" border="1">
    <tr> 
        <td width="24%" class="simple_str">Преимущественная локализация плаценты
        </td>
        <td width="76%"> 
            <%=r.getSelect("first_placenta")%>с переходом на<%=r.getSelect("first_perehod")%>
            <%=r.getTextInput("first_placenta_how")%>
        </td>
    </tr>
    <tr> 
        <td class="simple_str" width="24%">Степень зрелости
        </td>
        <td width="76%"> 
            <%=r.getSelect("first_zrelost")%>
        </td>
    </tr>
    <tr> 
        <td class="simple_str" width="24%">Толщина плаценты
        </td>
        <td width="76%"> 
            <%=r.getSelect("first_tolshina")%>
            <span class="simple_str">до</span> 
            <%=r.getSizeInput("first_tolshina_how")%>
            <font class="ed_izm">мм</font>
            <%=r.getTextInput("first_tolshina_text")%>
        </td>
    </tr>
</table>
<%=r.getChangeHidden("kolplacent", "10", "6807")%>
<font class="underline_str"><b>Плацента второго плода</b></font><br>
<table width="90%" border="1">
    <tr> 
        <td width="24%" class="simple_str">Преимущественная локализация плаценты
        </td>
        <td width="76%"> 
            <%=r.getSelect("second_placenta")%>с переходом на<%=r.getSelect("second_perehod")%>
            <%=r.getTextInput("second_placenta_how")%>
        </td>
    </tr>
    <tr> 
        <td class="simple_str" width="24%">Степень зрелости
        </td>
        <td width="76%"> 
            <%=r.getSelect("second_zrelost")%>
        </td>
    </tr>
    <tr> 
        <td class="simple_str" width="24%">Толщина плаценты
        </td>
        <td width="76%"> 
            <%=r.getSelect("second_tolshina")%>
            <span class="simple_str">до</span> 
            <%=r.getSizeInput("second_tolshina_how")%>
            <font class="ed_izm">мм</font>
            <%=r.getTextInput("second_tolshina_text")%>
        </td>
    </tr>
</table>
</div>
<font class="underline_str"><b>Околоплодные воды, пуповина</b></font><br>
<table width="90%" border="1">
    <tr> 
        <td class="simple_str" width="24%">Количество околоплодных вод
        </td>
        <td width="76%"> 
            <%=r.getSelect("vodi")%><%=r.getTextInput("vodi_text")%>
        </td>
    </tr>
    <tr> 
        <td class="simple_str" width="24%">Индекс амниотической жидкости
        </td>
        <td width="76%">
            <%=r.getSizeInput("index_jidkosti")%>
            <font class="ed_izm">мм</font>
        </td>
    </tr>
    <tr> 
        <td class="simple_str" width="24%">Пуповина имеет
        </td>
        <td width="76%"> 
            <%=r.getSelect("pupovina")%>
            <font class="simple_str">сосуда</font>
            <%=r.getSelect("obvitie")%>
        </td>
    </tr>
</table>

<table width="90%">
    <tr>
        <td>&nbsp;</td>
    </tr>
</table>

<table width="90%" border="1">
    <tr> 
        <td class="bold_str" width="19%">УЗДГ плода
        </td>
        <td class="simple_str" width="35%">плодово-плацентарный кровоток
        </td>
        <td width="46%"> 
            <%=r.getSelect("yzgd")%>
            <%=r.getSizeInput("yzgd_how")%>
        </td>
    </tr>
</table>

<table width="90%">
    <tr>
        <td>&nbsp;</td>
    </tr>
</table>

<table width="90%" border="1">
    <tr> 
        <td width="41%" class="bold_str">Врожденные пороки развития плода при исследовании
        </td>
        <td width="59%" class="simple_str">
            <%=r.getSelect("poroki")%>
        </td>
    </tr>
</table>

<table width="90%">
    <tr>
        <td>&nbsp;</td>
    </tr>
</table>

<table width="90%" border="1">
    <tr> 
        <td colspan="3" class="bold_str" height="14"><b>Особенности строения шейки и стенок матки</b><%=r.getSelect("osobmatki")%> 
        </td>
    </tr>
    <tr> 
        <td colspan="3"> 
            <%=r.getChangeHidden("osobmatki", "1", "6803")%>
                <%=r.getCheckbox("myppsr")%> <%=r.getSizeInput("yzel_pered_how")%>мм<br>
                <%=r.getCheckbox("mypzadsr")%> <%=r.getSizeInput("yzel_zad_how")%>мм<br>
                <%=r.getCheckbox("mypprr")%> <%=r.getSizeInput("yzel_rebro_r_how")%>мм<br>
                <%=r.getCheckbox("myplrr")%> <%=r.getSizeInput("yzel_rebro_l_how")%>мм<br>
                <%=r.getCheckbox("myvdr")%>
                <%=r.getSizeInput("yzel_dno_how")%>мм
            </div>
        </td>
    </tr>
    <tr> 
        <td width="22%" class="bold_str">Область придатков
        </td>
        <td colspan="2"> 
            <%=r.getSelect("pridatki")%>
            <%=r.getSizeInput("pridatki_how")%>мм
        </td>
    </tr>
    <tr> 
        <td width="22%" class="bold_str">Визуализация 
        </td>
        <td width="30%"> 
            <%=r.getSelect("vizualizac")%>
        </td>
        <td width="48%">
            <%=r.getTextInput("vizualizac_how")%>
        </td>
    </tr>
    <tr> 
        <td width="22%" class="bold_str">Оценка анатомии плода
        </td>
        <td colspan="2"> 
            <%=r.getSelect("ocenka")%>
        </td>
    </tr>
  <tr> 
        <td width="22%" class="simple_str">Почки беременной
            <%=r.getSelect("pochki_berem")%> 
        </td>
        <td colspan="2"> 
            <%=r.getChangeHidden("pochki_berem", "2", "6799")%>
                <%=r.getCheckbox("chkalik")%> 
                <%=r.getSelect("kalik")%><%=r.getSizeInput("chkalik_how")%>мм
                <br>
                <%=r.getCheckbox("chpoliek")%> 
                <%=r.getSelect("poliek")%><%=r.getSizeInput("chpoliek_how")%>мм
                <br>
                <%=r.getCheckbox("chtransform")%> 
                <%=r.getSelect("transform")%>
           </div>
        </td>
    </tr>
</table>

<%@include file="footer.jsp"%>
