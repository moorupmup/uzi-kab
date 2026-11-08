<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title">УЗИ коленных суставов</H3>
<font class="underline_str">Правый коленный сустав</font><br><br>

<table width="100%" border="1">
  <tr> 
    <td colspan="1" width="10%" class="simple_str">Форма сустава </td>
    <td colspan="4"> 
      <%=r.getSelect("r_sust")%></td></tr>
      <SCRIPT LANGUAGE="JavaScript">
            document.protocol.r_sust.focus();
      </script>
  <tr> 
    <td colspan="1" width="10%" class="simple_str">Выпот <%=r.getSelect("r_gde")%></td>
    <td colspan="4" class="simple_str">завороте <%=r.getSelect("r_zavorot")%> 
      <%=r.getSizeInput("r_zavorot_how")%>
    </td>
  </tr>
  <tr> 
    <td colspan="1" width="10%" class="simple_str">Капсула</td>
    <td colspan="4"><%=r.getSelect("r_kapsula")%> <%=r.getSelect("r_kak_kaps")%></td>
  </tr>
  <tr> 
    <td colspan="1" width="10%"><%=r.getSelect("r_nal")%></td>
    <td colspan="4">у места прикрепления к кости <%=r.getSelect("r_yzur")%></td>
  </tr>
  <tr> 
    <td colspan="1" width="10%" class="simple_str">Структура</td>
    <td colspan="4" class="simple_str"><%=r.getSelect("r_struct")%></td>
  </tr>
  <tr> 
    <td colspan="1" width="10%" class="simple_str">Суставные поверхности</td>
    <td colspan="4" class="simple_str"><%=r.getSelect("r_sus_pov")%></td>
  </tr>
  <tr> 
    <td colspan="1" width="10%" class="simple_str">Суставная щель</td>
    <td colspan="4"><%=r.getSelect("r_sust_shel")%></td>
  </tr>
  <tr> 
    <td colspan="5" class="simple_str">Гиалиновый хрящ медиального мыщелка <%=r.getTextInput("r_ghmm_how")%> <%=r.getSelect("r_hrjash")%></td>
  </tr>
  <tr> 
    <td colspan="1" width="10%" class="simple_str">Контур <%=r.getSelect("r_konth")%></td>
    <td colspan="4">узурации <%=r.getSelect("r_yzh")%></td>
  </tr>
  <tr> 
    <td colspan="5" class="simple_str">Синовиальная <%=r.getSelect("r_obol")%> до <%=r.getSizeInput("r_raz_ob_how")%> мм</td>
  </tr>
  <tr> 
    <td colspan="5" class="simple_str">Субхондральные и эпифизарные кисты <%=r.getSelect("r_sub_kist")%></td>
  </tr>
  <tr> 
    <td colspan="1" width="10%" class="simple_str">Мениски</td>
    <td colspan="4"><%=r.getSelect("r_menisk")%></td>
  </tr>
  <tr> 
    <td colspan="1" width="10%" class="simple_str">Связки <%=r.getSelect("r_svyazki")%></td>
    <td colspan="4"><%=r.getTextInput("r_svyazki_text")%></td>
  </tr>
  <tr> 
    <td colspan="1" width="10%" class="simple_str">Медиальный мениск </td>
    <td colspan="4"><%=r.getSelect("r_medial")%></td>
  </tr>
  <tr> 
    <td colspan="5" class="simple_str">Остеофиты в бедренной и б/берцовой кости <%=r.getSelect("r_osteof")%></td>
  </tr>
  <tr> 
    <td colspan="1" width="10%" class="simple_str">Интракапсулярной гематома </td>
    <td colspan="4"><%=r.getSelect("r_gemot")%></td>
  </tr>
  <tr> 
    <td colspan="2" width="20%" class="simple_str">Травматические повреждения менисков <%=r.getSelect("r_tramva")%></td>
    <td colspan="3" width="80%">в области <%=r.getSelect("r_oblrog")%> <%=r.getSelect("r_oblmenisk")%>
  </tr>
  <tr> 
    <td colspan="2" width="20%" class="simple_str">Внесуставные скопления синовиальной жидкости (киста Бейкера)</td>
    <td colspan="3" width="80%"><%=r.getSelect("r_nal_kist")%> <%=r.getSizeInput("r_nal_kist_how")%>мм</td>
  </tr>
