<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title" align="center">УЗИ коленных суставов</H3>
<font class="underline_str"><b>Правый коленный сустав</b></font><br>

<table width="100%" border="1">
  <tr> 
    <td colspan="5" class="simple_str">В полости сустава <%=r.getSelect("r_polost")%></td>
  </tr>
      <SCRIPT LANGUAGE="JavaScript">
            document.protocol.r_polost.focus();
      </script>
  <tr> 
    <td colspan="5">Характер выпота <%=r.getSelect("r_vypot")%></td>
  </tr>
  <tr> 
    <td colspan="1" width="30%">Синовиальная оболочка</td>
    <td colspan="4"><%=r.getSelect("r_sinov")%></td>
  </tr>
  <tr> 
    <td colspan="1">Сухожилие четырехглавой мышцы бедра</td>
    <td colspan="4">
        <%=r.getSelect("r_suho")%>
        <%=r.getChangeHidden("r_suho", "1", "3378")%>
            за счет
            <%=r.getCheckbox("r_suho_giper")%>
        </div>
    </td>
  </tr>
  <tr> 
    <td colspan="1">Капсула сустава</td>
    <td colspan="4"><%=r.getSelect("r_kapsula")%></td>
  </tr>
  <tr> 
    <td colspan="1">Клечатка Гаффа</td>
    <td colspan="4"><%=r.getSelect("r_gaffa")%></td>
  </tr>
  <tr> 
    <td colspan="1">Субхондральная пластинка</td>
    <td colspan="1"><%=r.getSelect("r_plastina")%></td>
    <td colspan="3">
        <%=r.getChangeHidden("r_plastina", "2", "3384")%>
            за счет<br>
            <%=r.getCheckbox("r_osteof")%>
        </div>
    </td>
  </tr>
  <tr> 
    <td colspan="1">Суставная щель</td>
    <td colspan="4"><%=r.getSelect("r_sust_shel")%></td>
  </tr>
  <tr> 
    <td colspan="1">Медиальный мениск </td>
    <td colspan="4"><%=r.getSelect("r_medial")%></td>
  </tr>
  <tr> 
    <td colspan="3">Краевые костные разрастания в бедренной и б/берцовой кости</td>
    <td colspan="2"><%=r.getSelect("r_krai")%></td>
  </tr>
  <tr> 
    <td colspan="5">Гиалиновый хрящ медиального мыщелка <%=r.getSelect("r_hryash")%> <%=r.getSizeInput("r_hryash_how")%> мм</td>
  </tr>
  <tr> 
    <td colspan="1">Связки<%=r.getSelect("r_svyazki")%></td>
    <td colspan="4">
        <%=r.getChangeHidden("r_svyazki", "3", "3402")%>
            за счет<br>
            <%=r.getCheckbox("r_koll")%><%=r.getTextInput("r_koll_text")%><br>
            <%=r.getCheckbox("r_narug")%><%=r.getTextInput("r_narug_text")%><br>
            <%=r.getCheckbox("r_sobstv")%><%=r.getTextInput("r_sobstv_text")%><br>
            <%=r.getCheckbox("r_zad")%><br>
            <%=r.getCheckbox("r_pered")%><br>
        </div>
    </td>
  </tr>
  <tr> 
    <td colspan="1">Мениски<%=r.getSelect("r_men")%></td>
    <td colspan="3">
        <div id="display10" style="display:none;position:relative; left:12;">
            за счет<br>
            <%=r.getCheckbox("r_giper")%><br>
            <%=r.getCheckbox("r_gipo")%><br>
            <%=r.getCheckbox("r_sign")%>
        </div>
    </td>
    <td width="35%">
        <div id="display11" style="display:none;position:relative; left:12;">
            в области<br><%=r.getSelect("r_oblast")%><br>
            <%=r.getSelect("r_oblmenisk")%><%=r.getSizeInput("r_menisk_how")%> мм
        </div>
        <SCRIPT> 
            changeRmenisk();
            document.protocol.r_men.onchange = changeRmenisk
            function changeRmenisk(){
                if(protocol.r_men.value != "3409"){
                    display10.style.display = "none";
                    display11.style.display = "none";
                } else{ 
                    display10.style.display = "";
                    display11.style.display = "";
                }
            }
        </SCRIPT>
    </td>
  </tr>
  <tr> 
    <td colspan="5"><%=r.getSelect("r_vnesus")%> <%=r.getSelect("r_mesto")%></td>
  </tr>
  <tr> 
    <td colspan="5">Киста Бейкера<%=r.getSelect("r_beker")%> <%=r.getSizeInput("r_beker_how")%>мм <%=r.getSelect("r_beker2")%></td>
  </tr>
