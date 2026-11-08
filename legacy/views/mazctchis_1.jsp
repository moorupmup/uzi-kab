
    <%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>


 



<table width="100%" class="print">
    <tr><td width="25%" rowspan="1" align="center"> Реакция отделяемого</td> 
        <td width="25%" colspan="1" align="center"> Уретры</td> 
        <td width="25%" colspan="1" align="center"> Шейки матки</td> 
        <td width="25%" colspan="1" align="center"> Вагины</td> 
    </tr>
    

    <tr><td width="25%"> Лейкоциты </td> 
        <td width="25%" align="center"> <%=r.get("sistAD_o_sr_" + count)%></td> 
        <td width="25%" align="center"> <%=r.get("sistAD_o_mi_" + count)%></td> 
        <td width="25%" align="center"> <%=r.get("sistAD_o_ma_" + count)%></td> 
        
    </tr>


    <tr><td width="25%"> Эпителий</td> 
        <td width="25%" align="center"> <%=r.get("diastAD_o_sr_" + count)%></td> 
        <td width="25%" align="center"> <%=r.get("diastAD_o_mi_" + count)%></td> 
        <td width="25%" align="center"> <%=r.get("diastAD_o_ma_" + count)%></td> 
            </tr>


<%if(!r.empty("ivSAD_o_sr_"+count) || !r.empty("ivSAD_o_mi_"+count) || !r.empty("ivSAD_o_ma_"+count)){%>
            
    <tr><td width="25%"> Слизь </td> 
        <td width="25%" align="center"> <%=r.get("ivSAD_o_sr_" + count)%></td>
        <td width="25%" align="center"> <%=r.get("ivSAD_o_mi_" + count)%></td>
        <td width="25%" align="center"> <%=r.get("ivSAD_o_ma_" + count)%></td>
            </tr>
<%}%>

<%if(!r.empty("ivDAD_o_sr_"+count) || !r.empty("ivDAD_o_mi_"+count) || !r.empty("ivDAD_o_ma_"+count)){%> 
        <tr><td width="25%"> Эритроциты </td> 
        <td width="25%" align="center"> <%=r.get("ivDAD_o_sr_" + count)%>  </td>
        <td width="25%" align="center"> <%=r.get("ivDAD_o_mi_" + count)%></td>
        <td width="25%" align="center"> <%=r.get("ivDAD_o_ma_" + count)%></td>
            </tr>
<%}%>

    <tr><td width="25%"> Гонококк Нейсера</td> 
        <td width="25%" align="center">         <%=r.get("siSAD_o_sr_" + count)%></td>
        <td width="25%" align="center"> <%=r.get("siSAD_o_mi_" + count)%></td>
        <td width="25%" align="center"> <%=r.get("siSAD_o_ma_" + count)%></td>
            </tr>

     <tr><td width="25%"> Трихоманада</td> 
        <td width="25%" align="center">         <%=r.get("trihoman_o_" + count)%></td>
        <td width="25%" align="center"> <%=r.get("trihoman_a_" + count)%></td>
        <td width="25%" align="center"> <%=r.get("trihoman_e_" + count)%></td>
            </tr>

      <tr><td width="25%"> Грам +/- коккобактерии </td> 
        <td width="75%" colspan="3" align="center"> <%=r.get("rerere_" + count)%>  <%=r.get("aaa_" + count)%>  </td>
         </tr>  


    <tr><td width="25%"> Кокки </td> 
        <td width="75%" colspan="3" align="center"> <%=r.get("siDAD_sr_" + count)%> <%=r.get("bbb_" + count)%> </td>
         </tr>

    <tr><td width="25%"> Палочки </td> 
        <td width="75%" colspan="3" align="center"> <%=r.get("palochki_" + count)%>  <%=r.get("ccc_" + count)%></td>
         </tr>


     <tr><td width="25%"> Candida alb. </td> 
        <td width="75%" colspan="3" align="center"> <%=r.get("kandidi_" + count)%> <%=r.get("ddd_" + count)%>    </td>
         </tr>

     <tr><td width="25%"> Степень чистоты </td> 
        <td width="75%" colspan="3" align="left"> <%=r.get("stepen_chist_" + count)%></td>
         </tr>

  

</table>
   
<%if(!r.empty("svobpole_"+count)){%>
         <%=r.get("svobpole_"+count)%><br>
<%}%>