</table><br>

<font class="underline_str">Левый коленный сустав</font><br><br>

<table width="100%" border="1">
  <tr> 
    <td colspan="1" width="10%" class="simple_str">Форма сустава </td>
    <td colspan="4"> 
      <%=r.getSelect("l_sust")%></td></tr>
  <tr> 
    <td colspan="1" width="10%" class="simple_str">Выпот <%=r.getSelect("l_gde")%></td>
    <td colspan="4" class="simple_str">завороте <%=r.getSelect("l_zavorot")%> 
      <%=r.getSizeInput("l_zavorot_how")%>
    </td>
  </tr>
  <tr> 
    <td colspan="1" width="10%" class="simple_str">Капсула</td>
    <td colspan="4"><%=r.getSelect("l_kapsula")%> <%=r.getSelect("l_kak_kaps")%></td>
  </tr>
  <tr> 
    <td colspan="1" width="10%"><%=r.getSelect("l_nal")%></td>
    <td colspan="4">у места прикрепления к кости <%=r.getSelect("l_yzur")%></td>
  </tr>
  <tr> 
    <td colspan="1" width="10%" class="simple_str">Структура</td>
    <td colspan="4" class="simple_str"><%=r.getSelect("l_struct")%></td>
  </tr>
  <tr> 
    <td colspan="1" width="10%" class="simple_str">Суставные поверхности</td>
    <td colspan="4" class="simple_str"><%=r.getSelect("l_sus_pov")%></td>
  </tr>
  <tr> 
    <td colspan="1" width="10%" class="simple_str">Суставная щель</td>
    <td colspan="4"><%=r.getSelect("l_sust_shel")%></td>
  </tr>
  <tr> 
    <td colspan="5" class="simple_str">Гиалиновый хрящ медиального мыщелка <%=r.getTextInput("l_ghmm_how")%> <%=r.getSelect("l_hrjash")%></td>
  </tr>
  <tr> 
    <td colspan="1" width="10%" class="simple_str">Контур <%=r.getSelect("l_konth")%></td>
    <td colspan="4">узурации <%=r.getSelect("l_yzh")%></td>
  </tr>
  <tr> 
    <td colspan="5" class="simple_str">Синовиальная <%=r.getSelect("l_obol")%> до <%=r.getSizeInput("l_raz_ob_how")%> мм</td>
  </tr>
  <tr> 
    <td colspan="5" class="simple_str">Субхондральные и эпифизарные кисты <%=r.getSelect("l_sub_kist")%></td>
  </tr>
  <tr> 
    <td colspan="1" width="10%" class="simple_str">Мениски</td>
    <td colspan="4"><%=r.getSelect("l_menisk")%></td>
  </tr>
  <tr> 
    <td colspan="1" width="10%" class="simple_str">Связки <%=r.getSelect("l_svyazki")%></td>
    <td colspan="4"><%=r.getTextInput("l_svyazki_text")%></td>
  </tr>
  <tr> 
    <td colspan="1" width="10%" class="simple_str">Медиальный мениск </td>
    <td colspan="4"><%=r.getSelect("l_medial")%></td>
  </tr>
  <tr> 
    <td colspan="5" class="simple_str">Остеофиты в бедренной и б/берцовой кости <%=r.getSelect("l_osteof")%></td>
  </tr>
  <tr> 
    <td colspan="1" width="10%" class="simple_str">Интракапсулярной гематома </td>
    <td colspan="4"><%=r.getSelect("l_gemot")%></td>
  </tr>
  <tr> 
    <td colspan="2" width="20%" class="simple_str">Травматические повреждения менисков <%=r.getSelect("l_tramva")%></td>
    <td colspan="3" width="80%">в области <%=r.getSelect("l_oblrog")%> <%=r.getSelect("l_oblmenisk")%>
  </tr>
  <tr> 
    <td colspan="2" width="20%" class="simple_str">Внесуставные скопления синовиальной жидкости (киста Бейкера)</td>
    <td colspan="3" width="80%"><%=r.getSelect("l_nal_kist")%> <%=r.getSizeInput("l_nal_kist_how")%>мм</td>
  </tr>
</table><br>

<%@include file="footer.jsp"%>
