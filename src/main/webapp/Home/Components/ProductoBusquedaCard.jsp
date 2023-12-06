<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="relative bg-neutral-950 flex max-lg:flex-col group items-center justify-center w-full h-auto filter hover:saturate-200 transform duration-200 gap-5 p-4 max-sm:border-b sm:border">
    <img src="${param.url}" alt="" width="220" height="240" class="">
    <div class="relative flex flex-col gap-3">
        <h3 class="text-white text-xl group-hover:text-orange-500 transform duration-300">${param.nombre}</h3>
        <span class="text-white text-base group relative  group-hover:text-cyan-400 transform duration-300 px-2 overflow-x-hidden">Precio: $/${param.precio}
            <span class="animation-underline bg-cyan-400"></span>
        </span>
        <p class="text-white text-base w-full max-h-[100px] overflow-y-hidden " >${param.descripcion}</p>
    </div>
    <div class="relative flex justify-center items-center gap-x-3 p-2">
        <a href="Detalle.jsp?id=${param.id}" class="text-white border rounded-tl-md rounded-br-md flex items-center justify-center hover:bg-rojo-rgb hover:text-white transform duration-200 p-2 whitespace-nowrap">Ver detalles</a>
        <button data-producto="${param.id}" type="submit" class="carrito-boton text-white border text-xl hover:bg-cyan-400 flex items-center justify-center hover:text-black transform duration-200 p-2"><i class='bx bx-cart-alt'></i></button>     
    </div>
</div>