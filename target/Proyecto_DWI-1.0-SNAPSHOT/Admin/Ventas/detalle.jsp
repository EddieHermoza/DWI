<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="DAO.DetalleVentasDAO" %>
<%@ page import="Modelos.Venta_Detalle" %>
<%@ page import="Modelos.Usuario" %>
<%
    Usuario u = (Usuario) session.getAttribute("usuario");
    if (u == null || u.getRol().equals("cliente")) {
        response.sendRedirect("../../Home/index.jsp");
    } 
%>

<% 
    int id = Integer.parseInt(request.getParameter("id"));
    DetalleVentasDAO vdDAO = new DetalleVentasDAO();
    ArrayList<Venta_Detalle> detalles = vdDAO.ListarDetalle(id);
%>
<jsp:include page="../../Templates/Head.jsp"/> 
    <jsp:include page="../Components/NavAdmin.jsp"/>  
    <main class="relative w-full flex min-h-[1000px]">
        <jsp:include page="../Components/BarraLateral.jsp"/>
        <section class="w-full max-sm:overflow-x-hidden">
            <div class="relative h-full w-full bg-[rgb(20,20,20)] flex flex-col p-5 gap-10">
                <div class="flex items-center justify-between">
                    <h2 class="text-5xl text-white">Detalle de la Venta <%= id%></h2> 
                </div>
                <div class="w-full relative flex justify-center">
                    <div class="flex relative w-full overflow-x-auto scrollbar-thin scrollbar-track-black scrollbar-thumb-orange-600">
                        <div class="relative w-full">
                            <table class="w-full text-center max-sm:text-xs sm:text-base">
                                <thead class="border-b bg-neutral-800 text-white">
                                    <tr>
                                        <th scope="col" class=" p-5">ID</th>
                                        <th scope="col" class=" p-5">Venta</th>
                                        <th scope="col" class=" p-5">Producto</th>
                                        <th scope="col" class=" p-5">Cantidad</th>
                                        <th scope="col" class=" p-5">Precio unitario</th>
                                        <th scope="col" class=" p-5">Descuento unitario</th>
                                        <th scope="col" class=" p-5">Subtotal</th>
                                    </tr>
                                </thead>
                                <tbody class="text-white">
                                <%  if (detalles.isEmpty() || detalles == null) {  %>
                                    <tr>
                                        <td colspan="9" class="p-5">No se registraron detalles</td>
                                    </tr>
                                 <% } else {
                                        for (Venta_Detalle detalle : detalles) { %>
                                        <tr class="border-b hover-bg-black transform duration-200">
                                            <td class="p-2 truncate"><%= detalle.getId() %></td>
                                            <td class="p-2 truncate max-w-[200px]"><%= detalle.getVenta() %></td>
                                            <td class="p-2 truncate max-w-[200px]"><%= detalle.getProducto() %></td>
                                            <td class="p-2 truncate max-w-[200px]"><%= detalle.getCantidad() %></td>
                                            <td class="p-2 truncate max-w-[200px]">$/<%= detalle.getMonto_unit() %></td>
                                            <td class="p-2 truncate max-w-[200px]">$/<%= detalle.getDesc_aplicado() %></td>
                                            <td class="p-2 truncate max-w-[200px]"><%= detalle.getSubtotal() %></td>
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