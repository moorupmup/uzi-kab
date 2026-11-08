<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title">Фармокодинамический тест</H3>

<table width="100%" border="1">
    <tr> 
        <td width="20%" class="simple_str">Правая лоханка
        </td>
        <td width="20%">
            <%=r.getSelect("r_lohanka_do")%>
        </td>
        <td width="60%">
            <%=r.getChangeHidden("r_lohanka_do", "1", "2383")%>
                <%=r.getSizeInput("r_lohanka_do_how")%>
                <span class="ed_izm"> мм</span><br>
                <%=r.getCheckbox("r_verh_do")%><br>
                <%=r.getCheckbox("r_niz_do")%>
                <%=r.getSizeInput("r_niz_do_how")%>
                <span class="ed_izm"> мм</span><br>
                <%=r.getCheckbox("r_chls_do")%>
                <%=r.getSizeInput("r_chls_do_how")%>
                <span class="ed_izm"> мм</span>
            </div>
        </td>
        <SCRIPT LANGUAGE="JavaScript">
            document.protocol.r_lohanka_do.focus();
        </script>
    </tr>
    <tr> 
        <td class="simple_str">Левая лоханка
        </td>
        <td>
            <%=r.getSelect("l_lohanka_do")%>
        </td>
        <td>
            <%=r.getChangeHidden("l_lohanka_do", "2", "2383")%>
                <%=r.getSizeInput("l_lohanka_do_how")%>
                <span class="ed_izm"> мм</span><br>
                <%=r.getCheckbox("l_verh_do")%><br>
                <%=r.getCheckbox("l_niz_do")%>
                <%=r.getSizeInput("l_niz_do_how")%>
                <span class="ed_izm"> мм</span><br>
                <%=r.getCheckbox("l_chls_do")%>
                <%=r.getSizeInput("l_chls_do_how")%>
                <span class="ed_izm"> мм</span>
            </div>
        </td>
    </tr>
    <tr> 
        <td colspan="3" class="simple_str"><b>Через</b>
            <%=r.getSizeInput("cherez_how")%>
            <span class="ed_izm"> мин</span>
            <b>после перорального приёма фуросемида (1-й позыв к микции):</b>
        </td>
    </tr>
    <tr> 
        <td class="simple_str">Правая лоханка
        </td>
        <td>
            <%=r.getSelect("r_lohanka_min")%>
        </td>
        <td>
            <%=r.getChangeHidden("r_lohanka_min", "3", "2383")%>
                <%=r.getSizeInput("r_lohanka_min_how")%>
                <span class="ed_izm"> мм</span><br>
                <%=r.getCheckbox("r_verh_min")%><br>
                <%=r.getCheckbox("r_niz_min")%>
                <%=r.getSizeInput("r_niz_min_how")%>
                <span class="ed_izm"> мм</span><br>
                <%=r.getCheckbox("r_chls_min")%>
                <%=r.getSizeInput("r_chls_min_how")%>
                <span class="ed_izm"> мм</span>
            </div>
        </td>
    </tr>
    <tr> 
        <td class="simple_str">Левая лоханка
        </td>
        <td>
            <%=r.getSelect("l_lohanka_min")%>
        </td>
        <td>
            <%=r.getChangeHidden("l_lohanka_min", "4", "2383")%>
                <%=r.getSizeInput("l_lohanka_min_how")%>
                <span class="ed_izm"> мм</span><br>
                <%=r.getCheckbox("l_verh_min")%><br>
                <%=r.getCheckbox("l_niz_min")%>
                <%=r.getSizeInput("l_niz_min_how")%>
                <span class="ed_izm"> мм</span><br>
                <%=r.getCheckbox("l_chls_min")%>
                <%=r.getSizeInput("l_chls_min_how")%>
                <span class="ed_izm"> мм</span>
            </div>
        </td>
    </tr>
    <tr> 
        <td colspan="3" class="simple_str"><b>После микции: </b>
        </td>
    </tr>
    <tr> 
        <td class="simple_str">Правая лоханка
        </td>
        <td>
            <%=r.getSelect("r_lohanka_mik")%>
        </td>
        <td>
            <%=r.getChangeHidden("r_lohanka_mik", "5", "2383")%>
                <%=r.getSizeInput("r_lohanka_mik_how")%>
                <span class="ed_izm"> мм</span><br>
                <%=r.getCheckbox("r_verh_mik")%><br>
                <%=r.getCheckbox("r_niz_mik")%>
                <%=r.getSizeInput("r_niz_mik_how")%>
                <span class="ed_izm"> мм</span><br>
                <%=r.getCheckbox("r_chls_mik")%>
                <%=r.getSizeInput("r_chls_mik_how")%>
                <span class="ed_izm"> мм</span>
            </div>
        </td>
    </tr>
    <tr> 
        <td class="simple_str">Левая лоханка
        </td>
        <td>
            <%=r.getSelect("l_lohanka_mik")%>
        </td>
        <td>
            <%=r.getChangeHidden("l_lohanka_mik", "6", "2383")%>
                <%=r.getSizeInput("l_lohanka_mik_how")%>
                <span class="ed_izm"> мм</span><br>
                <%=r.getCheckbox("l_verh_mik")%><br>
                <%=r.getCheckbox("l_niz_mik")%>
                <%=r.getSizeInput("l_niz_mik_how")%>
                <span class="ed_izm"> мм</span><br>
                <%=r.getCheckbox("l_chls_mik")%>
                <%=r.getSizeInput("l_chls_mik_how")%>
                <span class="ed_izm"> мм</span>
            </div>
        </td>
    </tr>
</Table>

<%@include file="footer.jsp"%>                  