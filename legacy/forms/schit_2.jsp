<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title">УЛЬТРАЗВУКОВОЕ ИССЛЕДОВАНИЕ ЩИТОВИДНОЙ ЖЕЛЕЗЫ</H3>
<table width="90%" border="1">
    <tr>
        <td colspan="4" class="simple_str">Щитовидная железа
            <%=r.getSelect("jeleza")%>
            <SCRIPT LANGUAGE="JavaScript">
            document.protocol.jeleza.focus();
            </script>
        </td>
    </tr>
    <tr>
        <td width="17%" class="simple_str">Контур
        </td>
        <td colspan="3">
            <%=r.getSelect("kontur")%>
    </tr>
    <tr>
        <td colspan="4" class="simple_str">Размеры
        </td>
    </tr>
    <tr>
        <td width="17%" class="simple_str">Правая доля
        </td>
        <td colspan="3">
            Ширина<%=r.getSizeInput("rdolaj_sh")%>
            Толщина<%=r.getSizeInput("rdolaj_tol")%>
            Длина<%=r.getSizeInput("rdolaj_dl")%>
            <font class="ed_izm">(мм)</font>
        </td>
    </tr>
    <tr>
        <td width="17%" class="simple_str">Левая доля
        </td>
        <td colspan="3">
            Ширина<%=r.getSizeInput("ldolaj_sh")%>
            Толщина<%=r.getSizeInput("ldolaj_tol")%>
            Длина<%=r.getSizeInput("ldolaj_dl")%>
            <font class="ed_izm">(мм)</font>
        </td>
    </tr>
    <tr>                                     	
        <td width="17%" class="simple_str">Перешеек
        </td>
        <td colspan="3">
            <%=r.getSizeInput("peresheek")%>
            <font class="ed_izm">(мм)</font>
<!--        </td>
        <td rowspan="3" width="50%"><img src="/res/ris2.jpg" width="333" height="88" align="right">
        </td>-->
    </tr>
    <tr>
        <td width="17%" class="simple_str">Тиреоидный объем
        </td>
        <td colspan="3">
            <%=r.getSizeInput("tir_obem")%>
            <font class="ed_izm">(мл)</font>
        </td>
    </tr>
    <tr>
        <td width="17%" class="simple_str">Эхогенность
        </td>
        <td colspan="3">
            <%=r.getSelect("ehogennost")%>
        </td>
    </tr>
    <tr>
        <td colspan="4" class="simple_str">Эхоструктура
            <%=r.getSelect("ehostructura")%>в сочетании с <%=r.getSelect("sochetanie")%>
    	</td>
    </tr>
    <tr>
        <td colspan="4">
            <%=r.getSelect("limfoyzli")%>
        </td>
    </tr>

</table>
<Script>
  document.protocol.rdolaj_sh.onchange = executeRange
  document.protocol.rdolaj_tol.onchange = executeRange
  document.protocol.rdolaj_dl.onchange = executeRange
  document.protocol.ldolaj_sh.onchange = executeRange
  document.protocol.ldolaj_tol.onchange = executeRange
  document.protocol.ldolaj_dl.onchange = executeRange
  function executeRange()
  { r_dol_sh = parseFloat(document.protocol.rdolaj_sh.value);
  	r_dol_tol = parseFloat(document.protocol.rdolaj_tol.value);
  	r_dol_dl = parseFloat(document.protocol.rdolaj_dl.value);
  	l_dol_sh = parseFloat(document.protocol.ldolaj_sh.value);
  	l_dol_tol = parseFloat(document.protocol.ldolaj_tol.value);
  	l_dol_dl = parseFloat(document.protocol.ldolaj_dl.value);

  	if (isNaN(parseFloat(document.protocol.rdolaj_sh.value)) && document.protocol.rdolaj_sh.value!="") {notFloat();}
  	if (isNaN(parseFloat(document.protocol.rdolaj_tol.value)) && document.protocol.rdolaj_tol.value!="") {notFloat();}
  	if (isNaN(parseFloat(document.protocol.rdolaj_dl.value)) && document.protocol.rdolaj_dl.value!="") {notFloat();}
  	if (isNaN(parseFloat(document.protocol.ldolaj_sh.value)) && document.protocol.ldolaj_sh.value!="") {notFloat();}
  	if (isNaN(parseFloat(document.protocol.ldolaj_tol.value)) && document.protocol.ldolaj_tol.value!="") {notFloat();}
  	if (isNaN(parseFloat(document.protocol.ldolaj_dl.value)) && document.protocol.ldolaj_dl.value!="") {notFloat();}

  	if(document.protocol.rdolaj_sh.value != "" && document.protocol.rdolaj_tol.value != "" && document.protocol.rdolaj_dl.value != "" && document.protocol.ldolaj_sh.value != "" && document.protocol.ldolaj_tol.value != "" && document.protocol.ldolaj_dl.value != ""){
  		r_dol = cut(r_dol_sh * r_dol_tol * r_dol_dl)/1000;
  		l_dol = cut(l_dol_sh * l_dol_tol * l_dol_dl)/1000;
		document.protocol.tir_obem.value = cut((r_dol + l_dol)*0.479);
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
