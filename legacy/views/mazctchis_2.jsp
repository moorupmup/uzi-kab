
    <%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>

 
  <%if(!r.empty("mygh_"+count)){%>

<table width="100%" class="print">
    <tr><td width="50%" rowspan="1" align="center"> Реакция отделяемого</td> 
        <td width="50%" colspan="1" align="center"> Уретры</td> 
        
    </tr>
    

    <tr><td width="50%"> Лейкоциты </td> 
        <td width="50%" align="center"> <%=r.get("lllll_" + count)%></td> 
    </td>

       <tr><td width="50%"> Эпителий</td> 
        <td width="50%" align="center">         <%=r.get("epitelii_" + count)%></td>
  
   <%if(!r.empty("clizb_"+count)){%>
      
        <tr><td width="50%"> Слизь </td> 
        <td width="50%" align="center"> <%=r.get("clizb_" + count)%>  </td>
    </tr>

   <%}%>
     
<%if(!r.empty("eritrociti_"+count)){%> 
        <tr><td width="50%"> Эритроциты </td> 
        <td width="50%" align="center"> <%=r.get("eritrociti_" + count)%>  </td>
    </tr>
<%}%>

    <tr><td width="50%"> Гонококк Нейсера</td> 
        <td width="50%" align="center">         <%=r.get("siSAD_o_sr2_" + count)%></td>
            </tr>

     <tr><td width="50%"> Трихоманада</td> 
        <td width="50%" align="center">         <%=r.get("trihoman_o2_" + count)%></td>
        
    </tr>

      <tr><td width="50%"> Грам +/- коккобактерии </td> 
        <td width="50%" colspan="3" align="center"> <%=r.get("rerere2_" + count)%>  <%=r.get("aaaaa_" + count)%>  </td>
         </tr>  


    <tr><td width="50%"> Кокки </td> 
        <td width="50%" colspan="3" align="center"> <%=r.get("kokki_" + count)%> <%=r.get("bbbbb_" + count)%> </td>
         </tr>

    <tr><td width="50%"> Палочки </td> 
        <td width="50%" colspan="3" align="center"> <%=r.get("palochki2_" + count)%>  <%=r.get("ccccc_" + count)%></td>
         </tr>


     <tr><td width="50%"> Candida alb. </td> 
        <td width="50%" colspan="3" align="center"> <%=r.get("kandidi2_" + count)%> <%=r.get("ddddd_" + count)%>    </td>
         </tr>

     <tr><td width="50%"> Степень чистоты </td> 
        <td width="50%" colspan="3" align="left"> <%=r.get("stepen_chist2_" + count)%></td>
         </tr>

</table>
   
<%if(!r.empty("svobpole2_"+count)){%>
         <%=r.get("svobpole2_"+count)%><br><%}%>

<%}%>



 

<%if(r.empty("mygh_"+count)){%>

<table width="100%" class="print">
    <tr><td width="25%" rowspan="1" align="center"> Реакция отделяемого</td> 
        <td width="25%" colspan="1" align="center"> Уретры</td> 
        <td width="25%" colspan="1" align="center"> Шейки матки</td> 
        <td width="25%" colspan="1" align="center"> Вагины</td> 
    </tr>
    

    <tr><td width="25%"> Лейкоциты </td> 
        <td width="25%" align="center"> <%=r.get("leiko_yr_" + count)%></td> 
        <td width="25%" align="center"> <%=r.get("leiko_shei_" + count)%></td> 
        <td width="25%" align="center"> <%=r.get("leiko_vag_"+count)%></td> 
        
    </tr>


    <tr><td width="25%"> Эпителий</td> 
        <td width="25%" align="center"> <%=r.get("epi_yr_" + count)%></td> 
        <td width="25%" align="center"> <%=r.get("epi_shei_" + count)%></td> 
        <td width="25%" align="center"> <%=r.get("epi_vag_" + count)%></td> 
            </tr>


<%if(!r.empty("sliz_yr_"+count) || !r.empty("sliz_shei_"+count) || !r.empty("sliz_vag_"+count)){%>
            
    <tr><td width="25%"> Слизь </td> 
        <td width="25%" align="center"> <%=r.get("sliz_yr_" + count)%></td>
        <td width="25%" align="center"> <%=r.get("sliz_shei_" + count)%></td>
        <td width="25%" align="center"> <%=r.get("sliz_vag_" + count)%></td>
            </tr>
<%}%>

<%if(!r.empty("eri_yr_"+count) || !r.empty("eri_shei_"+count) || !r.empty("eri_vag_"+count)){%> 
        <tr><td width="25%"> Эритроциты </td> 
        <td width="25%" align="center"> <%=r.get("eri_yr_" + count)%>  </td>
        <td width="25%" align="center"> <%=r.get("eri_shei_" + count)%></td>
        <td width="25%" align="center"> <%=r.get("eri_vag_" + count)%></td>
            </tr>
<%}%>

    <tr><td width="25%"> Гонококк Нейсера</td> 
        <td width="25%" align="center">         <%=r.get("siSAD_o_sr_" + count)%></td>
        <td width="25%" align="center"> <%=r.get("siSAD_o_ma_" + count)%></td>
        <td width="25%" align="center"> <%=r.get("siSAD_o_mi_" + count)%></td>
            </tr>

     <tr><td width="25%"> Трихоманада</td> 
        <td width="25%" align="center">         <%=r.get("trihoman_o_" + count)%></td>
        <td width="25%" align="center"> <%=r.get("trihoman_a_" + count)%></td>
        <td width="25%" align="center"> <%=r.get("trihoman_e_" + count)%></td>
            </tr>

      <tr><td width="25%"> Грам +/- коккобактерии </td> 
        <td width="75%" colspan="3" align="center"> <%=r.get("rerere_" + count)%>  <%=r.get("aaa11_" + count)%>  </td>
         </tr>  


    <tr><td width="25%"> Кокки </td> 
        <td width="75%" colspan="3" align="center"> <%=r.get("siDAD_sr_" + count)%> <%=r.get("bbb11_" + count)%> </td>
         </tr>

    <tr><td width="25%"> Палочки </td> 
        <td width="75%" colspan="3" align="center"> <%=r.get("palochki_" + count)%>  <%=r.get("ccc11_" + count)%></td>
         </tr>


     <tr><td width="25%"> Candida alb. </td> 
        <td width="75%" colspan="3" align="center"> <%=r.get("kandidi_" + count)%> <%=r.get("ddd11_" + count)%>    </td>
         </tr>

     <tr><td width="25%"> Степень чистоты </td> 
        <td width="75%" colspan="3" align="left"> <%=r.get("stepen_chist_" + count)%></td>
         </tr>

 

</table>

   
<%if(!r.empty("svobpole_"+count)){%>
         <%=r.get("svobpole_"+count)%><br>
<%}%>


<%}%>



















