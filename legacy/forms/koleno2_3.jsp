<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title" align="center">УЗИ коленных суставов</H3>
<font class="underline_str"><b>Правый коленный сустав</b></font><br>

<table width="100%" border="1">
  <tr> 
    <td colspan="5" class="simple_str">В полости сустава <%=r.getSelect("r_polost")%></td>
  </tr>
</table>      

<SCRIPT LANGUAGE="JavaScript">
            document.protocol.r_polost.focus();
      </script>

        <div id="display21" style="display:none;position:relative; left:12;">
           <table width="100%" border="1">
              <tr><td>размеры верхнего заворота <%=r.getSizeInput("r_size_a")%> мм * 
                                                <%=r.getSizeInput("r_size_b")%> мм *
                                                <%=r.getSizeInput("r_size_c")%> мм
                                               объем <%=r.getSizeInput("r_size_v")%> мл 
                  </td>
              </tr>
           </table>
       </div>
        <SCRIPT> 
            change21();
            document.protocol.r_polost.onchange = change21;
            function change21(){
                if(protocol.r_polost.value == "3364" || protocol.r_polost.value == "3365" || protocol.r_polost.value == "3366")
             {
                    display21.style.display = "";
                   
                } else{ 
                    display21.style.display = "none";
                    
                }
            }
        </SCRIPT>



<table width="100%" border="1">
  <tr> 
    <td colspan="5">Характер выпота <%=r.getSelect("r_vypot")%></td>
  </tr>
  <tr> 
    <td colspan="1" width="30%">Синовиальная оболочка</td>
    <td colspan="4"><%=r.getSelect("r_sinov")%> <%=r.getSizeInput("r_sinov_size")%> мм</td>
  </tr>
  <tr> 
    <td colspan="1" width="30%">Васкуляризация</td>
    <td colspan="4"><%=r.getSelect("r_vaskul")%></td>
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

<div id="display23" style="display:none;position:relative; left:12;">
           <table width="100%" border="1">
              <tr><td>Васкуляризация стенки кисты <%=r.getSelect("r_beker_ki")%> 
                  </td>
              </tr>
           </table>
       </div>
        <SCRIPT> 
            change23();
            document.protocol.r_beker.onchange = change23;
            function change23(){
                if(protocol.r_beker.value == "3429")
             {
                    display23.style.display = "";
                   
                } else{ 
                    display23.style.display = "none";
                    
                }
            }
        </SCRIPT>



<font class="underline_str"><b>Левый коленный сустав</b></font><br>

<table width="100%" border="1">
  <tr> 
    <td colspan="5" class="simple_str">В полости сустава <%=r.getSelect("l_polost")%></td>
  </tr>
</table>
        <div id="display22" style="display:none;position:relative; left:12;">
           <table width="100%" border="1">
              <tr><td>размеры верхнего заворота <%=r.getSizeInput("l_size_a")%> мм * 
                                                <%=r.getSizeInput("l_size_b")%> мм *
                                                <%=r.getSizeInput("l_size_c")%> мм
                                               объем <%=r.getSizeInput("l_size_v")%> мл 
                  </td>
              </tr>
           </table>
       </div>
        <SCRIPT> 
            change22();
            document.protocol.l_polost.onchange = change22;
            function change22(){
                if(protocol.l_polost.value == "3364" || protocol.l_polost.value == "3365" || protocol.l_polost.value == "3366")
             {
                    display22.style.display = "";
                   
                } else{ 
                    display22.style.display = "none";
                    
                }
            }
        </SCRIPT>



<table width="100%" border="1">
  <tr> 
    <td colspan="5">Характер выпота <%=r.getSelect("l_vypot")%></td>
  </tr>
  <tr> 
    <td colspan="1" width="30%">Синовиальная оболочка</td>
    <td colspan="4"><%=r.getSelect("l_sinov")%> <%=r.getSizeInput("l_sinov_size")%> мм</td>
  </tr>
<tr> 
    <td colspan="1" width="30%">Васкуляризация</td>
    <td colspan="4"><%=r.getSelect("l_vaskul")%></td>
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

<div id="display24" style="display:none;position:relative; left:12;">
           <table width="100%" border="1">
              <tr><td>Васкуляризация стенки кисты <%=r.getSelect("l_beker_ki")%> 
                  </td>
              </tr>
           </table>
       </div>
        <SCRIPT> 
            change24();
            document.protocol.l_beker.onchange = change24;
            function change24(){
                if(protocol.l_beker.value == "3429")
             {
                    display24.style.display = "";
                   
                } else{ 
                    display24.style.display = "none";
                    
                }
            }
        </SCRIPT>



<Script>
  document.protocol.r_size_a.onchange = executeRange1
  document.protocol.r_size_b.onchange = executeRange1
  document.protocol.r_size_c.onchange = executeRange1

  document.protocol.l_size_a.onchange = executeRange2
  document.protocol.l_size_b.onchange = executeRange2
  document.protocol.l_size_c.onchange = executeRange2

  function executeRange1()
  { r_size_a = parseFloat(document.protocol.r_size_a.value);
    r_size_b = parseFloat(document.protocol.r_size_b.value);
    r_size_c = parseFloat(document.protocol.r_size_c.value);

    if (isNaN(parseFloat(document.protocol.r_size_a.value)) && document.protocol.r_size_a.value!="") {notFloat(); document.protocol.r_size_v.value = "";}
    if (isNaN(parseFloat(document.protocol.r_size_b.value)) && document.protocol.r_size_b.value!="") {notFloat(); document.protocol.r_size_v.value = "";}
    if (isNaN(parseFloat(document.protocol.r_size_c.value)) && document.protocol.r_size_c.value!="") {notFloat(); document.protocol.r_size_v.value = "";}

    if(document.protocol.r_size_a.value != "" && document.protocol.r_size_b.value != "" && document.protocol.r_size_c.value != ""){
        document.protocol.r_size_v.value = cut(((r_size_a * r_size_b * r_size_c)/1000)*0.479);
    }
  }

  function executeRange2()
  { l_size_a = parseFloat(document.protocol.l_size_a.value);
    l_size_b = parseFloat(document.protocol.l_size_b.value);
    l_size_c = parseFloat(document.protocol.l_size_c.value);

    if (isNaN(parseFloat(document.protocol.l_size_a.value)) && document.protocol.l_size_a.value!="") {notFloat(); document.protocol.l_size_v.value = "";}
    if (isNaN(parseFloat(document.protocol.l_size_b.value)) && document.protocol.l_size_b.value!="") {notFloat(); document.protocol.l_size_v.value = "";}
    if (isNaN(parseFloat(document.protocol.l_size_c.value)) && document.protocol.l_size_c.value!="") {notFloat(); document.protocol.l_size_v.value = "";}

    if(document.protocol.l_size_a.value != "" && document.protocol.l_size_b.value != "" && document.protocol.l_size_c.value != ""){
        document.protocol.l_size_v.value = cut(((l_size_a * l_size_b * l_size_c)/1000)*0.479);
    }
  }


  function cut(arg){
    arg = arg.toString();
    array_arg = arg.split(".");
    if (array_arg[1]){
      vr = array_arg[1];
      vr = vr.substring(0,2);
      arg = array_arg[0] + "." + vr;
    }
    return arg;
  }
  function notFloat(){
    alert("Необходимо ввести число. Знаком разделения целой и дробной части служит точка.")
  }


</Script>


<%@include file="footer.jsp"%>
