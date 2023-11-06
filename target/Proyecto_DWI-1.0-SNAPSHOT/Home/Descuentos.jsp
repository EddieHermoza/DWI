<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="DAO.ProductosDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Modelos.Producto" %>
<%
    ProductosDAO produDAO = new ProductosDAO();
    ArrayList<Producto> productos=produDAO.ListarDisponibles();
    int cont=0;
%>
<jsp:include page="../Templates/Head.jsp"/> 
    <jsp:include page="Components/NavClient.jsp"/>
    <main>
        <section class="mt-[100px]">
            <h2 class="text-5xl mb-5 text-white px-5">Productos en Descuento</h2>
            <p class="text-xl text-slate-400 px-5 mb-5">Con descuentos tan bajos que te harán cuestionar la realidad.</p>
            <div class="flex flex-wrap items-center justify-center gap-10 max-sm:px-0 sm:px-10 transition-all duration-300">
                <% if(productos.isEmpty()){%>
                <span class="text-4xl text-white text-center">No hay Productos en Descuento :[</span>
                <% } else {%>
                    <% for(Producto produ : productos){ %>
                        <% if(produ.getDescuento()>0) {%>
                            <jsp:include page="Components/ProductoDescuentoCard.jsp">
                                <jsp:param name="nombre" value="<%= produ.getNombre() %>" />
                                <jsp:param name="precio" value="<%= produ.getPrecio() %>" />   
                                <jsp:param name="descripcion" value="<%= produ.getDescripcion() %>" />
                                <jsp:param name="url" value="<%= produ.getImg() %>"/>
                                <jsp:param name="id" value="<%= produ.getId() %>"/>
                                <jsp:param name="ahorro" value="<%= produ.Ahorro() %>"/>
                                <jsp:param name="descuento" value="<%= produ.PrecioConDescuento() %>"/>
                                <jsp:param name="porcentaje" value="<%= produ.DescuentoPorcentaje() %>"/>
                            </jsp:include>
                            <% cont++; %>
                        <% } %>
                    <% } %>
                    <% if(cont==0) { %>
                        <span class="max-md:text-3xl md:text-5xl text-white flex items-center justify-center h-[500px]">No hay Productos en Descuento :[</span>
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
