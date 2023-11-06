<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="DAO.MarcasDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Modelos.Marca" %>
<%@ page import="Modelos.Usuario" %>
<%
    Usuario u = (Usuario) session.getAttribute("usuario");
    if (u == null || u.getRol().equals("cliente")) {
        response.sendRedirect("../../Home/index.jsp");
    } 
%>
<% 
    MarcasDAO marcaDAO = new MarcasDAO();
    ArrayList<Marca> marcas = marcaDAO.Listar();
%>
<jsp:include page="../../Templates/Head.jsp"/> 
    <jsp:include page="../Components/NavAdmin.jsp"/>  
    <main class="relative w-full flex min-h-[1000px]">
        <jsp:include page="../Components/BarraLateral.jsp"/>
        <section class="w-full max-sm:overflow-x-hidden">
            <div class="relative h-full w-full bg-[rgb(20,20,20)] flex flex-col p-5 gap-10">
                <div class="flex max-sm:flex-col max-sm:gap-3 items-center justify-between">
                    <h2 class="max-sm:text-4xl sm:text-5xl text-white">Marcas</h2>
                    <button class="min-w-[200px] p-2 bg-[rgb(255,100,0)] rounded-tl-md rounded-br-md text-white text-xl hover:bg-white hover:text-black transform duration-300" data-te-toggle="modal" data-te-target="#ModalMarcas" data-te-ripple-init>Crear Marca</button>
                </div>
                <div class="w-full relative flex justify-center">
                    <div class="flex relative w-full overflow-x-auto scrollbar-thin scrollbar-track-black scrollbar-thumb-orange-600">
                        <div class="relative w-full">
                            <table class="w-full text-center max-sm:text-xs sm:text-base">
                                <thead class="border-b bg-neutral-800 text-white">
                                    <tr>
                                        <th scope="col" class=" p-5">ID</th>
                                        <th scope="col" class=" p-5">Nombre</th>
                                        <th class="max-sm:hidden" scope="col" class=" p-5">Descripción</th>
                                        <th scope="col" class=" p-5">Acciones</th>
                                    </tr>
                                </thead>
                                <tbody class="text-white">
                                <%  if (marcas.isEmpty()) {  %>
                                    <tr>
                                        <td colspan="8" class="p-5">No hay Marcas registradas</td>
                                    </tr>
                                <% } else {
                                    for (Marca marca : marcas) {  %>
                                        <tr class="border-b hover:bg-black transform duration-200">
                                            <td class="px-2"><%= marca.getId() %></td>
                                            <td class="px-2 truncate"><%= marca.getNombre() %></td>
                                            <td class="px-2 max-sm:hidden truncate max-w-[300px]"><%= marca.getDesc() %></td>
                                            <td class="flex justify-center gap-2 p-2">
                                                <a href="modificar.jsp?id=<%= marca.getId() %>" class="bg-white text-black py-2 px-4 hover:bg-cyan-300 transform duration-200 rounded-tl-md rounded-br-md"><i class="fa-solid fa-pen-to-square"></i></a>
                                                <form action="../../ctrlMarcas" method="post">
                                                    <input type="hidden" name="idMarca" value="<%= marca.getId() %>">
                                                    <button type="submit" name="EliminarMarca" class="bg-red-500 text-white py-2 px-4 filter hover:saturate-200 transform duration-200 rounded-tl-md rounded-br-md cursor-pointer"><i class="fa-solid fa-trash"></i></button>
                                                </form>
                                            </td>
                                        </tr>
                                    <% }
                                    } %>   
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>     
        </section> 
    </main>
    <!-- Modal -->
    <div data-te-modal-init class="fixed left-0 top-0 z-[1055] hidden h-full w-full overflow-y-auto overflow-x-hidden outline-none" id="ModalMarcas" tabindex="-1" aria-labelledby="ModalMarcas" aria-hidden="true">
        <div data-te-modal-dialog-ref class="relative w-auto translate-y-[-50px] opacity-0 transition-all duration-300 ease-in-out min-[0px]:m-0 min-[0px]:h-full min-[0px]:max-w-none">
            <div class="relative flex w-full flex-col bg-black outline-none min-[0px]:h-full">
                <div class="flex flex-shrink-0 items-center justify-between border-b-2 border-[rgb(255,100,0)] p-5 text-5xl text-white">
                    <h5>Creación de Marca </h5>
                    <button type="button" class="hover:text-[rgb(255,100,0)] rotate-45 transform duration-300 hover:-rotate-45" data-te-modal-dismiss ><i class='bx bx-cross'></i></i></button>
                </div>
                <div class="relative p-5 min-[0px]:overflow-y-auto flex max-lg:flex-col gap-5">
                    <div class="max-lg:w-full lg:w-[30%]">
                        <form action="../../ctrlMarcas" method="POST" enctype="multipart/form-data" class="text-white text-base flex flex-col gap-3">
                            <div class="flex flex-col w-full gap-1">
                                <label for="">Nombre:</label>
                                <input type="text" name="nombreMarca" class="outline-none border  p-2 bg-neutral-950 " value="" required>
                            </div>
                            <div class="flex flex-col w-full gap-1">
                                <label for="">Descripción:</label>
                                <textarea cols="30" name="descMarca" class="outline-none border min-h-[140px] p-2 bg-neutral-950 " required></textarea>
                            </div>
                            <div class="flex flex-col w-full gap-1">
                                <label for="">Banner:</label>
                                <input id="file-Marca" name="bannerMarca" accept="image/*" type="file" onchange="mostrarImagen(this);" class="file-select" required>
                            </div>
                            <input type="submit" name="InsertarMarca" value="Insertar Marca" class="bg-white cursor-pointer text-xl text-black p-2 rounded-tl-lg rounded-br-lg hover:bg-cyan-300 transform duration-200 mt-3">
                        </form>
                    </div>
                    <div class="relative lg:w-[70%] flex flex-col gap-5 items-center">

                        <span class="text-3xl text-white">Banner Referencial:</span>
                        <div class=" relative flex items-center justify-center max-w-full max-h-[500px] overflow-y-auto flex-col p-2 scrollbar-thin scrollbar-track-black scrollbar-thumb-orange-500">
                            <img id="BannerReferencial" src="#" class="w-full h-auto">
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function mostrarImagen(input) {
          if (input.files && input.files[0]) {
            var r = new FileReader();
    
            r.onload = function (e) {
              var img = document.getElementById('BannerReferencial');
              img.src = e.target.result;
            };
    
            r.readAsDataURL(input.files[0]);
          }
        }
      </script>
<jsp:include page="../Components/ModalNav.jsp"/>
<jsp:include page="../../Templates/Footer.jsp"/> 
