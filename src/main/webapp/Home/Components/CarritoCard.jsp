<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div class="w-full relative flex justify-between max-sm:flex-col gap-1 p-2 border-b h-auto bg-black rounded-md">
    <div class="flex items-center gap-2">
        <img src="${param.img}" height="140" width="140" alt="">
        <div class="flex flex-col gap-2 text-white">
            <span class="sm:text-xl max-sm:text-base">${param.nombre}</span>

            <div class="flex justify-between sm:items-center  text-white gap-3 border rounded-sm px-2 py-1 max-sm:w-[120px] sm:w-[180px] relative">
                <button data-producto="${param.id}" type="submit" class="quitar-btn hover:text-[rgb(255,100,0)] transform duration-300 text-xl w-[20%]">
                    <i class="fa-solid fa-minus"></i>
                </button>
                <input type="number" readonly name="" id="" value="${param.cantidad}" class="cantidad-input h-[30px] w-[60%] text-center outline-none bg-neutral-950">
                <button data-producto="${param.id}" type="submit" class="añadir-btn hover:text-[rgb(255,100,0)] transform duration-300 text-xl text-white w-[20%]">
                    <i class="fa-solid fa-plus"></i>
                </button>
            </div>

        </div>
    </div>
    <div class=" flex flex-col justify-end items-end text-white">
        <span class="line-through text-white ahorro">${param.ahorro}</span>
        <span class="inline-block text-orange-600">$/<span class="subtotal">${param.subtotal}</span></span>
    </div>
    <button data-producto="${param.id}" class="eliminar-btn absolute top-1/2 -translate-y-1/2 right-3 text-white text-xl hover:text-[rgb(255,100,0)] transform duration-300">
        <i class="fas fa-trash"></i>
    </button>
</div>