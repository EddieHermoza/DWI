<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<a href="${param.url}" class="w-full h-full group rounded-md relative flex flex-col items-center overflow-hidden justify-center space-y-3 transform duration-300 filter saturate-150" >
    <h3 class="text-white text-center max-md:text-2xl text-3xl z-10 text-shadow-lg shadow-black">${param.titulo}</h3>
    <p class=" text-white text-center max-sm:hidden max-md:text-base md:text-xl  w-4/5 z-10 text-shadow-lg shadow-black">${param.descripcion}</p>
    <img class="absolute object-cover object-center group-hover:scale-110 transform duration-300 -z-10 w-full h-full" src="${param.imgurl}" alt="" srcset="">
</a>