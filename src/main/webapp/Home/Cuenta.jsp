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

    String error="";
    if(request.getParameter("error")!=null){
        error = request.getParameter("error");
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
        <section class="flex flex-col h-full items-center pt-[100px]  animate-fade animate-duration-[2000ms]">
         <% if(c!=null) {%>
            <h2 class="text-5xl text-white">Bienvenido, <%=c.getNombres()+" "+c.getApellidos() %></h2>
            <span class="text-red-600 text-lg w-full text-center"><%=error %></span>
            <div class="max-w-screen-2xl w-full flex-col gap-20 items-center">
                <div class="relative">
                    <div class="flex flex-col gap-5 pt-10">
                        <div class="flex gap-5 items-center flex-row">
                            <span class="text-3xl text-white">Información de cuenta</span>
                            <button class="text-white flex items-center gap-2 px-4 py-3 rounded-tl-lg rounded-br-lg hover:saturate-200 transform duration-300 filter bg-[rgb(255,100,0)]" data-te-toggle="modal" data-te-target="#ModalCliente" data-te-ripple-init><i class="fa-solid fa-pen-to-square"></i></button>
                            <button class="text-white flex items-center gap-2 px-4 py-3 rounded-tl-lg rounded-br-lg hover:saturate-200 transform duration-300 filter bg-red-600" data-te-toggle="modal" data-te-target="#ModalEliminarCliente" data-te-ripple-init><i class="fa-solid fa-trash"></i></button>
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
                    </div>
                </div>
                <div class="relative flex flex-col items-center gap-5">
                    <span class="text-white text-5xl">Compras:</span>
                    <div class=" w-full flex relative overflow-x-auto scrollbar-thin scrollbar-track-black scrollbar-thumb-orange-600">
                        <div class="relative w-full">
                            <table class="w-full text-center text-sm">
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
                                                <a href="CuentaDetalle.jsp?id=<%= venta.getId() %>" class="bg-white text-black px-2 py-1 hover:bg-cyan-300 transform duration-200 rounded-tl-md rounded-br-md"><i class="fa-solid fa-eye"></i></a>
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
        <div data-te-modal-init class="fixed left-0 top-0 z-[1055] hidden h-full w-full overflow-y-auto overflow-x-hidden outline-none" id="ModalCliente" tabindex="-1" aria-labelledby="ModalCliente" aria-hidden="true">
            <div data-te-modal-dialog-ref class="relative w-auto translate-y-[-50px] opacity-0 transition-all duration-300 ease-in-out min-[0px]:m-0 min-[0px]:h-full min-[0px]:max-w-none">
                <div class="relative flex w-full flex-col bg-black outline-none min-[0px]:h-full">
                    <div class="flex flex-shrink-0 items-center justify-between border-b-2 border-[rgb(255,100,0)] p-5 text-4xl text-white">
                        <h5>Editar Información </h5>
                        <button type="button" class="hover:text-[rgb(255,100,0)] rotate-45 transform duration-300 hover:-rotate-45" data-te-modal-dismiss ><i class='bx bx-cross'></i></i></button>
                    </div>
                    <div class="relative p-5 min-[0px]:overflow-y-auto flex justify-center">
                        <form action="../ctrlCliente" method="POST" class="text-white  w-[500px] text-xl flex flex-col gap-3" autocomplete="off">
                            <div class="flex flex-col space-y-5 p-6">
                                <div class="flex flex-col space-y-2">
                                    <label for="" class="text-white text-xl">Nombres</label>
                                    <input type="text" name="nombresClie" value="<%=c.getNombres() %>" required autocomplete="off" class="outline-none w-full border  p-2 bg-neutral-950">    
                                </div>
                                <div class="flex flex-col space-y-2">
                                    <label for="" class="text-white text-xl">Apellidos</label>
                                    <input type="text" name="apellidosClie" value="<%=c.getApellidos() %>" required autocomplete="off" class="outline-none w-full border  p-2 bg-neutral-950">    
                                </div>
                                <div class="flex flex-col space-y-2">
                                    <label for="" class="text-white text-xl">Correo Electrónico</label>
                                    <input type="email" name="correoClie" value="<%=c.getCorreo() %>" required autocomplete="off" class="outline-none w-full border  p-2 bg-neutral-950">    
                                </div>
                                <div class="flex flex-col space-y-2">
                                    <label for="" class="text-white text-xl">Número Telefonico:</label>
                                    <input type="text" name="telefonoClie" value="<%=c.getTelefono() %>" required autocomplete="off" class="outline-none w-full border  p-2 bg-neutral-950">    
                                </div>
                                <div class="flex flex-col space-y-2">
                                    <label for="" class="text-white text-xl">Nueva Contraseña:</label>
                                    <input type="password" name="contraseñaClie" autocomplete="off" class="outline-none border  p-2 bg-neutral-950">
                                </div>
                                <div class="flex pt-7 items-center justify-between space-x-5">
                                    <input type="submit" name="ModificarCliente" autocomplete="off" value="Editar" class="bg-white w-full cursor-pointer text-xl text-black p-2 rounded-tl-lg rounded-br-lg hover:bg-cyan-300 transform duration-200 mt-3">
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div data-te-modal-init class="fixed left-0 top-0 z-[1055] hidden h-full w-full overflow-y-auto overflow-x-hidden outline-none" id="ModalEliminarCliente" tabindex="-1" aria-labelledby="ModalEliminarCliente" aria-hidden="true">
            <div data-te-modal-dialog-ref class="relative w-auto translate-y-[-50px] opacity-0 transition-all duration-300 ease-in-out min-[0px]:m-0 min-[0px]:h-full min-[0px]:max-w-none flex items-center">
                <div class="relative flex gap-5 items-center max-w-[600px] w-full h-[200px] flex-col bg-black outline-none border-[rgb(255,100,0)] m-auto border-2 p-2">
                    <div class="w-full flex flex-shrink-0 items-center justify-between p-2 text-xl text-white">
                        <h5>¿Seguro que desea eliminar esta cuenta? </h5>
                        <button type="button" class="hover:text-[rgb(255,100,0)] rotate-45 transform duration-300 hover:-rotate-45 text-3xl" data-te-modal-dismiss ><i class='bx bx-cross'></i></i></button>
                    </div>
                    <form action="../ctrlCliente" method="POST" class="w-full flex items-center justify-center" autocomplete="off">
                        <input type="submit" name="EliminarCliente" autocomplete="off" value="Eliminar Cuenta" class="bg-red-600 w-[200px] cursor-pointer text-xl text-white p-2 hover:saturate-200 filter transform duration-200">
                    </form>
                </div>
            </div>
        </div>
        <jsp:include page="Components/ModalNav.jsp"/>
        <jsp:include page="Components/ModalCarrito.jsp"/>
        <jsp:include page="Components/ModalBuscador.jsp"/>
<jsp:include page="../Templates/Footer.jsp"/> 