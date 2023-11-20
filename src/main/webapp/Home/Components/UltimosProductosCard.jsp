<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div class="relative flex-col bg-neutral-900 group  flex items-center justify-center w-full h-[500px] filter hover:saturate-200 transform duration-200 gap-3 p-4">
    <img src="${param.url}" alt="" width="220" height="240" class="">
    <h3 class="text-white text-xl w-full group-hover:text-orange-500 transform duration-300">${param.nombre}</h3>
    <span class="text-white text-xl w-full group relative">Precio: $/${param.precio}
        <span class="animation-underline bg-white"></span>
    </span>
    <p class="text-white text-base w-full truncate">${param.descripcion}</p>
    <div class="w-full relative flex justify-center gap-x-3 pt-3">
        <a href="Detalle.jsp?id=${param.id}" class="text-white border rounded-tl-md rounded-br-md flex items-center justify-center hover:bg-rojo-rgb hover:text-white transform duration-200 p-2">Ver detalles</a>
    </div>
    <% if (request.getParameter("descuento") != null && !request.getParameter("descuento").trim().isEmpty()) { %>
        <span class="absolute top-2 left-5 text-orange-500 text-base"><%= request.getParameter("descuento") %> con Membresía</span>
    <% } %>
</div>
