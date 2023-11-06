<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<li class="glide__slide relative h-auto my-8 flex text-white">
    <a href="../Home/Categorias.jsp?id=${param.id}" class="group bg-transparent relative flex flex-col justify-center items-center filter hover:saturate-200 hover:scale-110 transform duration-200">
        <img src="${param.img}" alt="${param.nombre}" >
        <span class="relative group text-3xl text-white transform duration-200 group-hover:text-[rgb(255,100,0)]">
            ${param.nombre}
        <span class="animation-underline bg-[rgb(255,100,0)]"></span>
        </span>
    </a>                 
</li>
