<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title" align="center"><%=r.get("research")%></H3>
<table width="80%" border="1">
    <tr><td>Первый день последней менструации </td>
        <td><%=r.getTextInput("mens_text")%> </td>
        <SCRIPT LANGUAGE="JavaScript">
            document.protocol.mens_text.focus();
        </script>
    </tr>
    <tr><td>Срок беременности</td>
        <td><%=r.getTextInput("srok_ber")%> недель</td>
    </tr>
    <tr><td>Предполагаемая дата родов </td>
        <td><%=r.getTextInput("data_roda")%> </td>
    </tr>
    <tr><td>В полости матки визуализируется</td>
        <td><%=r.getSelect("plod")%> в <%=r.getSelect("plod_predl")%> предлежании</td>
    </tr>
    <tr><td>Положение плода </td>
        <td><%=r.getSelect("plod_poloj")%></td>
    </tr>
    <tr><td>Позиция </td>
        <td><%=r.getSelect("poza")%></td>
    </tr>
    <tr><td>Вид </td>
        <td><%=r.getSelect("vid")%></td>
    </tr>
    <tr><td colspan="2" align="center"><b>Фетометрия:</b></tr>
    <tr><td>Бипариетальный размер головки </td>
        <td><%=r.getSizeInput("razm_gol")%> мм</td>
    </tr>
    <tr><td>Окружность головы</td>
        <td><%=r.getSizeInput("okr_golov")%> мм</td>
    </tr>
    <tr><td>Лобно-затылочный размер</td>
        <td><%=r.getSizeInput("lob_zat")%> мм</td>
    </tr>
    <tr><td>Окружность живота</td>
        <td><%=r.getSizeInput("okr_jiv")%> мм</td>
    </tr>
    <tr><td>Длина бедренной кости</td>
        <td>левой <%=r.getSizeInput("bed_l")%> мм правой <%=r.getSizeInput("bed_r")%> мм</td>
    </tr>
    <tr><td>Длина костей голени</td>
        <td>левой <%=r.getSizeInput("golen_l")%> мм правой <%=r.getSizeInput("golen_r")%> мм</td>
    </tr>
    <tr><td>Длина плечевой кости</td>
        <td>левой <%=r.getSizeInput("plech_l")%> мм правой <%=r.getSizeInput("plech_r")%> мм</td>
    </tr>
    <tr><td>Длина костей предплечья</td>
        <td>левой <%=r.getSizeInput("predp_l")%> мм правой <%=r.getSizeInput("predp_r")%> мм</td>
    </tr>
    <tr><td>Размеры плода соответствуют </td>
        <td><%=r.getSizeInput("ned_ber")%> нед.</td>
    </tr>
    <tr><td colspan="2"> <%=r.getCheckbox("bad_srok")%></td></tr>
    <tr><td>Вес </td>
        <td><%=r.getSizeInput("ves")%> г</td>
    </tr>
</table>
<table width="80%" border="1">
    <tr><td colspan="2" align="center"><b>Анатомия плода:</b></tr>
    <tr><td>Боковые желудочки мозга </td>
        <td><%=r.getSelect("sel_mozg")%> <%=r.getSizeInput("mozg")%> мм</td>
    </tr>
    <tr><td>Мозжечок</td>
        <td><%=r.getSelect("sel_mozj")%> <%=r.getTextInput("mozj")%></td>
    </tr>
    <tr><td>Большая цистерна</td>
        <td><%=r.getSelect("sel_bolsh_c")%> <%=r.getTextInput("bolsh_c")%> мм</td>
    </tr>
    <tr><td>Лицевые структуры:</td>
        <td>профиль <%=r.getSelect("sel_prof")%> <%=r.getTextInput("prof")%><br>
            носогубный треугольник <%=r.getSelect("sel_nos")%> <%=r.getTextInput("nos")%><br>
            глазницы <%=r.getSelect("sel_glaz")%> <%=r.getTextInput("glaz")%></td>
    </tr>
    <tr><td>Позвоночник</td>
        <td><%=r.getSelect("sel_pozv")%> <%=r.getTextInput("pozv")%></td>
    </tr>
    <tr><td>Легкие</td>
        <td><%=r.getSelect("sel_legkie")%> <%=r.getTextInput("legkie")%></td>
    </tr>
    <tr><td>Четырехкамерный срез сердца</td>
        <td><%=r.getSelect("sel_serdce")%> <%=r.getTextInput("serdce")%></td>
    </tr>
    <tr><td>Желудок</td>
        <td><%=r.getSelect("sel_jelud")%> <%=r.getTextInput("jelud")%></td>
    </tr>
    <tr><td>Кишечник</td>
        <td><%=r.getSelect("sel_kishki")%> <%=r.getTextInput("kishki")%></td>
    </tr>
    <tr><td>Почки </td>
        <td><%=r.getSelect("sel_pochki")%> <%=r.getTextInput("pochki")%></td>
    </tr>
    <tr><td>Мочевой пузырь </td>
        <td><%=r.getSelect("sel_mocha")%>  <%=r.getTextInput("mocha")%></td>
    </tr>
