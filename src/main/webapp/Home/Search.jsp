<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Modelos.Producto" %>
<%@ page import="DAO.ProductosDAO" %>
<%@ page import="java.util.ArrayList" %>
<%
    String keyword = request.getParameter("keyword");
    String url = request.getContextPath();
    
    ProductosDAO pDAO=new ProductosDAO();
    ArrayList<Producto> productos=pDAO.ListarPorBusqueda(keyword);
%>
<jsp:include page="../Templates/Head.jsp"/> 

    <jsp:include page="Components/NavClient.jsp"/>
    <main>
        <section class="pt-[50px]">
            <div class="flex flex-col items-center space-y-5 justify-center bg-black">
                <jsp:include page="Components/Glitch.jsp"/> 
                <p class="text-white text-center max-sm:text-2xl sm:text-3xl p-4">Resultados de la Busqueda de: "<span class="text-white max-sm:text-2xl sm:text-3xl"><%= keyword %></span>"</p>
                <form action="Search.jsp" method="post" class="flex justify-center w-full ">
                    <input type="text" class="outline-none bg-stone-900 border max-sm:w-4/5 sm:w-1/2  text-white focus:border-rojo-rgb transform duration-300 h-[40px] p-2" name="keyword">
                </form>
                <div class="flex flex-col items-center w-full max-w-[1200px] transition-all transform duration-300  min-h-[70vh] bg-stone-950">
                    <% if(productos.isEmpty())  {%>
                        <p class="text-2xl text-center text-white">No se encontraron resultados</p>
                    <%} else {%>
                        <% for(Producto produ : productos){ %>
                            <jsp:include page="Components/ProductoBusquedaCard.jsp">
                                <jsp:param name="nombre" value="<%= produ.getNombre() %>" />
                                <jsp:param name="precio" value="<%= produ.getPrecio() %>" />   
                                <jsp:param name="descripcion" value="<%= produ.getDescripcion() %>" />
                                <jsp:param name="url" value="<%= produ.getImg() %>"/>
                                <jsp:param name="id" value="<%= produ.getId() %>"/>
                            </jsp:include>
                        <% } %>
                    <% } %>
                </div>
            </div>
        </section>
        <jsp:include page="Components/SectionMembresia.jsp"/>
    </main>    
    <jsp:include page="Components/ModalNav.jsp"/>
    <jsp:include page="Components/ModalCarrito.jsp"/>
    <jsp:include page="Components/ModalBuscador.jsp"/>

<jsp:include page="../Templates/Footer.jsp"/> 
        