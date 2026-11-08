<%@page import="my_pack.tools.*" import="my_pack.beans.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<table>
<tr><td>
Ф.И.О. <b><%=r.get("fio")%></b><br>
<%
    String birthdayStr;
    String[] array;
    String res = "";
    ProtocolViewBean lpu;
    ProtocolViewBean[] lpu_list = (ProtocolViewBean[])request.getAttribute("lpuList");
    ProtocolViewBean protocol;
    ProtocolViewBean[] protocol_list = (ProtocolViewBean[])request.getAttribute("pacient_protocols");

    long lpuId = 0;
    long lpuDoctorId = 0;
    if(r.get("lpu_id")!=null && !r.get("lpu_id").equals("")) lpuId = Long.parseLong(r.get("lpu_id").toString());
    if(r.get("lpu_doctor_id")!=null && !r.get("lpu_doctor_id").equals("")) lpuDoctorId = Long.parseLong(r.get("lpu_doctor_id").toString());
%>
Пол: <b><%=(r.get("gender").equals("M") ? "М" : "Ж")%></b> Дата рождения: <b><%=r.get("birthdate")%> г.</b> <br>
Адрес: <b><%=r.get("city")%> <%=r.get("street")%> <%=r.get("house")%> <%=r.get("flat")%></b><br>
Направлен из: <select name="lpu">
    <option value="0|0"></option>
    <%for (int i=0; i < lpu_list.length; i++) {
        lpu = lpu_list[i];%>
        <option value="<%=lpu.getLpuId()%>|<%=lpu.getLpuDoctorId()%>" <%=(lpu.getLpuId() == lpuId && lpu.getLpuDoctorId() == lpuDoctorId ? "selected" : "")%>><%=lpu.getName()%></option>
    <%}%>
</select>
</td>
</tr>
</table>
<input type="checkbox" name="pacient_protocols">Показать список выполненных исследований
<div id="display_protocols" style="display:none;position:relative; left:0;">
    <table border="1" width="100%">
        <tr><th colspan="4">Список пройденных исследований</th></tr>
        <%for(int i=0; i < protocol_list.length; i++){
            protocol = protocol_list[i];%>
            <tr>
                <td><%=protocol.getId()%></td>
                <td><a href="" onClick="javascript:new_win=window.open('/uzi/servlet/MainServlet?action=view_protocol&protocol_id=<%=protocol.getId()%>&esc_close=on','protocol','scrollbars=1,status=0,resizable=1'); new_win.focus(); return false;"><%=protocol.getResearch()%></a></td>
                <td><%=protocol.getDateEnd()%></td>
                <td><%=protocol.getDoctor()%></td></tr>
        <%}%>
    </table>
</div>
<Script>
    viewPacientProtocols();
    document.protocol.pacient_protocols.onclick  = viewPacientProtocols

    function viewPacientProtocols()
    {
        if(document.protocol.pacient_protocols.checked == true)
            display_protocols.style.display = "";
        else
            display_protocols.style.display = "none";
    }
</Script>
