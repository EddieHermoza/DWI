<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="relative filter hover:saturate-200 transform duration-200  max-sm:flex-col flex items-center bg-stone-950 gap-5 p-4 w-full">
    <img src="${param.img}" width="200" height="200" alt="">
    <div class="flex flex-col gap-3 w-full">
        <div class="flex justify-between w-full">
            <span class="text-white text-2xl">${param.usuario}</span>
            <a href="Detalle.jsp?id=${param.idproducto}" class="transform duration-200 hover:bg-white hover:text-black border px-3 text-xl text-white rounded-tl-md rounded-br-md justify-end">Ver producto</a>
        </div>
        <span class="text-base text-slate-400">${param.fecha}</span>
        <ul class="flex space-x-2">
            <% for (int i = 1; i <= Integer.parseInt(request.getParameter("calificacion")); i++) { %>
                <li><i class="text-[rgb(255,100,0)] fa-solid fa-star"></i></li>
            <% } %>
        </ul>
        <p class="text-white text-base">${param.comentario}</p>
    </div>
</div>