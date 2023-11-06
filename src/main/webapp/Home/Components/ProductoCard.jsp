<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div class="relative flex-col bg-neutral-900 group  flex items-center justify-center w-full h-[500px] filter hover:saturate-200 transform duration-200 space-y-2 py-2">
    <img src="${param.url}" alt="" width="220" height="240" class="">
    <div class="carrito-noti hidden text-3xl text-white absolute top-2 right-3"><i class="fa-solid fa-spinner animate-spin"></i></div>
    <h3 class="text-white text-xl text-center w-full group-hover:text-orange-500 transform duration-300 px-3">${param.nombre}</h3>
    <span class="text-white text-xl text-center group relative">Precio: $/${param.precio}
        <span class="animation-underline bg-white"></span>
    </span>
    <p class="text-white text-base text-center w-[90%] overflow-hidden max-h-[80px]">${param.descripcion}</p>
    <div class="w-full relative flex justify-center gap-x-3 pt-3">
        <a href="Detalle.jsp?id=${param.id}" class="text-white border rounded-tl-md rounded-br-md flex items-center justify-center hover:bg-rojo-rgb hover:text-white transform duration-200 p-2">Ver detalles</a>
        <button data-producto="${param.id}" type="submit" class="carrito-boton text-white border text-xl hover:bg-cyan-400 flex items-center justify-center hover:text-black transform duration-200 p-2"><i class='bx bx-cart-alt'></i></button>
    </div>
    <% if (request.getParameter("descuento") != null && !request.getParameter("descuento").trim().isEmpty()) { %>
        <span class="absolute top-2 left-5 text-orange-500 text-base"><%= request.getParameter("descuento") %> con Membresía</span>
    <% } %>
</div>
