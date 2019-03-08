<%-- 
    Document   : detalle
    Created on : 08-mar-2019, 10:58:43
    Author     : Diurno
--%>

<%@page import="entitites.Usuario"%>
<%@page import="entitites.Images"%>
<%@page import="entitites.Playa"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es" dir="ltr">

    <head>
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Compiled and minified CSS -->
        <link rel="stylesheet" href="css/mycss.css">
        <title>Detalle</title>
    </head>
    <%
        Playa playa = (Playa) request.getAttribute("playa");
        Usuario usuario = (Usuario) session.getAttribute("usuario");
    %>
    <body>
        <!-- Contenedor principal-->
        <div class="container shadow">            
            <div id="miCarrusel" class="carousel slide centrado" data-ride="carousel" style="width: 300px">
                <div class="carousel-inner">
                    <%  int i = 0;
                        for (Images imagen : playa.getImagesList()) {
                            if (i == 0) {%>
                    <div class="carousel-item active">
                        <img class="d-block w-100" src="<%=imagen.getUrl()%>" /> 
                    </div>
                    <%} else {
                    %>
                    <div class="carousel-item">
                        <img class="d-block w-100" src="<%=imagen.getUrl()%>"  /> 
                    </div>
                    <%}
                        i++;}%>
                </div>
                <a class="carousel-control-prev" href="#miCarrusel" role="button" data-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="carousel-control-next" href="#miCarrusel" role="button" data-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>
            <h4><%=playa.getNombre()%></h4>
            <p><%=playa.getDescripcion()%></p>
            <h5>Municipio: <%=playa.getMunicipio().getNombre()%></h5>
            <h5>Provincia: <%=playa.getMunicipio().getProvincia().getNombre()%></h5>
            <h5>Comunidad autónoma: <%=playa.getMunicipio().getProvincia().getCcaa().getNombre()%></h5>
            <div class="row justify-content-center">
            <span class="rating ">
                <a href="Controller?op=rating&rating=1&idPlaya=<%=playa.getId()%>"><img class="carita" src="img/ic_1.png"/></a>
                <a href="Controller?op=rating&rating=2&idPlaya=<%=playa.getId()%>"><img class="carita" src="img/ic_2.png"/></a>
                <a href="Controller?op=rating&rating=3&idPlaya=<%=playa.getId()%>"><img class="carita" src="img/ic_3.png"/></a>
                <a href="Controller?op=rating&rating=4&idPlaya=<%=playa.getId()%>"><img class="carita" src="img/ic_4.png"/></a>
                <a href="Controller?op=rating&rating=5&idPlaya=<%=playa.getId()%>"><img class="carita" src="img/ic_5.png"/></a>
            </span>
            </div>
        </div>
        <script src="js/jquery-3.3.1.slim.min.js"></script>
        <script src="js/jquery-1.12.4.js"></script>
        <script src="js/jquery-ui.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/myjs.js"></script>
    </body>
</html>
