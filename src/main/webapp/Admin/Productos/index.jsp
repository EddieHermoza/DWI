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
    ProductosDAO produDAO = new ProductosDAO();
    ArrayList<Producto> productos = produDAO.Listar();

    MarcasDAO marcaDAO = new MarcasDAO();
    ArrayList<Marca> marcas= marcaDAO.Listar();

    CategoriasDAO cateDAO = new CategoriasDAO();
    ArrayList<Categoria> categorias= cateDAO.Listar();
%>
<jsp:include page="../../Templates/Head.jsp"/> 
    <jsp:include page="../Components/NavAdmin.jsp"/>  
    <main class="relative w-full flex min-h-[1000px] ">
        <jsp:include page="../Components/BarraLateral.jsp"/>
        <section class="w-full max-sm:overflow-x-hidden">
            <div class="relative h-full w-full bg-[rgb(20,20,20)] flex flex-col p-5 gap-10">
                <div class="flex max-sm:flex-col max-sm:gap-3 items-center justify-between">
                    <h2 class="max-sm:text-4xl sm:text-5xl text-white">Productos</h2> 
                    <button class="min-w-[200px] p-2 bg-[rgb(255,100,0)] rounded-tl-md rounded-br-md text-white text-xl hover:bg-white hover:text-black transform duration-300" data-te-toggle="modal" data-te-target="#ModalProductos" data-te-ripple-init>Crear Producto</button>
                </div>
                <div class="grid max-sm:grid-cols-1 max-xl:grid-cols-2 xl:grid-cols-4 grid-flow-row gap-5 p-5">
                    <div class="bg-white w-full flex flex-col justify-center text-black shadow-lg hover:scale-105 hover:shadow-white transform duration-300 p-5 h-24 rounded-md">
                        <% 
                        int dscto=0;
                        for (Producto p : productos) {
                            if (p.getDescuento() > 0) {
                                dscto++;
                            }
                        }
                        %>
                        <span class="text-2xl">Con Descuento:</span>     
                        <span class="text-3xl"><%= dscto %></span>                  
                    </div>
                    <div class="bg-cyan-400 w-full flex flex-col justify-center text-black shadow-lg hover:scale-105 hover:shadow-cyan-400/50 transform duration-300 p-5 h-24 rounded-md">
                        <span class="text-2xl">Registrados:</span>
                        <span class="text-3xl"><%= productos.size() %></span>
                    </div>
                    <div class="bg-red-600 w-full flex flex-col justify-center text-white shadow-lg hover:scale-105 hover:shadow-red-600/50 transform duration-300 p-5 h-24 rounded-md" >
                        <% 
                        int pocoStock=0;
                        for (Producto p : productos) {
                            if (p.getCantidad() < 5) {
                                pocoStock++;
                            }
                        }
                        %>
                        <span class="text-2xl">Con Poco Stock:</span>
                        <span class="text-3xl"><%= pocoStock %></span>
                    </div>
                    <div class="bg-yellow-500 w-full flex flex-col justify-center text-white shadow-lg hover:scale-105 hover:shadow-yellow-500/50 transform duration-300 p-5 h-24 rounded-md">
                        <% 
                        int inhabilitados=0;
                        for (Producto p : productos) {
                            if (p.getEstado().equals("inhabilitado")) {
                                inhabilitados++;
                            }
                        }
                        %>
                        <span class="text-2xl">Inhabilitados:</span>
                        <span class="text-3xl"><%= inhabilitados %></span>
                    </div>
                </div>
                <div class="w-full relative flex justify-center">
                    <div class="flex relative w-full overflow-x-auto scrollbar-thin scrollbar-track-black scrollbar-thumb-orange-600">
                        <div class="relative w-full">
                            <table class="w-full text-center max-sm:text-xs sm:text-base">
                                <thead class="border-b bg-neutral-800 text-white">
                                    <tr>
                                        <th scope="col" class=" p-5">ID</th>
                                        <th scope="col" class=" p-5">Nombre</th>
                                        <th class="max-xl:hidden" scope="col" class=" p-5">Descripción</th>
                                        <th class="max-xl:hidden" scope="col" class=" p-5">Marca</th>
                                        <th class="max-xl:hidden" scope="col" class=" p-5">Categoria</th>
                                        <th class="max-[425px]:hidden" scope="col" class=" p-5">Precio</th>
                                        <th class="max-sm:hidden" scope="col" class=" p-5">Descuento</th>
                                        <th class="max-[425px]:hidden" scope="col" class=" p-5">Estado</th>
                                        <th scope="col" class=" p-5">Acciones</th>
                                    </tr>
                                </thead>
                                <tbody class="text-white">
                                <%  if (productos.isEmpty()) {  %>
                                    <tr>
                                        <td colspan="9" class="p-5">No se registraron productos</td>
                                    </tr>
                                 <% } else {
                                        for (Producto producto : productos) { %>
                                        <tr class="border-b hover:bg-black transform duration-200">
                                            <td class="px-2 truncate"><%= producto.getId() %></td>
                                            <td class="px-2 truncate max-w-[200px]"><%= producto.getNombre() %></td>
                                            <td class="px-2 max-xl:hidden truncate max-w-[200px]"><%= producto.getDescripcion() %></td>
                                            <td class="px-2 max-xl:hidden truncate max-w-[200px]"><%= producto.getMarca() %></td>
                                            <td class="px-2 max-xl:hidden truncate max-w-[200px]"><%= producto.getCategoria() %></td>
                                            <td class="px-2 max-[425px]:hidden truncate max-w-[140px]">$/<%= producto.getPrecio() %></td>
                                            <td class="px-2 max-sm:hidden truncate max-w-[140px]"><%= producto.getDescuento() %></td>
                                            <td class="px-2 max-[425px]:hidden truncate max-w-[140px]"><%= producto.getEstado() %></td>
                                            <td class="flex flex-col gap-2 p-2">
                                                <a href="modificar.jsp?id=<%= producto.getId() %>" class="bg-white text-black px-2 py-1 hover:bg-cyan-300 transform duration-200 rounded-tl-md rounded-br-md"><i class="fa-solid fa-pen-to-square"></i></a>
                                                <form action="../../ctrlProductos" method="post" class="w-full relative">
                                                    <input type="hidden" name="idprodu" value="<%= producto.getId() %>">
                                                    <button type="submit" name="EliminarProducto" value="Eliminar" class="bg-red-500 w-full text-white px-2 py-1 filter hover:saturate-200 transform duration-200 rounded-tl-md rounded-br-md cursor-pointer"><i class="fa-solid fa-trash"></i></button>
                                                </form>
                                                <% if(producto.getEstado().equals("habilitado")) { %>
                                                <form action="../../ctrlProductos" method="post" class="w-full relative">
                                                    <input type="hidden" name="idprodu" value="<%= producto.getId() %>">
                                                    <button type="submit" name="InhabilitarProducto" class="bg-yellow-500 w-full text-black px-2 py-1 filter hover:saturate-200 transform duration-200 rounded-tl-md rounded-br-md cursor-pointer"><i class="fas fa-lock"></i></button>
                                                </form>
                                                <%} else {%>
                                                <form action="../../ctrlProductos" method="post" class="w-full relative">
                                                    <input type="hidden" name="idprodu" value="<%= producto.getId() %>">
                                                    <button type="submit" name="HabilitarProducto" class="bg-yellow-500 w-full text-black px-2 py-1 filter hover:saturate-200 transform duration-200 rounded-tl-md rounded-br-md cursor-pointer"><i class="fas fa-unlock"></i></button>
                                                </form>    
                                                <% }  %>
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
    <!-- Modal -->
    <div data-te-modal-init class="fixed left-0 top-0 z-[1055] hidden h-full w-full overflow-y-auto overflow-x-hidden outline-none" id="ModalProductos" tabindex="-1" aria-labelledby="ModalProductos" aria-hidden="true">
        <div data-te-modal-dialog-ref class="relative w-auto translate-y-[-50px] opacity-0 transition-all duration-300 ease-in-out min-[0px]:m-0 min-[0px]:h-full min-[0px]:max-w-none">
            <div class="relative flex w-full flex-col bg-black outline-none min-[0px]:h-full">
                <div class="flex flex-shrink-0 items-center justify-between border-b-2 border-[rgb(255,100,0)] p-5 text-5xl text-white">
                    <h5 class="max-sm:text-3xl max-md:text-4xl md:text-5xl">Creación de Producto </h5>
                    <button type="button" class="hover:text-[rgb(255,100,0)] rotate-45 transform duration-300 hover:-rotate-45" data-te-modal-dismiss ><i class='bx bx-cross'></i></i></button>
                </div>
                <div class="relative p-5 min-[0px]:overflow-y-auto flex max-md:flex-col gap-5">
                    <div class="max-md:w-full md:w-[40%]">
                        <form action="../../ctrlProductos" method="post" enctype="multipart/form-data" class="text-white text-base flex flex-col gap-3">
                            <div class="flex flex-col w-full gap-1">
                                <label for="">Nombre:</label>
                                <input type="text" id="produNom" class="outline-none border  p-2 bg-neutral-950 " name="nombreProducto" value="" required>
                            </div>
                            <div class="flex flex-col w-full gap-1">
                                <label for="">Descripción:</label>
                                <textarea cols="30" id="produDesc" class="outline-none border min-h-[80px] p-2 bg-neutral-950 " name="descripcionProducto"required></textarea>
                            </div>
                            <div class="flex gap-3">
                                <div class="flex flex-col w-full gap-1">
                                    <label for="">Marca:</label>
                                    <select class="outline-none border p-2  bg-neutral-950 " name="marcaProducto" required>
                                        <%  if (marcas.isEmpty()) {  %>
                                            <option value="" disabled selected hidden>No hay marcas registradas</option>  
                                         <% } else {
                                                for (Marca marca : marcas) { %> 
                                                    <option value="<%= marca.getId() %>"><%= marca.getNombre() %></option>   
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
                                                <option value="<%= cate.getId() %>"><%= cate.getNombre() %></option>
 
                                            <% }
                                            }
                                            %>
                                    </select>
                                </div>
                            </div>
                            <div class="flex flex-col gap-3">
                                <div class="flex flex-col w-full gap-1">
                                    <label for="precio">Precio:</label>
                                    <input type="number" id="produPrec" min="0" value="0" step="any" id="precio" name="precioProducto" class="outline-none border pl-2 py-2 bg-neutral-950" required value="">
                                </div>
                                
                                <div class="flex flex-col w-full gap-1">
                                    <label for="descuento">Descuento:</label>
                                    <input type="number" min="0" value="0" max="1" step="0.01" name="descuentoProducto" id="descuento" class="outline-none border pl-2 py-2 bg-neutral-950" required value="">
                                </div>
                            </div>
                            <div class="flex flex-col w-full gap-1">
                                <label for="">Especificaciones:</label>
                                <span class="">Separe cada especificacion con "-"</span>
                                <textarea id="textEspecificaciones" cols="30" class="outline-none min-h-[120px] border p-2 bg-neutral-950 " name="especificacionesProducto" required></textarea>
                            </div>
                            <div class="flex flex-col w-full gap-1">
                                <label for="">Imagen referencial:</label>
                                <input id="file-input-1" type="file" name="imgProducto" onchange="mostrarImagen(this);" class="file-select" required>
                            </div>
                            <input type="submit" name="InsertarProducto" value="Insertar Producto" class="bg-white cursor-pointer text-xl text-black p-2 rounded-tl-lg rounded-br-lg hover:bg-cyan-300 transform duration-200 mt-3">
                        </form>
                    </div>
                    <div class="relative max-md:w-full md:w-[60%] flex flex-col gap-5 items-center">
                        <span class="text-3xl text-white">Imagen Referencial:</span>
                        <div class="relative flex-col bg-stone-950  flex items-center justify-center max-sm:w-full max-w-[400px] sm:w-[400px] min-h-[500px] filter hover:saturate-200 transform duration-200 space-y-2 border py-2">
                            <img src="" id="imgReferencial" width="220" height="240" class="">
                            <h3 id="NomProdu" class="text-white text-xl text-center w-full overflow-hidden"></h3>
                            <span class="text-white text-base text-center">Precio: S/ <span id="PrecProdu" class="text-white text-base text-center"></span></span>
                            <textarea class="w-full h-[59px] resize-none text-white p-3 bg-transparent outline-none text-center" name="" readonly  id="DescProdu"></textarea>
                            <div class="w-full relative flex justify-center gap-x-3 pt-3">
                                <button class="text-white border rounded-tl-md rounded-br-md flex items-center justify-center hover:bg-rojo-rgb hover:text-white transform duration-200 p-2">Ver detalles</button>
                                <button class="text-white border text-xl hover:bg-cyan-400 flex items-center justify-center hover:text-black transform duration-200 p-2"><i class='bx bx-cart-alt'></i></button>
                            </div>
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
              var img = document.getElementById('imgReferencial');
              img.src = e.target.result;
            };
    
            r.readAsDataURL(input.files[0]);
          }
        }
        const textarea = document.getElementById("textEspecificaciones");
        textarea.addEventListener("input", function (event) {
            const lines = event.target.value.split("\n");
            const lastLine = lines[lines.length - 1];
            if (lastLine.trim() !== "" && !lastLine.startsWith("-")) {
                lines.pop();
                event.target.value = lines.join("\n");
            }
        });

        function actualizar(target) {
            const input = this;
            const span = document.getElementById(target);
            span.textContent = input.value;
        }

        const inputNom = document.getElementById("produNom");
        inputNom.addEventListener("input", actualizar.bind(inputNom, "NomProdu"));

        const inputPrec = document.getElementById("produPrec");
        inputPrec.addEventListener("input", actualizar.bind(inputPrec, "PrecProdu"));

        const textarea1 = document.getElementById("produDesc");
        const textarea2 = document.getElementById("DescProdu");

        textarea1.addEventListener("input", function() {
            textarea2.value = textarea1.value;
            ajustarAltura(textarea2);
        });

        function ajustarAltura(textarea) {
            textarea.style.height = "auto"; 
            let h = textarea.scrollHeight;
            textarea.style.height = h + "px"; 
        }
    </script>
 <jsp:include page="../Components/ModalNav.jsp"/>   
<jsp:include page="../../Templates/Footer.jsp"/> 
