<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="DAO.VentasDAO" %>
<%@ page import="Modelos.Venta" %>

<%@ page import="Modelos.Usuario" %>
<%
    Usuario u = (Usuario) session.getAttribute("usuario");
    if (u == null || u.getRol().equals("cliente")) {
        response.sendRedirect("../../Home/index.jsp");
    } 
%>
<% 
    VentasDAO vDAO = new VentasDAO();
    ArrayList<Venta> ventas = vDAO.Listar();
%>
<jsp:include page="../../Templates/Head.jsp"/> 
    <jsp:include page="../Components/NavAdmin.jsp"/>  
    <main class="relative w-full flex min-h-[1000px]">
        <jsp:include page="../Components/BarraLateral.jsp"/>
        <section class="w-full max-sm:overflow-x-hidden">
            <div class="relative h-full w-full bg-[rgb(20,20,20)] flex flex-col p-5 gap-10">
                <div class="flex items-center justify-start">
                    <h2 class="text-5xl text-white">Ventas</h2>
                </div>
                <div class="w-full relative flex justify-center">
                    <div class="flex relative w-full overflow-x-auto scrollbar-thin scrollbar-track-black scrollbar-thumb-orange-600">
                        <div class="relative w-full">
                            <table class="w-full text-center max-sm:text-xs sm:text-base">
                                <thead class="border-b bg-neutral-800 text-white">
                                    <tr>
                                        <th scope="col" class=" p-5">ID</th>
                                        <th scope="col" class=" p-5">Transacción</th>
                                        <th scope="col" class=" p-5">fecha</th>
                                        <th scope="col" class=" p-5">hora</th>
                                        <th scope="col" class=" p-5">Monto Pagado</th>
                                        <th scope="col" class=" p-5">Descuento Aplicado</th>
                                        <th scope="col" class=" p-5">Cliente</th>
                                        <th scope="col" class=" p-5">Membresía</th>
                                        <th scope="col" class=" p-5">Método de Pago</th>
                                        <th scope="col" class=" p-5">Detalle</th>
                                    </tr>
                                </thead>
                                <tbody class="text-white">
                                <%  if (ventas == null || ventas.isEmpty()) {  %>
                                    <tr>
                                        <td colspan="9" class="p-5">No se registraron ventas</td>
                                    </tr>
                                 <% } else { %>
                                     <% for (Venta venta : ventas) { %>
                                        <tr class="border-b hover:bg-black transform duration-200">
                                            <td class="px-2 truncate"><%= venta.getId() %></td>
                                            <td class="px-2 truncate"><%= venta.getTransaccion() %></td>
                                            <td class="px-2 truncate max-w-[200px]"><%= venta.getFecha() %></td>
                                            <td class="px-2 truncate max-w-[200px]"><%= venta.getHora() %></td>
                                            <td class="px-2 truncate max-w-[200px]">$/<%= venta.getMonto() %></td>
                                            <td class="px-2 truncate max-w-[200px]">$/<%= venta.getDescuento() %></td>
                                            <td class="px-2 truncate max-w-[200px]"><%= venta.getNombreCliente() %></td>
                                            <td class="px-2 truncate max-w-[200px]"><%= venta.getIdcliente() %></td>
                                            <td class="px-2 truncate max-w-[200px]"><%= venta.getMetodo() %></td>
                                            <td class="flex flex-col gap-2 p-2">
                                                <a href="detalle.jsp?id=<%= venta.getId() %>" class="bg-white text-black px-2 py-1 hover:bg-cyan-300 transform duration-200 rounded-tl-md rounded-br-md">Ver Detalle</a>
                                            </td>
                                        </tr>
                                    <% } %>
                                <% } %>
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
