<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="DAO.ProductosDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Modelos.Producto" %>
<%
    ProductosDAO produDAO = new ProductosDAO();
    ArrayList<Producto> productos=produDAO.ProductosMasVendidos();
    int cont=0;
%>
<jsp:include page="../Templates/Head.jsp"/> 
    <jsp:include page="Components/NavClient.jsp"/>
    <main>
        <section class="mt-[100px] flex flex-col items-center">
            <h2 class="text-5xl mb-5 text-white px-5 text-center w-full">Productos Mas Vendidos</h2>
            <p class="text-xl text-slate-400 px-5 mb-5 w-full text-center">Productos que, sorprendentemente, otros clientes también están comprando.</p>
            <div class=" w-full max-w-[1200px] grid max-md:grid-cols-1 md:grid-cols-2 grid-flow-row justify-center max-sm:px-5 sm:px-10 transition-all duration-300 gap-5">
                <% if(productos.isEmpty()){%>
                <span class="text-4xl text-white text-center">No hay Productos Disponibles en este momento :[</span>
                <% } else { %>
                    <% for(Producto produ : productos){ %>
                            <jsp:include page="Components/UltimosProductosCard.jsp">
                                <jsp:param name="nombre" value="<%= produ.getNombre() %>" />
                                <jsp:param name="precio" value="<%= produ.getPrecio() %>" />   
                                <jsp:param name="descripcion" value="<%= produ.getDescripcion() %>" />
                                <jsp:param name="url" value="<%= produ.getImg() %>"/>
                                <jsp:param name="id" value="<%= produ.getId() %>"/>
                                <jsp:param name="descuento" value="<%= produ.DescuentoPorcentaje() %>"/>
                            </jsp:include>
                            <% cont++; %>
                    <% } %>
                    <% if(cont==0) { %>
                        <span class="max-md:text-3xl md:text-5xl text-white flex items-center justify-center h-[500px]">No hay Productos Disponibles en este momento :[</span>
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
