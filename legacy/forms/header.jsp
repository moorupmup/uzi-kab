<% 
    RequestWrapper r = new RequestWrapper(request); 
%>
<HTML>
<HEAD>
<link rel="stylesheet" href="/uzi/css/style.css" type="text/css">
</HEAD>
<BODY bgcolor="#CCCCCC" text="#000000">
<script src="/uzi/reference.js"></script>
<SCRIPT LANGUAGE="JavaScript">
function setAction(value) {
    document.protocol.action.value = value;
}
function clickHandler() {
    var targetId, srcElement, targetElement;
    srcElement = window.event.srcElement;
    if (srcElement.className == "Outline") {
        targetId = srcElement.id + "details";
        targetElement = document.all(targetId);
        if (targetElement.style.display == "none") {
            targetElement.style.display = "";
        } else {
            targetElement.style.display = "none";
        }
    }
}
function keyHook(){
    if(event.keyCode == 13){
        event.keyCode = 9;
        event.returnValue=true;
        return;
    }
}
window.onload = function() {

 this.reference = new ReferenceList();

}
function fn(e,ctl,newLevel, mode) {
 if(e[document.all?"keyCode":"which"]==13)

  with(reference) {

    setBookMode(mode);
    setEditElement(ctl);
   if(ctl.nextSibling && ctl.nextSibling.nodeName!="#text") {
    setKeyField(ctl.nextSibling);
   }
   else {
    alert("check a field for a key value.\n\nError");
   }
   open(newLevel);
   if(mode == 0 || mode == 1 || mode == 2) e.returnValue = false;
  }
}
function checkDate(f_name){
    var len;
    var val;
    var key;
    var field;
    key = event.keyCode;
    field = eval(f_name);
    val = field.value;
    len = val.length;
    if(key == 13){
        event.keyCode = 9;
        event.returnValue=true;
        return;
    }
    if( !( (key==8) || (key==9) || (key >= 48 && key <= 57) || (key >= 96 && key <= 105) ) ){
        event.returnValue=false;
        return;
    }
    if(len == 2 && event.keyCode!=8)
        field.value = val + ".";
    if(len == 5 && event.keyCode!=8)
        field.value = val + ".";
    if(len > 9 && event.keyCode!=8 && event.keyCode!=9)
        event.returnValue=false;
}
function resizeArea(val)
{
    var r, c, l;
    if(val != ""){
        field = eval(val);
        r = field.rows;
        c = field.cols;
        l = field.value.length;

        if(((l-10)/c+1) > r) field.rows = field.rows + 2;
    }

}

</SCRIPT>
<form action="/uzi/servlet/MainServlet" method="post" name="protocol">
<input type="hidden" name="action" value="save_protocol">
<%
    Long doctor = (Long)session.getAttribute("uzi.doctor_id");
    String doctorId = doctor.toString();
%>
<input type="hidden" name="cabinet_id" value="1">
<input type="hidden" name="doctor_id" value="<%=doctorId%>">
<input type="hidden" name="depart_id" value="1">
<input type="hidden" name="research_id" value="<%=r.get("research_id")%>">
<input type="hidden" name="pacient_id" value="<%=r.get("pacient_id")%>">
<input type="hidden" name="token" value="<%= request.getAttribute("token") %>">
<input type="hidden" name="protocol_id" value="<%=r.get("protocol_id")%>">
<input type="hidden" name="esc_close" value="<%=r.get("esc_close")%>">
<input type="hidden" name="id_reg" value="<%=r.get("id_reg")%>">
<%@include file="passport_1.jsp"%>