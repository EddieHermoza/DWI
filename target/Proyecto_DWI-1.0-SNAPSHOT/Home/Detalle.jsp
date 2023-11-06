<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String url = request.getContextPath();
%>
<%@ page import="DAO.ProductosDAO" %>
<%@ page import="DAO.MarcasDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Modelos.Producto" %>
<%@ page import="Modelos.Marca" %>

<% 
    int id = Integer.parseInt(request.getParameter("id"));

    MarcasDAO mDAO=new MarcasDAO();
    ProductosDAO produDAO = new ProductosDAO();

    Producto produ=produDAO.ObtenerProducto(id);
    Marca marca=mDAO.ObtenerMarca(produ.getMarca());
%>
<jsp:include page="../Templates/Head.jsp"/> 

    <jsp:include page="Components/NavClient.jsp"/>
    <main>
        <section class="mt-[120px]">
            <h2 class=" max-sm:text-2xl max-md:text-4xl md:text-5xl my-10 text-white text-center"><%= produ.getNombre() %></h2>
            <div class="grid items-start md:grid-cols-2 justify-center">
                <div class="relative bg-neutral-950 justify-between flex flex-col h-[600px] p-5">
                    <div class="flex items-center justify-start gap-3">
                        <span class="max-sm:text-base sm:text-base md:text-xl text-white">Calificación:</span>
                        <ul class="flex gap-3 max-sm:text-base sm:text-base md:text-xl">
                            <li><i class="text-orange-600 fa-solid fa-star"></i></li>
                            <li><i class="text-orange-600 fa-solid fa-star"></i></li>
                            <li><i class="text-orange-600 fa-solid fa-star"></i></li>
                            <li><i class="text-orange-600 fa-solid fa-star"></i></li>
                            <li><i class="text-orange-600 fa-solid fa-star"></i></li>
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
        <section class="mt-[120px] flex flex-col items-center gap-7 justify-center">
            <h2 class="text-5xl text-center text-[rgb(255,100,0)] p-2">Otros Productos parecidos</h2>
            <div class="container flex flex-wrap justify-center items-center gap-5">
                <div class="filter hover:saturate-200 bg-stone-950 relative rounded-md flex flex-col items-center justify-between  border h-[500px] w-[400px]">
                    <img src="../images/Monitor.png" alt="">
                    <span class="text-2xl text-white truncate text-center p-2">Otro Producto</span>
                    <a class="relative flex justify-center items-center border w-full p-2 text-xl text-white transform duration-300 hover:bg-rojo-rgb" href="Detalle.jsp">Ver más...</a>
                </div>
                <div class="filter hover:saturate-200 bg-stone-950 relative rounded-md flex flex-col items-center justify-between  border h-[500px] w-[400px]">
                    <img src="../images/Monitor.png" alt="">
                    <span class="text-2xl text-white truncate text-center p-2">Otro Producto</span>
                    <a class="relative flex justify-center items-center border w-full p-2 text-xl text-white transform duration-300 hover:bg-rojo-rgb" href="Detalle.jsp">Ver más...</a>
                </div>
                <div class="filter hover:saturate-200 bg-stone-950 relative rounded-md flex flex-col items-center justify-between border h-[500px] w-[400px]">
                    <img src="../images/Monitor.png" alt="">
                    <span class="text-2xl text-white truncate text-center p-2">Otro Producto</span>
                    <a class="relative flex justify-center items-center border w-full p-2 text-xl text-white transform duration-300 hover:bg-rojo-rgb" href="Detalle.jsp">Ver más...</a>
                </div>

            </div>
        </section>
    </main>
    <jsp:include page="Components/ModalNav.jsp"/>
    <jsp:include page="Components/ModalCarrito.jsp"/>
    <jsp:include page="Components/ModalBuscador.jsp"/>

<jsp:include page="../Templates/Footer.jsp"/> 
