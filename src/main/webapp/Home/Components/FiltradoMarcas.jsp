<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div class="sticky top-[25vh] flex flex-col items-center space-y-8 pt-5">
    <h3 class="text-red-500 filter saturate-200 text-3xl text-center">Filtros:</h3>
    <div class="w-full flex flex-col gap-y-3">
        <button class="text-white border rounded-tl-lg rounded-br-lg hover:bg-rojo-rgb transform duration-200 h-[40px] px-2">Aplicar Filtros</button>
        <button class="text-white border rounded-tl-lg rounded-br-lg hover:bg-cyan-300 hover:text-black transform duration-200 h-[40px] px-2">Limpiar Filtros</button>
    </div>
    <div class="flex w-full space-x-2 px-2">
        <label for="" class="block text-white">Precio:</label>
        <div class="flex justify-between items-center space-x-1 w-full">
            <span class="text-base text-white">0</span>
            <input type="range" id="" name="" min="0" max="1000" step="10" class="w-full h-4 bg-white rounded-md appearance-none">
            <span class="text-base text-white">1000+</span>
        </div>
    </div>
    <div class="relative w-full px-2 border" data-te-dropdown-ref>
        <button
        class="flex items-center text-center w-full text-xl text-white hover:text-orange-600 transform duration-200" type="button" id="dropdownMenuLargeButton" data-te-dropdown-toggle-ref aria-expanded="false" data-te-ripple-init data-te-ripple-color="light"> Categorias </button>
        <ul class="absolute z-[1000] left-0 m-0 hidden w-[200px] min-w-max list-none overflow-hidden bg-white [&[data-te-dropdown-show]]:block" aria-labelledby="dropdownMenuLargeButton"data-te-dropdown-menu-ref>
            <li>
                <a class="block w-full bg-transparent" href="#" data-te-dropdown-item-ref>Categoria 1</a>
            </li>
            <li>
                <a class="block w-full  bg-transparent " href="#" data-te-dropdown-item-ref >Categoria 2</a>
            </li>
            <li>
                <a class="block w-full  bg-transparent" href="#" data-te-dropdown-item-ref>Categoria 3</a >
            </li>
        </ul>
    </div>
</div>