</table>
<table width="80%" border="1">
    <tr><td colspan="2" align="center"><b>Плацента, околоплодные воды, пуповина:</b></tr>
    <tr><td>Преимущественная локализация плаценты </td>
        <td><%=r.getSelect("plac1")%> <%=r.getSelect("plac2")%></td>
    </tr>
    <tr><td>Толщина плаценты</td>
        <td><%=r.getSelect("tolsh_p")%> <%=r.getTextInput("tolsh_text")%> мм</td>
    </tr>
    <tr><td>Степень зрелости плаценты</td>
        <td><%=r.getTextInput("zrelost")%></td>
    </tr>
    <tr><td>Количество околоплодных вод </td>
        <td><%=r.getSelect("vodi")%></td>
    </tr>
    <tr><td>индекс амниотической жидкости</td>
        <td><%=r.getTextInput("index")%> мм</td>
    </tr>
    <tr><td>Пуповина имеет</td>
        <td><%=r.getTextInput("sosud")%> сосуда</td>
    </tr>
    <tr><td>УЗДГ плода:плодово-плацентарный кровоток</td>
        <td>С/Д <%=r.getSizeInput("pp_sd")%>  ИР <%=r.getSizeInput("pp_ir")%> <%=r.getSelect("pp_norma")%></td>
    </tr>
    <tr><td>маточно-плацентарный кровоток</td>
        <td>С/Д <%=r.getSizeInput("mp_sd")%>  ИР <%=r.getSizeInput("mp_ir")%> <%=r.getSelect("mp_norma")%></td>
    </tr>
    <tr><td colspan="2"><b>Врожденные пороки развития плода:</b> <%=r.getSelect("poroki")%><br>
        <%=r.getTextAreaInput("poroki_text",3,80)%></td></tr>
    <tr><td colspan="2"><b>Особенности строения шейки и стенок матки</b> <%=r.getSelect("osob_stroi")%><br>
        <%=r.getTextAreaInput("stenki_text",3,80)%></td></tr>    
    <tr><td colspan="2"><b>Область придатков</b> <%=r.getSelect("obl_pr")%><br>
        <%=r.getTextAreaInput("pridatki",3,80)%></td></tr>    
    <tr><td colspan="2"><b>Визуализация</b> <%=r.getSelect("vizual")%><br>
        <%=r.getTextAreaInput("viz_text",3,80)%></td></tr>    
    <tr><td colspan="2">Почки беременной <%=r.getSelect("pochki_ber")%><br>
        чашечки расширенные до <%=r.getSizeInput("chash")%> мм <%=r.getSelect("chash_gde")%>
        лоханка расширенна до <%=r.getSizeInput("loh")%> мм <%=r.getSelect("loh_gde")%><br>
        <%=r.getTextAreaInput("pochki_text",3,80)%></td>
    </tr>
    <tr><td colspan="2">Рекомендации<br>
        <%=r.getTextAreaInput("rek_text",4,80)%></td>
    </tr>    
    <tr><td>Ультразвуковой контроль </td>
        <td> в <%=r.getSizeInput("kontrol_text")%> нед </td>
    </tr>    
</table>
<%@include file="footer.jsp"%>
