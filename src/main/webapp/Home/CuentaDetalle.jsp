<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Modelos.Usuario" %>
<%@ page import="Modelos.Cliente" %>
<%@ page import="Modelos.Venta" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="DAO.UsuariosDAO" %>
<%@ page import="DAO.VentasDAO" %>
<%

    Usuario u = (Usuario) session.getAttribute("usuario");
    if (u==null || u.getCorreo().isBlank() ) {
        response.sendRedirect("index.jsp");
        return;
    } 
    
    UsuariosDAO uDAO = new UsuariosDAO();
    VentasDAO vDAO = new VentasDAO();
    Cliente c = uDAO.ObtenerCliente(u.getId());
    ArrayList<Venta> ventas= vDAO.ListarVentasCLiente(c.getId());
    int Compras = vDAO.CantidadVentasCliente(c.getId());
%>
<jsp:include page="../Templates/Head.jsp"/> 
    <jsp:include page="Components/NavClient.jsp"/>
        <main>
        <section>
            <div class="h-full w-full grid grid-cols-2 px-10 pt-[100px] gap-10">
            <% if(c!=null) {%>
                <div class="flex flex-col">
                    <h2 class="text-5xl text-white">Bienvenido, <%=c.getNombres() %></h2>
                    <div class="flex flex-col gap-5 pt-10">
                        <div class="flex gap-5 items-center flex-row">
                            <span class="text-3xl text-white">Información de cuenta</span>
                            <button class="text-white flex items-center gap-2 px-4 py-3 rounded-tl-lg rounded-br-lg hover:saturate-200 transform duration-300 filter bg-[rgb(255,100,0)]"><i class="fa-solid fa-pen-to-square"></i></button>
                        </div>
                        <div class="flex flex-col gap-1">
                            <label for="" class="text-2xl text-[rgb(255,100,0)]">Nombres:</label>
                            <span class="text-2xl text-white"><%=c.getNombres() %></span>
                        </div>
                        <div class="flex flex-col gap-1">
                            <label for="" class="text-2xl text-[rgb(255,100,0)]">Apellidos:</label>
                            <span class="text-2xl text-white"><%= c.getApellidos() %></span>
                        </div>
                        <div class="flex flex-col gap-1">
                            <label for="" class="text-2xl text-[rgb(255,100,0)]">Correo Electrónico:</label>
                            <span class="text-2xl text-white"><%=c.getCorreo() %></span>
                        </div>
                        <div class="flex flex-col gap-1">
                            <label for="" class="text-2xl text-[rgb(255,100,0)]">Telefono:</label>
                            <span class="text-2xl text-white"><%=c.getTelefono() %></span>
                        </div>
                        <div class="flex flex-col gap-1">
                            <label for="" class="text-2xl text-[rgb(255,100,0)]">Compras Realizadas:</label>
                            <span class="text-2xl text-white"><%=Compras %></span>
                        </div>
                        <div class="flex flex-col gap-1">
                            <label for="" class="text-2xl text-[rgb(255,100,0)]">Puntos de menbresia:</label>
                            <span class="text-2xl text-white"><%=c.getPuntos() %></span>
                        </div>
                    </div>
                </div>
                <div class="w-full relative flex justify-center">
                    <div class="flex relative w-full overflow-x-auto scrollbar-thin scrollbar-track-black scrollbar-thumb-orange-600">
                        <div class="relative w-full">
                            <table class="w-full text-center max-sm:text-xs sm:text-base">
                               <thead class="border-b bg-neutral-800 text-white">
                                    <tr>
                                        <th scope="col" class=" p-5">Transacción</th>
                                        <th scope="col" class=" p-5">fecha</th>
                                        <th scope="col" class=" p-5">hora</th>
                                        <th scope="col" class=" p-5">Monto Pagado</th>
                                        <th scope="col" class=" p-5">Descuento Aplicado</th>
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
                                            <td class="px-2 truncate"><%= venta.getTransaccion() %></td>
                                            <td class="px-2 truncate max-w-[200px]"><%= venta.getFecha() %></td>
                                            <td class="px-2 truncate max-w-[200px]"><%= venta.getHora() %></td>
                                            <td class="px-2 truncate max-w-[200px]">$/<%= venta.getMonto() %></td>
                                            <td class="px-2 truncate max-w-[200px]">$/<%= venta.getDescuento() %></td>
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
            <% } %>
            </div>
        </section>
        </main>
        <jsp:include page="Components/ModalNav.jsp"/>
        <jsp:include page="Components/ModalCarrito.jsp"/>
        <jsp:include page="Components/ModalBuscador.jsp"/>
<jsp:include page="../Templates/Footer.jsp"/> 