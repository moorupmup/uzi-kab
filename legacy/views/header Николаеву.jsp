<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%
    RequestWrapper r = new RequestWrapper(request);
    String birthdayStr;
    String[] array;
    String res = "";
    birthdayStr = r.get("birthday").toString();
    array = birthdayStr.split("-");
    for(int count = array.length - 1; count >= 0; count--){
        if(count != 0) res += array[count] + "."; else res = array[count];
    }
%>
<HTML>
<HEAD>
<link rel="stylesheet" href="/uzi/css/style.css" type="text/css">
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
<tr width="50%">
    <td>

    <font face="arial" size="1">
    <b>ООО "Клинико-диагностический центр "Ультрамед" Россия, 644024 г. Омск, 
ул. Красных Зорь угол ул. Чкалова, д. 19/12, т.(3812)511-001  
ИНН 5504128136, КПП 550401001, ОГРН 1075504005323, р/сч. 407028108000000807000, в филиале
"ОПСБ" ОАО "ОТП Банк" г.Омск, к/сч. 30101810000000000777, БИК 045209777</b><br>
    </font>

    </td>
   <td  width="20%">&nbsp;</td>



<td align="right">
    <img src="/logo.bmp"><br>
    <!--<font size="1">Лицензия: № ЛО-55-01-000375</font>--><br>
    </td>
</tr>

<tr>
    <td colspan="2">
    <%String s = r.get("research").toString();
    if(s.indexOf('+') == -1){%><div align="center"><font size="4"><b><%=r.get("research")%></b></font></div><%}%>
    Ф.И.О. <b><%=r.get("fio")%></b><br>
    Дата рождения: <b><%=res%> г.</b>&nbsp;&nbsp;Пол: <b><%=(r.get("sex").equals("M") ? "М" : "Ж")%></b>&nbsp;
    Адрес: <b><%=r.get("address")%></b><br>
    </td>
    &nbsp;
    </td>
</tr>
</table>
<table width="700" cellpadding="0" cellspacing="0">
<tr><td> <p style="line-height:11pt" align=justify>
<form name="menu" action="/uzi/servlet/MainServlet" method="post">
<%
    String[] fileAry;
    String fileStr;
    fileStr = r.get("fileLst").toString();
    fileAry = fileStr.split(",");
    %>