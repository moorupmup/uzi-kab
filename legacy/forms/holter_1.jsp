                                 
<%@page import = "java.util.Date" import="my_pack.beans.*" import="my_pack.tools.* java.text.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title" align="center"><%=r.get("research")%></H3>
 <H3 class="p_title">Суточное мониторирование ЭКГ по Холтеру
</H3>



<table width="90%" border="1">
    <tr>
        <td class="simple_str" width="35%">Время мониторирования</td>
        <td><%=r.getSizeInput("mon_chas")%> ч. <%=r.getSizeInput("mon_min")%> мин.</td>
    </tr>
            <SCRIPT LANGUAGE="JavaScript">
                document.protocol.mon_chas.focus();
            </script>
    <tr>
        <td class="simple_str" width="35%">Проанализированно</td>
        <td><%=r.getSizeInput("anal_kompl")%> комплексов</td>
    </tr>
    <tr>
        <td class="simple_str" width="35%">Максимальная чсс</td>
        <td><%=r.getSizeInput("chss_max")%> уд/мин</td>
    </tr>
    <tr>
        <td class="simple_str" width="35%">Минимальная чсс</td>
        <td><%=r.getSizeInput("chss_min")%> уд/мин</td>
    </tr>
    <tr>
        <td class="simple_str" width="35%">Средняя чсс</td>
        <td><%=r.getSizeInput("chss_sr")%> уд/мин</td>
    </tr>
    <tr>
        <td class="simple_str" width="35%">Смещение интервала ST</td>
        <td>происходило <%=r.getSizeInput("smesh_st")%> раз
            <BR>общей продолжительностью <%=r.getSizeInput("smesh_st_prodol")%> минут</td>
    </tr>
    <tr>
    <td colspan="3" align="center">Желудочковая эктопическая активность</td>
    </tr>
    <tr>
        <td class="simple_str" width="35%">зарегистрировано:</td>
    </tr>
    <tr>
        <td colspan="3"><%=r.getSizeInput("gel_ekstra_odin")%> желудочковых одиночных экстрасистол</td>
    </tr>
    <tr>
        <td colspan="3"><%=r.getSizeInput("gel_ekstra_par")%> желудочковых парных экстрасистол</td>
    </tr>
    <tr>
        <td colspan="3"><%=r.getSizeInput("epizod_gel_ritm_kol")%> эпизодов желудчкового ритма</td>
    </tr>
    <tr>
        <td colspan="3"><%=r.getSizeInput("epizod_tah_kol")%> эпизодов пароксизмальной желудочковой тахикардии</td>
    </tr>
    <tr>
        <td colspan="3"><%=r.getSizeInput("ritmir_big")%> ритмированных по типу бигемении экстрасистол</td>
    </tr>
    <tr>
        <td colspan="3"><%=r.getSizeInput("ritmir_trig")%> ритмированных по типу тригемении экстрасистол</td>
    </tr>
    <tr>
    <td colspan="3" align="center">Суправентрикулярная эктопическая активность</td>
    </tr>
    </tr>
    <tr>
        <td class="simple_str" width="35%">зарегистрировано:</td>
    </tr>
    <tr>
        <td colspan="3"><%=r.getSizeInput("ekstra_supra_kol")%> суправентрикулярных экстрасистол</td>
    </tr>
    <tr>
        <td colspan="3"><%=r.getSizeInput("ekstra_odin_kol")%> одиночных</td>
    </tr>
    <tr>
        <td colspan="3"><%=r.getSizeInput("ekstra_par_kol")%> парных</td>
    </tr>
    <tr>
        <td colspan="3"><%=r.getSizeInput("par_supra_ekstra_kol")%> пароксизмов суправентрикулярной тахикардии, продолжительностью от <%=r.getSizeInput("prod_par_1")%> секунд до <%=r.getSizeInput("prod_par_2")%> секунд</td>
    </tr>
    <tr>
        <td colspan="3">Регистрируется постоянная форма мерцания предсердий <BR> со средней чсс <%=r.getSizeInput("merc_pred_kol")%> уд/мин</td>
    </tr>
    <tr>
        <td colspan="3">Зарегистрированно <%=r.getSizeInput("pauzi_kol")%> пауз длительностью <%=r.getSizeInput("pauzi_dlit")%> м/сек., связанных с <%=r.getTextInput("pauzi_text_1")%> блокадой <%=r.getTextInput("pauzi_text_2")%></td>
    </tr>
    <tr>
        <td colspan="3">За сутки зарегистрировано <%=r.getSizeInput("ish_depr_kol_1")%> эпизодов косовосходящей депрессии ST общей продолжительностью <%=r.getTextInput("ish_dlit_1")%></td>
    </tr>
    <tr>
        <td colspan="3">За сутки зарегистрировано <%=r.getSizeInput("ish_depr_kol_2")%> эпизодов косонисходящей депрессии ST общей продолжительностью <%=r.getTextInput("ish_dlit_2")%></td>
    </tr>
    <tr>
        <td colspan="3"><%=r.getCheckbox("inter_st_check")%> <%=r.getSelect("inter_st")%> из-за полной блокады <%=r.getSelect("nogka_gisa")%> ножки п.Гиса</td>
    </tr>
</table>
<%@include file="footer.jsp"%>
