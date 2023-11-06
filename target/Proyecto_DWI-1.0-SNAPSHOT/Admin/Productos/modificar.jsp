<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="DAO.ProductosDAO" %>
<%@ page import="DAO.MarcasDAO" %>
<%@ page import="DAO.CategoriasDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Modelos.Producto" %>
<%@ page import="Modelos.Marca" %>
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
    ProductosDAO produDAO = new ProductosDAO();
    Producto producto = produDAO.ObtenerProducto(id);

    MarcasDAO marcaDAO = new MarcasDAO();
    ArrayList<Marca> marcas= marcaDAO.Listar();

    CategoriasDAO cateDAO = new CategoriasDAO();
    ArrayList<Categoria> categorias= cateDAO.Listar();
%>
<jsp:include page="../../Templates/Head.jsp"/> 
    <jsp:include page="../Components/NavAdmin.jsp"/>  
    <main class="relative w-screen flex min-h-[1000px]">
        <jsp:include page="../Components/BarraLateral.jsp"/>
        <section class="w-full max-sm:overflow-x-hidden">
            <div class="relative h-full w-full bg-[rgb(20,20,20)] flex flex-col p-5 gap-10">
                <div class="flex max-sm:flex-col max-sm:gap-3 items-center justify-between">
                    <h2 class="max-sm:text-4xl sm:text-5xl text-white">Productos</h2> 
                    <a href="index.jsp" class="flex items-center justify-center w-[200px] py-2 bg-[rgb(255,100,0)] rounded-tl-md rounded-br-md text-white text-xl hover:bg-white hover:text-black transform duration-300"">Volver</a>
                </div>
                <div class="w-full h-full relative flex justify-center p-2">

                    <form action="../../ctrlProductos" method="post" enctype="multipart/form-data" class="text-white text-base max-w-[600px] flex flex-col gap-3">
                        <div class="flex flex-col w-full gap-1">
                            <label for="">Nombre:</label>
                            <input type="text" class="outline-none border  p-2 bg-neutral-950 " name="nombreProducto" value="<%= producto.getNombre() %>" required>
                        </div>
                        <div class="flex flex-col w-full gap-1">
                            <label for="">Descripción:</label>
                            <textarea cols="30" class="outline-none border min-h-[80px] p-2 bg-neutral-950 " name="descripcionProducto"required><%= producto.getDescripcion() %></textarea>
                        </div>
                        <div class="flex gap-3">
                            <div class="flex flex-col w-full gap-1">
                                <label for="">Marca:</label>
                                <select class="outline-none border p-2  bg-neutral-950 " name="marcaProducto" required>
                                    <%  if (marcas.isEmpty()) {  %>
                                        <option value="" disabled selected hidden>No hay marcas registradas</option>  
                                     <% } else {
                                            for (Marca marca : marcas) { %>
                                                <%  if(marca.getId() == producto.getMarca()){ %>
                                                    <option value="<%= marca.getId() %>" selected><%= marca.getNombre() %></option>
                                                <%  } else {%>
                                                    <option value="<%= marca.getId() %>"><%= marca.getNombre() %></option>
                                                <%  } %>    
                                        <%  }
                                        }
                                        %>
                                </select>
                            </div>
                            <div class="flex flex-col w-full gap-1">
                                <label for="">Categoría:</label>
                                <select class="outline-none border p-2 bg-neutral-950 " name="categoriaProducto" required>
                                    <%  if (categorias.isEmpty()) {  %>
                                        <option value="" disabled selected hidden>No hay categorias registradas</option>  
                                     <% } else {
                                            for (Categoria cate : categorias) { %>
                                                <%  if(cate.getId() == producto.getCategoria()){ %>
                                                    <option value="<%= cate.getId() %>" selected><%= cate.getNombre() %></option>
                                                <%  } else {%>
                                                    <option value="<%= cate.getId() %>"><%= cate.getNombre() %></option>
                                                <%  } %>   
                                        <% }
                                        }
                                        %>
                                </select>
                            </div>
                        </div>
                        <div class="flex flex-col gap-3">
                            <div class="flex flex-col w-full gap-1">
                                <label for="precio">Precio:</label>
                                <input type="number" step="any" id="precio" name="precioProducto" min="0" placeholder="" class="outline-none border pl-2 py-2 bg-neutral-950" required value="<%= producto.getPrecio() %>">
                            </div>
                            
                            <div class="flex flex-col w-full gap-1">
                                <label for="descuento">Descuento:</label>
                                <input type="number" min="0" max="1" step="0.01" name="descuentoProducto" id="descuento" class="outline-none border pl-2 py-2 bg-neutral-950" required value="<%= producto.getDescuento() %>">
                            </div>
                        </div>
                        <div class="flex flex-col w-full gap-1">
                            <label for="">Especificaciones:</label>
                            <span class="">Separe cada especificacion con "-"</span>
                            <textarea id="textEspecs" rows="4" cols="30" class="outline-none min-h-[100px] border p-2 bg-neutral-950 " name="especificacionesProducto" required><%= producto.getEspecificaciones() %></textarea>
                        </div>
                        <div class="flex flex-col w-full gap-1">
                            <label for="">Imagen referencial:</label>
                            <input id="file-input-2" type="file" name="imgProductoNuevo" onchange="mostrarImagen(this);" class="file-select">
                            <div class="relative flex items-center justify-center max-h-[200px] max-w-full  bg-neutral-950">
                                <img id="imgReferencial" src="#" alt="_Imagen referencial" class="max-w-full h-full">
                            </div>
                        </div>
                        <input type="hidden" name="idProducto" value="<%= producto.getId() %>">
                        <input type="hidden" name="urlProducto" value="<%= producto.getImg() %>">
                        <input type="hidden" name="estadoProducto" value="<%=producto.getEstado() %>">
                        <input type="hidden" name="cantidadProducto" value="<%=producto.getCantidad() %>">
                        <input type="submit" name="ModificarProducto" value="Modificar Producto" class="bg-white cursor-pointer text-xl text-black p-2 rounded-tl-lg rounded-br-lg hover:bg-cyan-300 transform duration-200 mt-3">
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
              var img = document.getElementById('imgReferencial');
              img.src = e.target.result;
            };
    
            r.readAsDataURL(input.files[0]);
          }
        }

        const textarea = document.getElementById("textEspecs");
        textarea.addEventListener("input", function (event) {
            const lines = event.target.value.split("\n");
            const lastLine = lines[lines.length - 1];
            if (lastLine.trim() !== "" && !lastLine.startsWith("-")) {
                lines.pop();
                event.target.value = lines.join("\n");
            }
        });
      </script>
<jsp:include page="../Components/ModalNav.jsp"/>
<jsp:include page="../../Templates/Footer.jsp"/> 
