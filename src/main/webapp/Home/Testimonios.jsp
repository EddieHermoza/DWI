<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="DAO.ComentariosDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Modelos.Comentario" %>
<%@ page import="Modelos.Usuario" %>

<%

    ComentariosDAO cdao= new ComentariosDAO();
    ArrayList<Comentario> Comentarios =cdao.ListarComentarios();
%>
<jsp:include page="../Templates/Head.jsp"/> 
    <jsp:include page="Components/NavClient.jsp"/>
    <main>
        <section class="mt-[100px]">
            <h2 class="text-5xl text-white px-5 mb-5">Reseñas y Comentarios.</h2>
            <div class="grid max-xl:grid-cols-1 xl:grid-cols-2 grid-flow-row gap-8 w-full p-5">
                <% if(Comentarios.isEmpty()){  %>
                    <span class="max-lg:text-3xl lg:text-5xl sm:col-span-2 xl:col-span-3 text-center text-white p-2">No hay Comentarios :[</span>
                <% } else { %>
                    <% for ( Comentario c : Comentarios){   %>
                    <jsp:include page="Components/TestimonioCard.jsp">      
                        <jsp:param name="usuario" value="<%=c.getNombreCliente() %>" />          
                        <jsp:param name="comentario" value="<%=c.getMensaje() %>" />
                        <jsp:param name="img" value="<%=c.getProductoURL() %>"/>
                        <jsp:param name="fecha" value="<%=c.getFecha() %>"/>
                        <jsp:param name="calificacion" value="<%=c.getCalificacion() %>"/>
                        <jsp:param name="idproducto" value="<%=c.getProducto() %>"/>
                    </jsp:include>
                    <% } %>
                <% } %>
            </div>
        </section>
        <jsp:include page="Components/SectionMembresia.jsp"/> 
    </main>
    <jsp:include page="Components/ModalNav.jsp"/>
    <jsp:include page="Components/ModalCarrito.jsp"/>
    <jsp:include page="Components/ModalBuscador.jsp"/>

<jsp:include page="../Templates/Footer.jsp"/> 
