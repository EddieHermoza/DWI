<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Modelos.Usuario" %>
<%@ page import="Modelos.Cliente" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="DAO.UsuariosDAO" %>
<%

    Usuario u = (Usuario) session.getAttribute("usuario");
    if (u==null || u.getCorreo().isBlank() ) {
        response.sendRedirect("index.jsp");
        return;
    } 
    
    UsuariosDAO uDAO=new UsuariosDAO();
    Cliente c=uDAO.ObtenerCliente(u.getId());
%>
<jsp:include page="../Templates/Head.jsp"/> 
    <jsp:include page="Components/NavClient.jsp"/>
        <main>
        <section>
            <div class="h-[calc(100vh-70px)] w-full flex flex-col items-center justify-center relative p-5">
            <% if(c!=null) {%>
                    <h2 class="text-5xl text-white">Bienvenido, <%=c.getNombres() %></h2>
                    <div class="flex flex-col gap-5 mt-10">
                        <span class="text-3xl text-white">Información de cuenta</span>
                        <div class="flex flex-col gap-1">
                            <label for="" class="text-3xl text-[rgb(255,100,0)]">Nombres:</label>
                            <span class="text-4xl text-white"><%=c.getNombres() %></span>
                        </div>
                        <div class="flex flex-col gap-1">
                            <label for="" class="text-3xl text-[rgb(255,100,0)]">Apellidos:</label>
                            <span class="text-4xl text-white"><%= c.getApellidos() %></span>
                        </div>
                        <div class="flex flex-col gap-1">
                            <label for="" class="text-3xl text-[rgb(255,100,0)]">Correo Electrónico:</label>
                            <span class="text-4xl text-white"><%=c.getCorreo() %></span>
                        </div>
                        <div class="flex flex-col gap-1">
                            <label for="" class="text-3xl text-[rgb(255,100,0)]">Telefono:</label>
                            <span class="text-4xl text-white"><%=c.getTelefono() %></span>
                        </div>
                        <div class="flex flex-col gap-1">
                            <label for="" class="text-3xl text-[rgb(255,100,0)]">Puntos de menbresia:</label>
                            <span class="text-4xl text-white"><%=c.getPuntos() %></span>
                        </div>
                    </div>
            <% } %>
            </div>
        </section>
        </main>
        <jsp:include page="Components/ModalNav.jsp"/>
        <jsp:include page="Components/ModalCarrito.jsp"/>
        <jsp:include page="Components/ModalBuscador.jsp"/>
<jsp:include page="../Templates/Footer.jsp"/> 