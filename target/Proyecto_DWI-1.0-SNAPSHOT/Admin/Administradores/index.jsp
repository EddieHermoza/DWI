<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="DAO.UsuariosDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Modelos.Usuario" %>
<%
    Usuario u = (Usuario) session.getAttribute("usuario");
    if (u == null || u.getRol().equals("cliente")) {
        response.sendRedirect("../../Home/index.jsp");
    } 
%>

<% 
    UsuariosDAO usuDAO = new UsuariosDAO();
    ArrayList<Usuario> usuarios = usuDAO.ListarAdministradores();

%>
<jsp:include page="../../Templates/Head.jsp"/> 
    <jsp:include page="../Components/NavAdmin.jsp"/>  
    <main class="relative w-full flex min-h-[1000px]">
        <jsp:include page="../Components/BarraLateral.jsp"/>
        <section class="w-full max-sm:overflow-x-hidden">
            <div class="relative h-full w-full bg-[rgb(20,20,20)] flex flex-col p-5 gap-10">
                <div class="flex max-md:flex-col gap-3 md:flex-row items-center justify-between">
                    <h2 class="max-sm:text-4xl sm:text-5xl text-white">Administradores</h2> 
                    <button class="min-w-[200px] p-2 bg-[rgb(255,100,0)] rounded-tl-md rounded-br-md text-white text-xl hover:bg-white hover:text-black transform duration-300" data-te-toggle="modal" data-te-target="#ModalAdmin" data-te-ripple-init>Crear Administrador</button>
                </div>
                <div class="w-full relative flex justify-center">
                    <div class="flex relative w-full overflow-x-auto scrollbar-thin scrollbar-track-black scrollbar-thumb-orange-600">
                        <div class="relative w-full">
                            <table class="w-full text-center max-sm:text-xs sm:text-base">
                                <thead class="border-b bg-neutral-800 text-white">
                                    <tr>
                                        <th scope="col" class=" p-5">ID</th>
                                        <th class="max-[425px]:hidden" scope="col" class=" p-5">Nombres</th>
                                        <th class="max-md:hidden" scope="col" class=" p-5">Apellidos</th>
                                        <th scope="col" class=" p-5">Correo Electrónico</th>
                                        <th class="max-xl:hidden" scope="col" class=" p-5">Contraseña</th>
                                        <th scope="col" class=" p-5">Acciones</th>
                                    </tr>
                                </thead>
                                <tbody class="text-white">
                                <%  if (usuarios.isEmpty()) {  %>
                                    <tr>
                                        <td colspan="9" class="p-5">No hay administradores registrados</td>
                                    </tr>
                                 <% } else {
                                        for (Usuario usuario : usuarios) { %>
                                        <tr class="border-b hover:bg-black transform duration-200 h-10">
                                            <td class="p-2 truncate"><%= usuario.getId() %></td>
                                            <td class="p-2 max-[425px]:hidden truncate max-w-[200px]"><%= usuario.getNombres() %></td>
                                            <td class="p-2 max-md:hidden truncate max-w-[200px]"><%= usuario.getApellidos() %></td>
                                            <td class="p-2 truncate max-w-[200px]"><%= usuario.getCorreo() %></td>
                                            <td class="p-2  max-xl:hidden truncate max-w-[200px]"><%= usuario.getContraseña() %></td>
                                            <td class="flex justify-center gap-2 p-2">
                                                <a href="modificar.jsp?id=<%= usuario.getId() %>" class="bg-white text-black py-2 px-4 hover:bg-cyan-300 transform duration-200 rounded-tl-md rounded-br-md"><i class="fa-solid fa-pen-to-square"></i></a>
                                                <% if(usuarios.size()>1 && usuario.getId()!=u.getId()) {%>
                                                    <form action="../../ctrlUsuarios" method="post" class="relative">
                                                        <input type="hidden" name="idAdmin" value="<%= usuario.getId() %>">
                                                        <button type="submit" name="EliminarAdmin" class="bg-red-500 w-full text-white py-2 px-4 filter hover:saturate-200 transform duration-200 rounded-tl-md rounded-br-md cursor-pointer"><i class="fa-solid fa-trash"></i></button>
                                                    </form>
                                                <% } %>
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
    <div data-te-modal-init class="fixed left-0 top-0 z-[1055] hidden h-full w-full overflow-y-auto overflow-x-hidden outline-none" id="ModalAdmin" tabindex="-1" aria-labelledby="ModalAdmin" aria-hidden="true">
        <div data-te-modal-dialog-ref class="relative w-auto translate-y-[-50px] opacity-0 transition-all duration-300 ease-in-out min-[0px]:m-0 min-[0px]:h-full min-[0px]:max-w-none">
            <div class="relative flex w-full flex-col bg-black outline-none min-[0px]:h-full">
                <div class="flex flex-shrink-0 items-center justify-between border-b-2 border-[rgb(255,100,0)] p-5 text-4xl text-white">
                    <h5>Creación de Administrador </h5>
                    <button type="button" class="hover:text-[rgb(255,100,0)] rotate-45 transform duration-300 hover:-rotate-45" data-te-modal-dismiss ><i class='bx bx-cross'></i></i></button>
                </div>
                <div class="relative p-5 min-[0px]:overflow-y-auto flex justify-center">
                    <form action="../../ctrlUsuarios" method="POST" class="text-white  w-[500px] text-xl flex flex-col gap-3" autocomplete="off">
                        <div class="flex flex-col space-y-5 p-6">
                            <div class="flex flex-col space-y-2">
                                <label for="" class="text-white text-xl">Nombres</label>
                                <input type="text" name="nombresAdmin" required autocomplete="off" class="outline-none w-full border  p-2 bg-neutral-950">    
                            </div>
                            <div class="flex flex-col space-y-2">
                                <label for="" class="text-white text-xl">Apellidos</label>
                                <input type="text" name="apellidosAdmin" required autocomplete="off" class="outline-none w-full border  p-2 bg-neutral-950">    
                            </div>
                            <div class="flex flex-col space-y-2">
                                <label for="" class="text-white text-xl">Correo Electrónico</label>
                                <input type="email" name="correoAdmin" required autocomplete="off" class="outline-none w-full border  p-2 bg-neutral-950">    
                            </div>
                            <div class="flex flex-col space-y-2">
                                <label for="" class="text-white text-xl">Contraseña:</label>
                                <input type="password" name="contraAdmin" required autocomplete="off" class="outline-none border  p-2 bg-neutral-950">
                            </div>
                            <div class="flex pt-7 items-center justify-between space-x-5">
                                <input type="submit" name="InsertarAdmin" autocomplete="off" value="Crear Administrador" class="bg-white cursor-pointer text-xl text-black p-2 rounded-tl-lg rounded-br-lg hover:bg-cyan-300 transform duration-200 mt-3">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="../Components/ModalNav.jsp"/>    
<jsp:include page="../../Templates/Footer.jsp"/> 
