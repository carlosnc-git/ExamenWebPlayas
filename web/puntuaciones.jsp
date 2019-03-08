<%-- 
    Document   : apuestas
    Created on : 11-feb-2019, 21:15:11
    Author     : carlos
--%>

<%@page import="entitites.Playa"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Playa playa = (Playa) request.getAttribute("playa");
    for (short i=1;i<=5;i++){
%>
<div class="row justify-content-md-center">
    <div class="col-md-auto"><img class="carita" src="img/ic_<%=i%>.png"/></div>
    <div class="col-md-auto"><%=playa.getVecesPuntuado(i)%></div>
</div>
<%}
%>
