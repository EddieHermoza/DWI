<%@ page import="Modelos.Usuario" %>
<%@ page import="Modelos.Carro" %>
<%@ page import="java.util.ArrayList" %>
<%

    Carro carro = new Carro();
    session.setAttribute("carro",carro);

    Usuario u = (Usuario) session.getAttribute("usuario");

    if (u != null) {
        if ("cliente".equals(u.getRol())) {
            response.sendRedirect("Home/index.jsp");
        } else if ("administrador".equals(u.getRol())) {
            response.sendRedirect("Admin/index.jsp");
        }
    } else{
        response.sendRedirect("Home/index.jsp");
    }
%>