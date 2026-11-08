<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title">УЗИ голеностопных суставов</H3>
<font class="underline_str"><b>Правый голеностопный сустав</b></font><br>
<table width="90%" border="1">
  <tr> 
    <td class="simple_str" width="25%">Форма</td>
    <td colspan="3">  
      <%=r.getSelect("r_forma")%>
    </td>
  </tr>
  <tr> 
    <td colspan="4" class="simple_str">Суставные поверхности
      <%=r.getSelect("r_sus_pov")%>
    </td>
  </tr>
  <tr> 
    <td class="simple_str">Суставная щель </td>
    <td colspan="4"> 
      <%=r.getSelect("r_sust_shel")%>
    </td>
  </tr>
  <tr> 
    <td class="simple_str">Гиалиновый хрящ</td>
    <td class="simple_str" width="25%"> 
      <%=r.getSelect("r_hrjash")%><br>
    </td>
    <td colspan="2"> 
      <%=r.getChangeHidden("r_hrjash", "1", "2195")%>
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
    <td colspan="4">Свободная жидкость
      <%=r.getSelect("r_jidkost")%>
    </td>
  </tr>
  <tr>
    <td colspan="4">
      <%=r.getTextInput("r_giper_how")%>
    </td>
  </tr>
</table>

<font class="underline_str"><b>Левый голеностопный сустав</b></font><br>
<table width="90%" border="1">
  <tr> 
    <td class="simple_str" width="25%">Форма</td>
    <td colspan="3">  
      <%=r.getSelect("l_forma")%>
    </td>
  </tr>
  <tr> 
    <td colspan="4" class="simple_str">Суставные поверхности
      <%=r.getSelect("l_sus_pov")%>
    </td>
  </tr>
  <tr> 
    <td class="simple_str">Суставная щель </td>
    <td colspan="4"> 
      <%=r.getSelect("l_sust_shel")%>
    </td>
  </tr>
  <tr> 
    <td class="simple_str">Гиалиновый хрящ</td>
    <td class="simple_str" width="25%"> 
      <%=r.getSelect("l_hrjash")%><br>
    </td>
    <td colspan="2"> 
      <%=r.getChangeHidden("l_hrjash", "2", "2195")%>
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
    <td colspan="4">Свободная жидкость
      <%=r.getSelect("l_jidkost")%>
    </td>
  </tr>
  <tr>
    <td colspan="4">
      <%=r.getTextInput("l_giper_how")%>
    </td>
  </tr>
</table>

<%@include file="footer.jsp"%>