<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%
    //request.SetCharacterEncoding("Cp1251");
    RequestWrapper r = new RequestWrapper(request);
%>
<HTML>
<HEAD>
<link rel="stylesheet" href="/res/prot_view.css" type="text/css">
</HEAD>
<BODY bgcolor="#FFFFFF" text="#000000" topmargin="0" leftmargin="0">
<script language="JavaScript">
function setAction(value) {
    document.menu.action.value = value;
}
function hideElements()
{
    var removeEl = document.all.remove;
    if(removeEl !='' && removeEl.length==null)
        removeEl.style.display='none';
    else{
        for(i=0; i<removeEl.length; i++)
            removeEl[i].style.display='none';
    }
}

function showElements()
{
    var removeEl = document.all.remove;
    if(removeEl !='' && removeEl.length==null)
        removeEl.style.display='';
    else{
        for(i=0; i<removeEl.length; i++)
            removeEl[i].style.display='';
    }
}
function changeView()
{
    if(document.menu.change_view.checked == true)
    {
       div_full.style.display = "none";
       div_small.style.display = "";
    }else{
       div_full.style.display = "";
       div_small.style.display = "none";
    }
}

function keyHook(){
    if(event.keyCode == 27){
        event.returnValue=true;
        window.close();
        return;
    }
}
<%if(r.get("esc_close")!=null) {%>
document.onkeydown=keyHook;
<%}%>
window.onbeforeprint = hideElements;
window.onafterprint = showElements;
</script>
<table width="700" cellpadding="0" cellspacing="0">
<tr valign="bottom" height="100">
    <td width="20%" rowspan="2"><img src="/uzi/logo.jpg"></td>
    <td colspan="2" width="80%"  align="center" valign="center">
        <b>ООО "УЗИ Диагностика +"</b><br/>Лицензия ЛО-55-01-000943 от 14.11.2012г тел. 22-876 <br>   моб. 8-950-789-11-24   моб. 8-905-096-06-43.        
    </td>
</tr>
<tr valign="top">

    <td colspan="2" width="80%" nowrap align="center" valign="top"></td>
</tr>
<tr>
    <td colspan="3" align="center" height="10" >
        <%String s = r.get("research").toString();
        if(s.indexOf('+') == -1){%><p style="font-size: 24px; font-family: Arial; font-style:normal; font-weight:normal;"><%=r.get("research")%></p><%}%>
    </td>
</tr>
<tr>
    <td colspan="2" align="left">
        <p style="line-height:15pt; font-size:100%; font-family: Arial; font-style:normal; font-weight:normal;" align=justify>
        Пациент <b><%=r.get("fio")%></b><br>
        Дата рождения: <b><%=r.get("birthdate")%> г.</b>&nbsp;&nbsp;Пол: <b><%=(r.get("gender").equals("M") ? "М" : "Ж")%></b><br>
        Адрес: <b><%=r.get("city")%> <%=r.get("street")%> <%=r.get("house")%> <%=r.get("flat")%></b><br>
  <br> Добровольное информированное согласие пациента на исследование получено.  

  <br> Исследование проводилось на аппарате экспертного класса MINDRAY DC-70.
        </p>
    </td>
    <td align="left" valign="bottom" width="20%">&nbsp;</td>
</tr>
<%if(!r.empty("lpu_name")){%><tr><td align="right">Направлен из: <%=r.get("lpu_name")%></td></tr><%}%>
</table>
<form name="menu" action="/uzi/servlet/MainServlet" method="post">
<table width="700" cellpadding="0" cellspacing="0">
<tr><td> <p style="line-height:15pt; font-size:100%; font-family: Arial; font-style:normal; font-weight:normal;" align="justify" valign="top">
<%
    String[] fileAry;
    String fileStr;
    fileStr = r.get("fileLst").toString();
    fileAry = fileStr.split(",");
    %>