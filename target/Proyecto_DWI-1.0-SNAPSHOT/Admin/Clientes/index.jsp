<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="DAO.UsuariosDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Modelos.Cliente" %>
<%@ page import="Modelos.Usuario" %>
<%
    Usuario uSesion = (Usuario) session.getAttribute("usuario");
    if (uSesion == null || uSesion.getRol().equals("cliente")) {
        response.sendRedirect("../../Home/index.jsp");
    } 
%>
<% 
    UsuariosDAO usuDAO = new UsuariosDAO();
    ArrayList<Cliente> clientes = usuDAO.ListarClientes();

%>
<jsp:include page="../../Templates/Head.jsp"/> 
    <jsp:include page="../Components/NavAdmin.jsp"/>  
    <main class="relative w-full flex min-h-[1000px]">
        <jsp:include page="../Components/BarraLateral.jsp"/>
        <section class="w-full max-sm:overflow-x-hidden">
            <div class="relative h-full w-full bg-[rgb(20,20,20)] flex flex-col p-5 gap-10">
                <div class="flex items-center justify-between">
                    <h2 class="max-sm:text-4xl sm:text-5xl text-white">Clientes</h2> 
                </div>
                <div class="w-full relative flex justify-center">
                    <div class="flex relative w-full overflow-x-auto scrollbar-thin scrollbar-track-black scrollbar-thumb-orange-600">
                        <div class="relative w-full">
                            <table class="w-full text-center max-sm:text-xs sm:text-base">
                                <thead class="border-b bg-neutral-800 text-white">
                                    <tr>
                                        <th scope="col" class=" p-5">ID</th>
                                        <th scope="col" class=" p-5">Nombres</th>
                                        <th scope="col" class=" p-5">Apellidos</th>
                                        <th scope="col" class=" p-5">Correo Electrónico</th>
                                        <th scope="col" class=" p-5">Contraseña</th>
                                        <th scope="col" class=" p-5">Telefono</th>
                                        <th scope="col" class=" p-5"></th>
                                    </tr>
                                </thead>
                                <tbody class="text-white">
                                <%  if (clientes.isEmpty()) {  %>
                                    <tr>
                                        <td colspan="9" class="p-5">No hay clientes registrados</td>
                                    </tr>
                                 <% } else {
                                        for (Cliente clie : clientes) { %>
                                        <tr class="border-b hover:bg-black transform duration-200">
                                            <td class="p-2 truncate"><%= clie.getId() %></td>
                                            <td class="p-2 truncate max-w-[140px]"><%= clie.getNombres() %></td>
                                            <td class="p-2 truncate max-w-[140px]"><%= clie.getApellidos() %></td>
                                            <td class="p-2 truncate max-w-[140px]"><%= clie.getCorreo() %></td>
                                            <td class="p-2 truncate max-w-[140px]"><%= clie.getContraseña() %></td>
                                            <td class="p-2 truncate max-w-[140px]"><%= clie.getTelefono() %></td>
                                            <td>
                                                <a href="info.jsp?id=<%= clie.getId() %>" class="bg-warning filter hover:saturate-[3] text-black py-2 px-4 transform duration-200 rounded-tl-md rounded-br-md"><i class="fa-solid fa-eye"></i></a>   
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