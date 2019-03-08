<%-- 
    Document   : home
    Created on : 11-feb-2019, 11:23:44
    Author     : carlos
--%>

<%@page import="entitites.Usuario"%>
<%@page import="entitites.Municipio"%>
<%@page import="entitites.Provincia"%>
<%@page import="entitites.Playa"%>
<%@page import="entitites.Ccaa"%>
<%@page import="java.io.Console"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="es" dir="ltr">

    <head>
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Compiled and minified CSS -->
        <link rel="stylesheet" href="css/mycss.css">
        <title>Chistes</title>
    </head>
    <%
        List<Ccaa> comunidades = (List<Ccaa>) session.getAttribute("comunidades");
        Ccaa comunidadSeleccionada = (Ccaa) session.getAttribute("comunidadSeleccionada");
        List<Provincia> provincias = (List<Provincia>) session.getAttribute("provincias");
        Provincia provinciaSeleccionada = (Provincia) session.getAttribute("provinciaSeleccionada");
        List<Municipio> municipios = (List<Municipio>) session.getAttribute("municipios");
        Municipio municipioSeleccionado = (Municipio) session.getAttribute("municipioSeleccionado");
        List<Playa> playas = null;
        if (municipioSeleccionado != null) {
            playas = municipioSeleccionado.getPlayaList();
        }
        Usuario usuario = (Usuario) session.getAttribute("usuario");

    %>
    <body>

        <!-- Contenedor principal-->
        <div class="container shadow">
            <div id="header">
                <nav class="navbar navbar-expand-md navbar-dark bg-primary cabecera">
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        <ul class="navbar-nav ml-auto" id="menu">
                            <li class="nav-item active">
                                <%if (usuario != null) {
                                %>
                                <form action="Controller?op=logout" method="post">
                                    <label class="text-white"><%=usuario.getNick()%></label>                                
                                    <button type="submit" class="btn btn-danger" >LOGOUT</button>
                                </form>
                                <%
                                } else {
                                %>
                                <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#exampleModal">LOGIN & REGISTER</button>
                                <%}%>


                            </li>
                        </ul>
                    </div>
                </nav>
            </div>
            <div class="buscador">
                <form class="form-inline" action="Controller?op=dameComunidad" method="post" style="display: inline-block" >
                    <div class="form-group">
                        <section>
                            <label for="#comboComunidades" class="inputlabel">CCAA</label>
                            <select class="custom-select inputlabel" id="comboComunidades" name="comboComunidades" onchange="this.form.submit()" style="width: 200px">
                                <%if (comunidadSeleccionada == null) {
                                %>
                                <option selected value="-1">Elija Comunidad</option>
                                <%} else {%>
                                <option value="-1">Elija Comunidad</option>
                                <%}
                                    for (Ccaa ca : comunidades) {%>            
                                <option <%=(comunidadSeleccionada != null && comunidadSeleccionada.getId() == ca.getId()) ? "selected" : ""%> value="<%=ca.getId()%>"><%=ca.getNombre()%></option>      
                                <%}%>
                            </select>
                        </section>
                    </div>
                </form>
                <form class="form-inline" action="Controller?op=dameProvincia" method="post" style="display: inline-block">
                    <div class="form-group">
                        <section>
                            <label for="#comboProvincias" class="inputlabel">PROVINCIAS</label>
                            <select class="custom-select inputlabel" id="comboProvincias" name="comboProvincias" onchange="this.form.submit()" style="width: 200px" <%=(comunidadSeleccionada == null) ? "disabled" : ""%>>
                                <%if (provinciaSeleccionada == null) {
                                %>
                                <option selected value="-1">Elija Provincia</option>
                                <%} else {%>
                                <option value="-1">Elija Provincia</option>
                                <%}
                                    if (provincias != null)
                                        for (Provincia prov : provincias) {%>            
                                <option <%=(provinciaSeleccionada != null && provinciaSeleccionada.getId() == prov.getId()) ? "selected" : ""%> value="<%=prov.getId()%>"><%=prov.getNombre()%></option>      
                                <%}%>
                            </select>
                        </section>
                    </div>
                </form>
                <form class="form-inline" action="Controller?op=dameMunicipio" method="post" style="display: inline-block">
                    <div class="form-group">
                        <section>
                            <label for="#comboMunicipios" class="inputlabel">MUNICIPIO</label>
                            <select class="custom-select" id="comboMunicipios" name="comboMunicipios" onchange="this.form.submit()" style="width: 200px" <%=(provinciaSeleccionada == null) ? "disabled" : ""%>>
                                <%if (municipioSeleccionado == null) {
                                %>
                                <option selected value="-1">Elija Municipio</option>
                                <%} else {%>
                                <option value="-1">Elija Municipio</option>
                                <%}
                                    if (municipios != null)
                                        for (Municipio mun : municipios) {%>            
                                <option <%=(municipioSeleccionado != null && municipioSeleccionado.getId() == mun.getId()) ? "selected" : ""%> value="<%=mun.getId()%>"><%=mun.getNombre()%></option>      
                                <%}%>
                            </select>
                        </section>
                    </div>
                </form>


            </div>
            <% if (playas == null) {%>
            <h3 class="sinplayas">Playas Carlos Navas</h3>
            <%} else { %>
            <div class="playas">
                <%for (Playa playa : playas) {%>
                <div class="row playa">
                    <div class="col-md-auto">
                        <img class="playaimagen" src="http://playas.chocodev.com/images/<%=playa.getId()%>_<%=playa.getImagesList().get(0).getId()%>.jpg">
                    </div>
                    <div class="col col-md-10">
                        <h3><%=playa.getNombre()%></h3>
                        <h6><%=playa.getDescripcion()%></h6>
                        <%if (usuario!=null) {%>
                        <div class="row justify-content-md-center">
                            <button class="btn btn-primary" data-toggle="modal" data-target="#modalInfo" data-id="<%=playa.getId()%>" style="margin-right: 15px;">Info</button>
                            <a class="btn btn-primary" href="Controller?op=detalle&idPlaya=<%=playa.getId() %>">Calificar</a>                            
                        </div>
                        <%}%>
                    </div>
                </div>
                <%}%>

            </div>
            <%}%>
        </div>
        <div class="modal fade" id="modalInfo" tabindex="-1" role="dialog" aria-labelledby="modalInfo" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body text-center" id="modalinfopuntuaciones">
                        <!-- Rellenar con AJAX  -->
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary " data-dismiss="modal">Aceptar</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Login & Register</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form action="Controller?op=login" method="post">
                        <div class="modal-body">                        
                            <div class="form-group">
                                <input type="text" class="form-control" id="nick" name="nick" aria-describedby="nickHelp" placeholder="Nick">
                            </div>
                            <div class="form-group">
                                <input type="password" class="form-control" id="password" name="password" placeholder="Contraseña">
                            </div>                        
                        </div>
                        <button type="submit" class="btn btn-primary">LOGIN or REGISTER</button>&nbsp
                        <button type="button" class="btn btn-danger" data-dismiss="modal">CANCEL</button>
                    </form>
                </div>
            </div>
        </div>  

        <script src="js/jquery-3.3.1.slim.min.js"></script>
        <script src="js/jquery-1.12.4.js"></script>
        <script src="js/jquery-ui.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/myjs.js"></script>
    </body>
</html>