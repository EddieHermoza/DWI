<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String url = request.getContextPath();
%>
<%@ page import="DAO.ProductosDAO" %>
<%@ page import="DAO.MarcasDAO" %>
<%@ page import="DAO.ComentariosDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Modelos.Producto" %>
<%@ page import="Modelos.Marca" %>
<%@ page import="Modelos.Usuario" %>
<% 
    Usuario u = (Usuario) session.getAttribute("usuario");

    int id = Integer.parseInt(request.getParameter("id"));

    MarcasDAO mDAO=new MarcasDAO();
    ProductosDAO produDAO = new ProductosDAO();
    ComentariosDAO comentarioDAO = new ComentariosDAO();
    Producto produ=produDAO.ObtenerProducto(id);
    ArrayList<Producto> productosParecidos = produDAO.ProductosParecidos(produ.getCategoria(),produ.getId());
    Marca marca=mDAO.ObtenerMarca(produ.getMarca());

    int calificacionProm=comentarioDAO.PromedioProducto(produ.getId());
%>
<jsp:include page="../Templates/Head.jsp"/> 

    <jsp:include page="Components/NavClient.jsp"/>
    <main class="flex flex-col items-center">
        <section class="mt-[120px]">
            <h2 class=" max-sm:text-2xl max-md:text-4xl md:text-5xl my-10 text-white text-center"><%= produ.getNombre() %></h2>
            <div class="grid items-start md:grid-cols-2 justify-center">
                <div class="relative bg-neutral-950 justify-between flex flex-col h-[600px] p-5">
                    <div class="flex items-center justify-start gap-3">
                        <span class="max-sm:text-base sm:text-base md:text-xl text-white">Calificación:</span>
                        <ul class="flex gap-3 max-sm:text-base sm:text-base md:text-xl">
                            <% for(int i=0;i < calificacionProm ; i++ ){ %>
                                <li><i class="text-orange-600 fa-solid fa-star"></i></li>
                            <% } %>
                        </ul>
                    </div>
                    <div class="carrito-noti hidden text-3xl text-white absolute top-2 right-3"><i class="fa-solid fa-spinner animate-spin"></i></div>
                    <img class=" filter saturate-200 flex mx-auto justify-self-center w-[400px] h-[400px]" src="<%= produ.getImg() %>" width="400" height="400">
                    <span class="text-white text-2xl w-full px-4"> Marca del producto: <a href="Marcas.jsp?id=<%= marca.getId() %>" class="hover:text-[rgb(255,100,0)] transform duration-300"><%= marca.getNombre() %></a></span>
                    <div class="flex p-4 gap-2 justify-self-end">
                        <button data-producto="<%= id %>" class="carrito-boton relative text-xl border text-white flex gap-4 items-center rounded-tl-xl rounded-br-xl justify-center p-2 w-full transform duration-200 hover:bg-cyan-400 hover:text-black" type="button">Añadir al carrito<i class='text-2xl bx bx-cart-alt'></i></button>
                    </div>
                </div>
                <div class="flex flex-col gap-5 md:border-l p-5 bg-neutral-950 min-h-[600px]">
                    <span class="text-white text-3xl justify-self-center ">Precio: $/<%= produ.getPrecio() %></span>
                    <% if(produ.getDescuento()>0) { %>
                    <span class="text-cyan-400 text-xl justify-self-center ">Con Membresía: $/<%= produ.PrecioConDescuento() %></span>
                    <% } %>
                    <span class="text-[rgb(250,100,0)] text-3xl justify-self-center text-center ">Descripción</span>
                    <p class="text-xl text-slate-200 text-justify"><%= produ.getDescripcion() %></p>
                    <div class="flex flex-col gap-5 ">
                        <span class="text-[rgb(250,100,0)] text-3xl text-center">Especificaciones</span>
                        <ul class="flex text-xl text-slate-300 flex-col gap-3 p-2">
                            <% for (String espec : produ.FormatearEspecs()) { %>
                                <li><%= espec %></li> 
                            <% } %>
                        </ul>
                    </div>
                </div>
            </div>
        </section>
        <% if (u!=null && !u.getCorreo().isBlank() ) {  %>
            <button class="bg-[rgb(255,100,0)] px-5 py-3 text-2xl text-white hover:saturate-200 filter transform duration-300 mx-auto mt-10" data-te-toggle="modal" data-te-target="#ModalComentario" data-te-ripple-init>Agregar un Comentario al <%= produ.getNombre() %></button>
        <% } %> 
        <section class="mt-[120px] flex flex-col items-center gap-7 justify-center">
            <h2 class="text-5xl text-center text-[rgb(255,100,0)] p-2">Otros Productos parecidos</h2>
            <div class="container flex flex-wrap justify-center items-center gap-5">
            <% if(!productosParecidos.isEmpty()) { %>
                <% for(Producto p: productosParecidos) { %>
                    <div class="filter hover:saturate-200 bg-stone-950 relative rounded-md flex flex-col items-center justify-between  border h-[500px] w-[400px]">
                        <img src="<%= p.getImg() %>" alt="">
                        <span class="text-2xl text-white truncate text-center p-2"><%= p.getNombre() %></span>
                        <a class="relative flex justify-center items-center border w-full p-2 text-xl text-white transform duration-300 hover:bg-[rgb(255,100,0)]" href="Detalle.jsp&id=<%= p.getId() %>">Ver más...</a>
                    </div>
                <% } %>
            <% } else { %>
                <span class="text-2xl text-white w-full text-center">No hay Otros Productos Parecidos Disponibles :[</span>
            <% } %>
            </div>
        </section>
    </main>
    <div data-te-modal-init class="fixed left-0 top-0 z-[1055] hidden h-full w-full overflow-y-auto overflow-x-hidden outline-none" id="ModalComentario" tabindex="-1" aria-labelledby="ModalComentario" aria-hidden="true">
        <div data-te-modal-dialog-ref class="relative w-auto translate-y-[-50px] opacity-0 transition-all duration-300 ease-in-out min-[0px]:m-0 min-[0px]:h-full min-[0px]:max-w-none flex items-center">
            <div class="relative flex gap-5 items-center max-w-[400px] w-full h-auto flex-col bg-black outline-none border-[rgb(255,100,0)] m-auto border-2 p-2 rounded">
                <div class="w-full flex flex-shrink-0 items-center justify-between p-2 text-xl text-white">
                    <h5>Agrega un Comentario  </h5>
                    <button type="button" class="hover:text-[rgb(255,100,0)] rotate-45 transform duration-300 hover:-rotate-45 text-3xl" data-te-modal-dismiss ><i class='bx bx-cross'></i></i></button>
                </div>
                <form action="../ctrlComentarios" method="POST" class="w-full relative flex flex-col items-center justify-center gap-2" autocomplete="off">
                    <p class="clasificacion">
                        <input id="radio1" type="radio" name="calificacion" value="5"><!--
                        --><label for="radio1">★</label><!--
                        --><input id="radio2" type="radio" name="calificacion" value="4"><!--
                        --><label for="radio2">★</label><!--
                        --><input id="radio3" type="radio" name="calificacion" value="3"><!--
                        --><label for="radio3">★</label><!--
                        --><input id="radio4" type="radio" name="calificacion" value="2"><!--
                        --><label for="radio4">★</label><!--
                        --><input id="radio5" type="radio" name="calificacion" value="1"><!--
                        --><label for="radio5">★</label>
                      </p>
                      <input type="hidden" name="idproducto" value="<%=produ.getId() %>">
                    <label for="" class="flex flex-col gap-2 text-white">
                        <textarea name="comentario" id="" cols="24" rows="6" class="bg-transparent w-full outline-none border border-white focus:border-orange-600 p-2 text-white transform duration-300"></textarea>
                    </label>
                    <input type="submit" name="Agregar" autocomplete="off" value="Agregar Comentario" class="bg-white text-black w-[300px] cursor-pointer text-xl px-4 py-2 hover:bg-cyan-400 filter transform duration-200">
                </form>
            </div>
        </div>
    </div>
    <jsp:include page="Components/ModalNav.jsp"/>
    <jsp:include page="Components/ModalCarrito.jsp"/>
    <jsp:include page="Components/ModalBuscador.jsp"/>

<jsp:include page="../Templates/Footer.jsp"/> 
