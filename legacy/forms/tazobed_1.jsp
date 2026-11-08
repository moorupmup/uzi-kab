<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title">Ультразвуковое исследование тазобедренных суставов</H3>
<font class="underline_str"><b>Правый тазобедренный сустав</b></font><br>

<table width="90%" border="1">
  <tr> 
    <td class="simple_str" width="35%">Форма головки бедренной кости </td>
    <td colspan="3">  
      <%=r.getSelect("r_head")%>
        <SCRIPT LANGUAGE="JavaScript">
            document.protocol.r_head.focus();
        </SCRIPT>
    </td>
  </tr>
  <tr>
    <td>Метэпифизарный индекс</td>
  <td colspan="3"><%=r.getSizeInput("r_index")%> при норме 1,1 мм.</td>
  </tr>
  <tr> 
    <td class="simple_str">Выпот в полости сустава</td>
    <td colspan="3"> 
      <%=r.getSelect("r_vipot")%>
    </td>
  </tr>
  <tr> 
    <td colspan="4" class="simple_str">Толщина синовиального пространства в точке перехода шейки бедра в головку
      <%=r.getSizeInput("r_raz_ob")%>
      <font class="ed_izm">мм при норме 4 мм.</font>
    </td>
  </tr>
  <tr> 
    <td class="simple_str">Капсула</td>
    <td colspan="3"> 
      <%=r.getSelect("r_kapsula")%>
      <%=r.getSizeInput("r_dop_kapsula")%>мм
      <%=r.getSelect("r_kak_kaps")%>
    </td>
  </tr>
  <tr> 
  <td>Гиперэхогенные включения и узурация</td>
    <td colspan="3">у места прикрепления к кости
      <%=r.getSelect("r_yzur")%>
    </td>
  </tr>
  <tr> 
    <td class="simple_str">Суставные поверхности
      <%=r.getSelect("r_sus_pov")%>
    </td>
    <td colspan="3">за счет<br>
        <%=r.getCheckbox("r_sust_ost")%><br>
        <%=r.getCheckbox("r_sust_yzur")%><br>
        <%=r.getCheckbox("r_sust_kist")%>
    </td>
  </tr>
  <tr> 
    <td class="simple_str">Суставная щель </td>
    <td colspan="3"> 
      <%=r.getSelect("r_sust_shel")%>
    </td>
  </tr>
  <tr> 
    <td class="simple_str">Гиалиновый хрящ</td>
    <td class="simple_str" width="30%"> 
      <%=r.getSelect("r_hrjash")%><br>
    размером <%=r.getSizeInput("r_ghmm")%>мм<br>
    при норме не менее 2 мм.
    </td>
    <td colspan="2">
        <%=r.getChangeHidden("r_hrjash", "1", "1701")%>
            за счет<br> 
            <%=r.getCheckbox("r_hrjsh_giper")%><br>
            <%=r.getCheckbox("r_hrjsh_yzur")%><br>
            <%=r.getCheckbox("r_hrjsh_kist")%>
        </div>
    </td>
  </tr>
  <tr> 
    <td colspan="4" class="simple_str">Субхондральные и эпифизарные кисты
      <%=r.getSelect("r_kist")%>
    </td>
  </tr>
  <tr> 
    <td class="simple_str">Связки</td>
    <td colspan="3"> 
      <%=r.getSelect("r_menisk")%>
    </td>
  </tr>
  <tr> 
    <td colspan="4">Дегенеративно-дистрофические изменения в виде субхандрального склероза <%=r.getSelect("r_deger")%></td>
  </tr>
  <tr>
    <td colspan="4">Гипертонус параартикулярных тканей
      <%=r.getSelect("r_giper")%>
    </td>
  </tr>
  <tr>
    <td colspan="4">
      <%=r.getTextInput("r_giper_how")%>
    </td>
  </tr>
</table>

<font class="underline_str"><b>Левый тазобедренный сустав</b></font><br>

<table width="90%" border="1">
  <tr> 
    <td class="simple_str" width="35%">Форма головки бедренной кости </td>
    <td colspan="3">  
      <%=r.getSelect("l_head")%>
    </td>
  </tr>
  <tr>
    <td>Метэпифизарный индекс</td>
  <td colspan="3"><%=r.getSizeInput("l_index")%> при норме 1,1 мм.</td>
  </tr>
  <tr> 
    <td class="simple_str">Выпот в полости сустава</td>
    <td colspan="3"> 
      <%=r.getSelect("l_vipot")%>
    </td>
  </tr>
  <tr> 
    <td colspan="4" class="simple_str">Толщина синовиального пространства в точке перехода шейки бедра в головку
      <%=r.getSizeInput("l_raz_ob")%>
      <font class="ed_izm">мм при норме 4 мм.</font>
    </td>
  </tr>
  <tr> 
    <td class="simple_str">Капсула</td>
    <td colspan="3"> 
      <%=r.getSelect("l_kapsula")%>
      <%=r.getSizeInput("l_dop_kapsula")%>мм
      <%=r.getSelect("l_kak_kaps")%>
    </td>
  </tr>
  <tr> 
  <td>Гиперэхогенные включения и узурация</td>
    <td colspan="3">у места прикрепления к кости
      <%=r.getSelect("l_yzur")%>
    </td>
  </tr>
  <tr> 
    <td class="simple_str">Суставные поверхности
      <%=r.getSelect("l_sus_pov")%>     
    </td>
    <td colspan="3">за счет<br>
       <%=r.getCheckbox("l_sust_ost")%><br>
       <%=r.getCheckbox("l_sust_yzur")%><br>
       <%=r.getCheckbox("l_sust_kist")%>
    </td>
  </tr>
  <tr> 
    <td class="simple_str">Суставная щель </td>
    <td colspan="3"> 
      <%=r.getSelect("l_sust_shel")%>
    </td>
  </tr>
  <tr> 
    <td class="simple_str">Гиалиновый хрящ</td>
    <td class="simple_str" width="30%">
      <%=r.getSelect("l_hrjash")%><br>
    размером<%=r.getSizeInput("l_ghmm")%>мм<br>
    при норме не менее 2 мм.
    </td>
    <td colspan="2">
        <%=r.getChangeHidden("l_hrjash", "2", "1701")%>
            за счет<br> 
            <%=r.getCheckbox("l_hrjsh_giper")%><br>
            <%=r.getCheckbox("l_hrjsh_yzur")%><br>
            <%=r.getCheckbox("l_hrjsh_kist")%>
        </div>
    </td>
  </tr>
  <tr> 
    <td colspan="4" class="simple_str">Субхондральные и эпифизарные кисты
      <%=r.getSelect("l_kist")%>
    </td>
  </tr>
  <tr> 
    <td class="simple_str">Связки</td>
    <td colspan="3"> 
      <%=r.getSelect("l_menisk")%>
    </td>
  </tr>
  <tr> 
    <td colspan="4">Дегенеративно-дистрофические изменения в виде субхандрального склероза <%=r.getSelect("l_deger")%></td>
  </tr>
  <tr>
    <td colspan="4">Гипертонус параартикулярных тканей
      <%=r.getSelect("l_giper")%>
    </td>
  </tr>
  <tr>
    <td colspan="4">
      <%=r.getTextInput("l_giper_how")%>
    </td>
  </tr>
</table>

<%@include file="footer.jsp"%>