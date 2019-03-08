/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import entitites.Ccaa;
import entitites.Municipio;
import entitites.Playa;
import entitites.Provincia;
import entitites.Punto;
import entitites.Usuario;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.Query;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import jpautil.JPAUtil;

/**
 *
 * @author Diurno
 */
public class Controller extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        RequestDispatcher dispatcher;
        String op;
        String sql;
        EntityTransaction transaction;
        Query query;
        List<Ccaa> comunidades;
        Short idComunidad;
        Ccaa comunidad;
        List<Provincia> provincias;
        Short idProvincia;
        Provincia provincia;
        List<Municipio> municipios;
        int idMunicipio;
        Municipio municipio;
        int idPlaya;
        Playa playa;
        short rating;
        Usuario usuario;
        EntityManager em = (EntityManager) session.getAttribute("em");
        if (em == null) {
            em = JPAUtil.getEntityManagerFactory().createEntityManager();
            session.setAttribute("em", em);
        }
        op = request.getParameter("op");
        switch (op) {
            case "inicio":
                sql = "select ca from Ccaa ca";
                query = em.createQuery(sql);
                comunidades = query.getResultList();
                session.setAttribute("comunidades", comunidades);
                session.setAttribute("provincias", null);
                session.setAttribute("municipios", null);
                session.setAttribute("comunidadSeleccionada", null);
                session.setAttribute("provinciaSeleccionada", null);
                session.setAttribute("municipioSeleccionado", null);
                session.setAttribute("usuario", null);
                dispatcher = request.getRequestDispatcher("home.jsp");
                dispatcher.forward(request, response);
                break;
            case "dameComunidad":
                idComunidad = Short.parseShort(request.getParameter("comboComunidades"));
                if (idComunidad == -1) {
                    session.setAttribute("provincias", null);
                    session.setAttribute("comunidadSeleccionada", null);
                } else {
                    comunidad = em.find(Ccaa.class, idComunidad);
                    session.setAttribute("provincias", comunidad.getProvinciaList());
                    session.setAttribute("comunidadSeleccionada", comunidad);
                }
                session.setAttribute("municipios", null);
                dispatcher = request.getRequestDispatcher("home.jsp");
                dispatcher.forward(request, response);
                break;
            case "dameProvincia":
                idProvincia = Short.parseShort(request.getParameter("comboProvincias"));
                if (idProvincia == -1) {
                    session.setAttribute("municipios", null);
                    session.setAttribute("provinciaSeleccionada", null);
                } else {
                    provincia = em.find(Provincia.class, idProvincia);
                    session.setAttribute("municipios", provincia.getMunicipioList());
                    session.setAttribute("provinciaSeleccionada", provincia);
                }
                dispatcher = request.getRequestDispatcher("home.jsp");
                dispatcher.forward(request, response);
                break;
            case "dameMunicipio":
                idMunicipio = Integer.parseInt(request.getParameter("comboMunicipios"));
                if (idMunicipio == -1) {
                    session.setAttribute("municipioSeleccionado", null);
                } else {
                    municipio = em.find(Municipio.class, idMunicipio);
                    session.setAttribute("municipioSeleccionado", municipio);
                }
                dispatcher = request.getRequestDispatcher("home.jsp");
                dispatcher.forward(request, response);
                break;
            case "info":
                idPlaya = Integer.parseInt(request.getParameter("idPlaya"));
                playa = em.find(Playa.class, idPlaya);
                em.refresh(playa);
                request.setAttribute("playa", playa);
                dispatcher = request.getRequestDispatcher("puntuaciones.jsp");
                dispatcher.forward(request, response);
                break;
            case "detalle":
                idPlaya = Integer.parseInt(request.getParameter("idPlaya"));
                playa = em.find(Playa.class, idPlaya);
                request.setAttribute("playa", playa);
                dispatcher = request.getRequestDispatcher("detalle.jsp");
                dispatcher.forward(request, response);
                break;
            case "rating":
                rating = Short.parseShort(request.getParameter("rating"));
                idPlaya = Integer.parseInt(request.getParameter("idPlaya"));
                usuario = (Usuario) session.getAttribute("usuario");
                Punto punto = new Punto();
                punto.setId(3);
                punto.setPlaya(em.find(Playa.class, idPlaya));
                punto.setPuntos(rating);
                punto.setUsuario(usuario);
                transaction = em.getTransaction();
                transaction.begin();
                em.persist(punto);
                transaction.commit();
                em.getEntityManagerFactory().getCache().evictAll();
                playa = em.find(Playa.class, idPlaya);
                em.refresh(playa);
                dispatcher = request.getRequestDispatcher("home.jsp");
                dispatcher.forward(request, response);
                break;
            case "login":
                String nick = (String) request.getParameter("nick");
                String password = (String) request.getParameter("password");
                sql = String.format("select u from Usuario u where u.nick='%s'", nick);
                query = em.createQuery(sql);
                usuario = null;
                List<Usuario> lista = query.getResultList();
                if (lista.size()==0) {
                    usuario = new Usuario((short)0);
                    usuario.setNick(nick);
                    usuario.setPuntoList(new ArrayList<>());
                    usuario.setPass(password);
                    EntityTransaction et = em.getTransaction();
                    et.begin();
                    em.persist(usuario);
                    et.commit();
                } else if(lista.get(0).getNick().equals(nick) && lista.get(0).getPass().equals(password)){
                    usuario = lista.get(0);
                }
                session.setAttribute("usuario", usuario);
                dispatcher = request.getRequestDispatcher("home.jsp");
                dispatcher.forward(request, response);
                break;
            case "logout":
                usuario = null;
                session.setAttribute("usuario", usuario);
                dispatcher = request.getRequestDispatcher("home.jsp");
                dispatcher.forward(request, response);
                break;
            default:
                break;
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
