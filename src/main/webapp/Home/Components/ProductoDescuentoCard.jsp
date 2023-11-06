<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="relative bg-stone-950 flex max-lg:flex-col lg:flex-row transition-all duration-300 group items-center justify-center w-full h-auto filter hover:saturate-200 transform gap-5 p-3 border">
    <img src="${param.url}" alt="" width="220" height="240" class="">
    <div class="flex flex-col gap-2">
        <h3 class="text-white text-3xl text-center group-hover:text-orange-500 transform duration-300">${param.nombre}</h3>
        <span class="text-white text-xl ">Precio Normal: $/${param.precio}
        </span>
        <span class="text-white text-xl ">Precio con Descuento: $/${param.descuento}
        </span>
        <span class="text-white text-xl max-lg:border-b border-orange-600 pb-3">Te ahorras: $/${param.ahorro}
        </span>
        <p class="text-white text-base w-full max-h-[100px] overflow-y-auto scrollbar-thin scrollbar-track-black scrollbar-thumb-orange-500">${param.descripcion}</p>
    </div>
    <div class="relative flex justify-center items-center gap-x-3 p-2">
        <a href="Detalle.jsp?id=${param.id}" class="text-white border rounded-tl-md rounded-br-md flex items-center justify-center hover:bg-rojo-rgb hover:text-white transform duration-200 p-2 whitespace-nowrap">Ver detalles</a>     
    </div>
    <span class="absolute max-lg:top-0 lg:top-1/4 right-0 bg-orange-600 max-lg:text-base lg:text-xl text-white px-3 py-1 transition-all duration-300">${param.porcentaje}</span>
</div>