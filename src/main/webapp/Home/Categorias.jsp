<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="DAO.CategoriasDAO" %>
<%@ page import="DAO.ProductosDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Modelos.Categoria" %>
<%@ page import="Modelos.Producto" %>

<%
    int id = Integer.parseInt(request.getParameter("id"));

    String url = request.getContextPath();

    CategoriasDAO cDAO = new CategoriasDAO();
    Categoria cate = cDAO.ObtenerCategoria(id);

    ProductosDAO produDAO = new ProductosDAO();
    ArrayList<Producto> productos=produDAO.ListarPorCategoria(id);
%>
<jsp:include page="../Templates/Head.jsp"/> 

        <jsp:include page="Components/NavClient.jsp"/>

        <main> 
            <jsp:include page="Components/PortadaDinamica.jsp">
                <jsp:param name="url" value="<%= cate.getBannerRef() %>" />
            </jsp:include>
            <section class="relative h-full">
                <div class="flex sticky z-10 top-[40px] flex-col bg-black items-center h-[20vh] space-y-3 justify-center w-full">
                    <h2 class="max-sm:text-3xl sm:text-5xl text-white text-center"><%= cate.getNombre() %></h2>
                    <p class="max-sm:text-xs sm:text-base md:text-xl text-slate-400 text-center  md:w-5/6 lg:w-3/5"><%= cate.getDesc() %></p>
                </div>
                <div class="flex relative justify-center w-full">
                    <div class="bg-black relative grid max-md:grid-cols-1 md:grid-cols-2 gap-2 xl:grid-cols-3 grid-flow-row justify-center max-lg:w-full lg:w-[70%] min-h-screen">
                        <% if(productos.isEmpty()){ %>
                            <span class="max-lg:text-3xl lg:text-5xl sm:col-span-2 xl:col-span-3 text-center text-white p-2">No hay Productos disponibles de la categoria <%= cate.getNombre() %> :[</span>
                        <%}else{%>    
                            <% for (Producto produ : productos) { %>
                                <jsp:include page="Components/ProductoCard.jsp">
                                    <jsp:param name="nombre" value="<%= produ.getNombre() %>" />
                                    <jsp:param name="precio" value="<%= produ.getPrecio() %>" />   
                                    <jsp:param name="descripcion" value="<%= produ.getDescripcion() %>" />
                                    <jsp:param name="url" value="<%= produ.getImg() %>"/>
                                    <jsp:param name="id" value="<%= produ.getId() %>"/>
                                    <jsp:param name="descuento" value="<%= produ.DescuentoPorcentaje() %>"/>
                                </jsp:include>
                            <% } %>
                        <%}%>   
                    </div>
                </div>
            </section>
        </main>
        <jsp:include page="Components/ModalNav.jsp"/>
        <jsp:include page="Components/ModalCarrito.jsp"/>
        <jsp:include page="Components/ModalBuscador.jsp"/>

<jsp:include page="../Templates/Footer.jsp"/> 


