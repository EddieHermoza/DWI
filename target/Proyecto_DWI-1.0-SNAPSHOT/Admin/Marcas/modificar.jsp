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
    int id = Integer.parseInt(request.getParameter("id"));
    MarcasDAO mDAO = new MarcasDAO();
    Marca marca = mDAO.ObtenerMarca(id);
%>
<jsp:include page="../../Templates/Head.jsp"/> 
    <jsp:include page="../Components/NavAdmin.jsp"/>  
    <main class="relative w-full flex min-h-[1000px]">
        <jsp:include page="../Components/BarraLateral.jsp"/>
        <section class="w-full max-sm:overflow-x-hidden">
            <div class="relative h-full w-full bg-[rgb(20,20,20)] flex flex-col p-5 gap-10">
                <div class="flex max-sm:flex-col max-sm:gap-3 items-center justify-between">
                    <h2 class="max-sm:text-4xl sm:text-5xl text-white">Marcas</h2> 
                    <a href="index.jsp" class="flex items-center justify-center w-[200px] py-2 bg-[rgb(255,100,0)] rounded-tl-md rounded-br-md text-white text-xl hover:bg-white hover:text-black transform duration-300"">Volver</a>
                </div>
                <div class=" w-full h-full relative flex justify-center p-2">
                    <form action="../../ctrlMarcas" method="POST" enctype="multipart/form-data" class="text-white max-w-[600px] text-base flex flex-col gap-3">
                        <div class="flex flex-col w-full gap-1">
                            <label for="">Nombre:</label>
                            <input type="text" name="nombreMarca" class="outline-none border  p-2 bg-neutral-950 " value="<%= marca.getNombre()%>" required>
                        </div>
                        <div class="flex flex-col w-full gap-1">
                            <label for="">Descripción:</label>
                            <textarea cols="30" name="descMarca" class="outline-none border min-h-[80px] p-2 bg-neutral-950 " required><%= marca.getDesc() %></textarea>
                        </div>
                        <div class="flex flex-col w-full gap-1">
                            <label for="">Banner:</label>
                            <input id="file-Marca" name="bannerMarcaNuevo" accept="image/*" type="file" onchange="mostrarImagen(this);" class="file-select" >
                            <div class="relative flex items-center justify-center max-h-[200px] max-w-full bg-neutral-950">
                                <img id="BannerReferencial" src="#" alt="_Banner referencial" class="max-w-full h-full">
                            </div>
                        </div>
                        <input type="hidden" name="urlMarca" id="" value="<%= marca.getBannerRef()%>">
                        <input type="hidden" name="idMarca" id="" value="<%= marca.getId()%>">
                        <input type="submit" name="ModificarMarca" value="Modificar Marca" class="bg-white cursor-pointer text-xl text-black p-2 rounded-tl-lg rounded-br-lg hover:bg-cyan-300 transform duration-200 mt-3">
                    </form>
                </div>
            </div> 
        </section> 
    </main>
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
