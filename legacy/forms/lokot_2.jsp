<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title" align="center">УЗИ локтевых суставов</H3>

<font class="underline_str"><b>Правый локтевой сустав</b></font><br>
<table width="100%" border="1">
  <tr> 
    <td colspan="5" class="simple_str">Форма сустава <%=r.getSelect("r_forma")%></td>
  </tr>
      <SCRIPT LANGUAGE="JavaScript">
            document.protocol.r_forma.focus();
      </script>
  <tr> 
    <td colspan="5" class="simple_str">Суставная щель <%=r.getSelect("r_shel")%></td>
  </tr>
  <tr> 
    <td colspan="5" class="simple_str">В полости сустава <%=r.getSelect("r_polost")%></td>
  </tr>
  <tr> 
    <td colspan="1" width="30%">Гиалиновый хрящ</td>
    <td colspan="4"><%=r.getSelect("r_hryash")%></td>
  </tr>
  <tr> 
    <td colspan="1" width="30%">Субхондральная пластина суставных концов</td>
    <td colspan="4"><%=r.getSelect("r_sub_konc")%></td>
  </tr>
  <tr> 
    <td colspan="1" width="30%">Капсула сустава</td>
    <td colspan="4">
        <%=r.getSelect("r_kapsula")%>
    </td>
  </tr>
  <tr> 
    <td colspan="5" width="30%">Сухожилие у места прикрепления к надмыщелкам
        <%=r.getSelect("r_suho")%>
    </td>
  </tr>
  <tr> 
    <td colspan="1" width="30%">Контур латерального надмыщелка</td>
    <td colspan="4"><%=r.getSelect("r_lat_nad")%></td>
  </tr>
  <tr> 
    <td colspan="1" width="30%">Сухожилия разгибателей</td>
    <td colspan="4"><%=r.getSelect("r_suho_razg")%></td>
  </tr>
  <tr> 
    <td colspan="1" width="30%">Васкуляризация</td>
    <td colspan="4"><%=r.getSelect("r_vaska")%></td>
  </tr>
  <tr> 
    <td colspan="1" width="30%">Контур медиального надмыщелка</td>
    <td colspan="4"><%=r.getSelect("r_med_nad")%></td>
  </tr>
  <tr> 
    <td colspan="1" width="30%">Сухожилия сгибателей</td>
    <td colspan="4"><%=r.getSelect("r_suho_sgib")%></td>
  </tr>
</table>

<font class="underline_str"><b>Левый локтевой сустав</b></font><br>
<table width="100%" border="1">
  <tr> 
    <td colspan="5" class="simple_str">Форма сустава <%=r.getSelect("l_forma")%></td>
  </tr>
  <tr> 
    <td colspan="5" class="simple_str">Суставная щель <%=r.getSelect("l_shel")%></td>
  </tr>
  <tr> 
    <td colspan="5" class="simple_str">В полости сустава <%=r.getSelect("l_polost")%></td>
  </tr>
  <tr> 
    <td colspan="1" width="30%">Гиалиновый хрящ</td>
    <td colspan="4"><%=r.getSelect("l_hryash")%></td>
  </tr>
  <tr> 
    <td colspan="1" width="30%">Субхондральная пластина суставных концов</td>
    <td colspan="4"><%=r.getSelect("l_sub_konc")%></td>
  </tr>
  <tr> 
    <td colspan="1" width="30%">Капсула сустава</td>
    <td colspan="4">
        <%=r.getSelect("l_kapsula")%>
    </td>
  </tr>
  <tr> 
    <td colspan="5" width="30%">Сухожилие у места прикрепления к надмыщелкам
        <%=r.getSelect("l_suho")%>
    </td>
  </tr>
  <tr>
    <td colspan="1" width="30%">Контур латерального надмыщелка</td>
    <td colspan="4"><%=r.getSelect("l_lat_nad")%></td>
  </tr>
  <tr> 
    <td colspan="1" width="30%">Сухожилия разгибателей</td>
    <td colspan="4"><%=r.getSelect("l_suho_razg")%></td>
  </tr>
  <tr> 
    <td colspan="1" width="30%">Васкуляризация</td>
    <td colspan="4"><%=r.getSelect("l_vaska")%></td>
  </tr>
  <tr> 
    <td colspan="1" width="30%">Контур медиального надмыщелка</td>
    <td colspan="4"><%=r.getSelect("l_med_nad")%></td>
  </tr>
  <tr> 
    <td colspan="1" width="30%">Сухожилия сгибателей</td>
    <td colspan="4"><%=r.getSelect("l_suho_sgib")%></td>
  </tr>
</table>

<%@include file="footer.jsp"%>
