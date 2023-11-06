<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="DAO.CategoriasDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Modelos.Categoria" %>
<%@ page import="Modelos.Usuario" %>
<%
    Usuario u = (Usuario) session.getAttribute("usuario");
    if (u == null || u.getRol().equals("cliente")) {
        response.sendRedirect("../../Home/index.jsp");
    }
%>
<% 
    int id = Integer.parseInt(request.getParameter("id"));
    CategoriasDAO cateDAO = new CategoriasDAO();
    Categoria cate = cateDAO.ObtenerCategoria(id);
%>
<jsp:include page="../../Templates/Head.jsp"/> 
    <jsp:include page="../Components/NavAdmin.jsp"/>  
    <main class="relative w-full flex min-h-[1000px]">
        <jsp:include page="../Components/BarraLateral.jsp"/>
        <section class="w-full max-sm:overflow-x-hidden">
            <div class="relative h-full w-full bg-[rgb(20,20,20)] flex flex-col p-5 gap-10">
                <div class="flex max-sm:flex-col max-sm:gap-3 items-center justify-between">
                    <h2 class="max-sm:text-4xl sm:text-5xl text-white">Categorias</h2> 
                    <a href="index.jsp" class="flex items-center justify-center w-[200px] py-2 bg-[rgb(255,100,0)] rounded-tl-md rounded-br-md text-white text-xl hover:bg-white hover:text-black transform duration-300"">Volver</a>
                </div>
                <div class=" w-full h-full relative flex justify-center p-2">
                    <form action="../../ctrlCategorias" method="POST" enctype="multipart/form-data" class="text-white text-base max-w-[600px] flex flex-col gap-3">
                        <div class="flex flex-col w-full gap-1">
                            <label for="">Nombre:</label>
                            <input type="text" name="nombreCategoria" class="outline-none border  p-2 bg-neutral-950 " value="<%= cate.getNombre()%>" required>
                        </div>
                        <div class="flex flex-col w-full gap-1">
                            <label for="">Descripción:</label>
                            <textarea cols="30" name="descripcionCategoria" class="outline-none border min-h-[80px] p-2 bg-neutral-950 " required><%= cate.getDesc() %></textarea>
                        </div>
                        <div class="flex flex-col w-full gap-1">
                            <label for="">Imagen Referencial:</label>
                            <input id="file-input-1" type="file" name="imgCategoriaNuevo" onchange="mostrarImagen(this,'imgReferencial');" class="file-select">
                            <div class="relative flex items-center justify-center max-h-[200px] max-w-full  bg-neutral-950">
                                <img id="imgReferencial" src="#" alt="_imagen referencial" class="w-full h-full">
                            </div>
                        </div>
                        <div class="flex flex-col w-full gap-1">
                            <label for="">Banner:</label>
                            <input id="file-input-1" type="file" name="bannerCategoriaNuevo" onchange="mostrarImagen(this,'BannerReferencial');" class="file-select" >
                            <div class="relative flex items-center justify-center max-h-[200px] max-w-full  bg-neutral-950">
                                <img id="BannerReferencial" src="#" alt="_Banner referencial" class="w-full h-full">
                            </div>
                        </div>
                        <input type="hidden" name="idCategoria" id="" value="<%= cate.getId() %>">
                        <input type="hidden" name="imgUrlCate" id="" value="<%= cate.getImgRef() %>">
                        <input type="hidden" name="bannerUrlCate" id="" value="<%= cate.getBannerRef() %>">
                        <input type="submit" name="ModificarCategoria" value="Modificar Categoria" class="bg-white cursor-pointer text-xl text-black p-2 rounded-tl-lg rounded-br-lg hover:bg-cyan-300 transform duration-200 mt-3">
                    </form>
                </div>
            </div> 
        </section> 
    </main>
    <script>

        function mostrarImagen(input,IDimagen) {
            if (input.files && input.files[0]) {
                var r = new FileReader();
                r.onload = function (e) {
                    var img = document.getElementById(IDimagen);
                    img.src = e.target.result;
                };
                r.readAsDataURL(input.files[0]);
            }
        }
        
      </script>
<jsp:include page="../Components/ModalNav.jsp"/>     
<jsp:include page="../../Templates/Footer.jsp"/> 
