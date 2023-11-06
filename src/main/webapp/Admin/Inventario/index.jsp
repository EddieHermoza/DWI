<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="DAO.ProductosDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Modelos.Producto" %>
<%@ page import="Modelos.Usuario" %>
<%
    Usuario u = (Usuario) session.getAttribute("usuario");
    if (u == null || u.getRol().equals("cliente")) {
        response.sendRedirect("../../Home/index.jsp");
    } 
%>
<% 
    ProductosDAO produDAO = new ProductosDAO();
    ArrayList<Producto> productos = produDAO.Listar();
%>
<jsp:include page="../../Templates/Head.jsp"/> 

    <jsp:include page="../Components/NavAdmin.jsp"/> 
    
    <main class="relative w-full flex min-h-[1000px]">
        <jsp:include page="../Components/BarraLateral.jsp"/>
        <section class="w-full max-sm:overflow-x-hidden">
            <div class="relative h-full w-full bg-[rgb(20,20,20)] flex flex-col p-5 gap-10">
                <h2 class="max-sm:text-4xl sm:text-5xl text-white">Inventario</h2>
                <div class="w-full relative flex justify-center">
                    <div class="flex relative w-full overflow-x-auto scrollbar-thin scrollbar-track-black scrollbar-thumb-orange-600">
                        <div class="relative w-full">
                            <table class="w-full text-center max-sm:text-xs sm:text-base">
                                <thead class="border-b bg-neutral-800 text-white">
                                    <tr>
                                        <th scope="col" class=" p-5">ID</th>
                                        <th scope="col" class=" p-5">Nombre</th>
                                        <th scope="col" class=" p-5">Cantidad restante</th>
                                        <th scope="col" class=" p-5">Acciones</th>
                                    </tr>
                                </thead>
                                <tbody class="text-white">
                                <%  if (productos.isEmpty()) {  %>
                                    <tr>
                                        <td colspan="9" class="p-5">No se han registrado Productos</td>
                                    </tr>
                                 <% } else {
                                        for (Producto producto : productos) { %>
                                        <tr class="border-b hover:bg-black transform duration-200">
                                            <td class="px-2 truncate"><%= producto.getId() %></td>
                                            <td class="px-2 truncate max-w-[300px]"><%= producto.getNombre() %></td>
                                            <td class="px-2 truncate"><%= producto.getCantidad() %></td>
                                            <td class="flex gap-2 p-2 justify-center">
                                                <form action="../../ctrlInventario" method="post"  class="flex max-sm:flex-col sm:flex-row justify-center gap-2">
                                                    <input type="hidden" name="idProducto" value="<%= producto.getId() %>">
                                                    <input type="number" name="cantidadProducto" min="0" max="100" step="1" required class="outline-none pl-1 py-1 w-[140px] border bg-stone-950 text-white">
                                                    <button type="submit" name="Agregar" class="cursor-pointer bg-cyan-300 px-5 py-1 rounded-tl-lg rounded-br-lg text-black filter hover:saturate-200"><i class="fa-solid fa-plus"></i> Agregar</button>
                                                    <button type="submit" name="Quitar" class="cursor-pointer bg-red-500 px-5 py-1 rounded-br-lg rounded-tl-lg text-white filter hover:saturate-200"><i class="fa-solid fa-minus"></i> Quitar</button>
                                                </form>
                                            </td>
                                        </tr>
                                    <% }
                                    }
                                    %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </section> 
    </main>
    <jsp:include page="../Components/ModalNav.jsp"/>
<jsp:include page="../../Templates/Footer.jsp"/> 