</table>

<font class="underline_str"><b>Левый коленный сустав</b></font><br>

<table width="100%" border="1">
  <tr> 
    <td colspan="5" class="simple_str">В полости сустава <%=r.getSelect("l_polost")%></td>
  </tr>
  <tr> 
    <td colspan="5">Характер выпота <%=r.getSelect("l_vypot")%></td>
  </tr>
  <tr> 
    <td colspan="1" width="30%">Синовиальная оболочка</td>
    <td colspan="4"><%=r.getSelect("l_sinov")%></td>
  </tr>
  <tr> 
    <td colspan="1">Сухожилие четырехглавой мышцы бедра</td>
    <td colspan="4">
        <%=r.getSelect("l_suho")%>
        <%=r.getChangeHidden("l_suho", "5", "3378")%>
            за счет
            <%=r.getCheckbox("r_suho_giper")%>
        </div>
    </td>
  </tr>
  <tr> 
    <td colspan="1">Капсула сустава</td>
    <td colspan="4"><%=r.getSelect("l_kapsula")%></td>
  </tr>
  <tr> 
    <td colspan="1">Клечатка Гаффа</td>
    <td colspan="4"><%=r.getSelect("l_gaffa")%></td>
  </tr>
  <tr> 
    <td colspan="1">Субхондральная пластинка</td>
    <td colspan="1"><%=r.getSelect("l_plastina")%></td>
    <td colspan="3">
        <%=r.getChangeHidden("l_plastina", "6", "3384")%>
            за счет<br>
            <%=r.getCheckbox("l_osteof")%>
        </div>
    </td>
  </tr>
  <tr> 
    <td colspan="1">Суставная щель</td>
    <td colspan="4"><%=r.getSelect("l_sust_shel")%></td>
  </tr>
  <tr> 
    <td colspan="1">Медиальный мениск </td>
    <td colspan="4"><%=r.getSelect("l_medial")%></td>
  </tr>
  <tr> 
    <td colspan="3">Краевые костные разрастания в бедренной и б/берцовой кости</td>
    <td colspan="2"><%=r.getSelect("l_krai")%></td>
  </tr>
  <tr> 
    <td colspan="5">Гиалиновый хрящ медиального мыщелка <%=r.getSelect("l_hryash")%> <%=r.getSizeInput("l_hryash_how")%> мм</td>
  </tr>
  <tr> 
    <td colspan="1">Связки<%=r.getSelect("l_svyazki")%></td>
    <td colspan="4">
        <%=r.getChangeHidden("l_svyazki", "7", "3402")%>
            за счет<br>
            <%=r.getCheckbox("l_koll")%><%=r.getTextInput("l_koll_text")%><br>
            <%=r.getCheckbox("l_narug")%><%=r.getTextInput("l_narug_text")%><br>
            <%=r.getCheckbox("l_sobstv")%><%=r.getTextInput("l_sobstv_text")%><br>
            <%=r.getCheckbox("l_zad")%><br>
            <%=r.getCheckbox("l_pered")%>
        </div>
    </td>
  </tr>
  <tr> 
    <td colspan="1">Мениски<%=r.getSelect("l_men")%></td>
    <td colspan="3">
        <div id="display8" style="display:none;position:relative; left:12;">
            за счет<br>
            <%=r.getCheckbox("l_giper")%><br>
            <%=r.getCheckbox("l_gipo")%><br>
            <%=r.getCheckbox("l_sign")%>
        </div>
    </td>
    <td width="35%">
        <div id="display9" style="display:none;position:relative; left:12;">
            в области<br><%=r.getSelect("l_oblast")%><br>
            <%=r.getSelect("l_oblmenisk")%><%=r.getSizeInput("l_menisk_how")%> мм
        </div>
        <SCRIPT> 
            changeLmenisk();
            document.protocol.l_men.onchange = changeLmenisk
            function changeLmenisk(){
                if(protocol.l_men.value != "3409"){
                    display8.style.display = "none";
                    display9.style.display = "none";
                } else{ 
                    display8.style.display = "";
                    display9.style.display = "";
                }
            }
        </SCRIPT>
    </td>
  </tr>
  <tr> 
    <td colspan="5"><%=r.getSelect("l_vnesus")%> <%=r.getSelect("l_mesto")%></td>
  </tr>
  <tr> 
    <td colspan="5">Киста Бейкера<%=r.getSelect("l_beker")%> <%=r.getSizeInput("l_beker_how")%>мм <%=r.getSelect("l_beker2")%></td>
  </tr>
</table>

<%@include file="footer.jsp"%>
