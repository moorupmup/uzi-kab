<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>

<H3 class="p_title">Пункция печени</H3>
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


    
         

<%@include file="footer.jsp"%>
