<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<% String carosuelID= "carousel"+ request.getParameter("id"); %>
<% String carouselTarget ="#carousel" +request.getParameter("id"); %>

<div class="bg-stone-950 flex max-md:flex-col items-center justify-center w-full gap-5 sm:p-10">
    <div class="relative h-[340px] flex justify-center items-center">
        <button  
            class="text-white text-2xl h-full w-[10%] group"
            data-te-target="<%= carouselTarget %>"
            data-te-slide="prev">
            <i class="fa-solid fa-chevron-left group-hover:text-rojo-rgb transform duration-300"></i>
        </button>
        <div id="<%= carosuelID %>" class="relative flex items-center justify-center h-[340px] w-[340px] filter saturate-200" data-te-carousel-init data-te-ride="carousel">
            <!--Carrusel-->
            <div class="relative w-full overflow-hidden after:clear-both after:block after:content-['']">
                <!--Primer item-->
                <div class="relative group float-left -mr-[100%] w-full transition-transform duration-[300ms] ease-in-out motion-reduce:transition-none" data-te-carousel-active data-te-carousel-item style="backface-visibility: hidden">
                    <img src="../images/Monitor.png" class="group-hover:opacity-40 h-full w-full transform duration-300"  alt="..." />
                    <div class="absolute -bottom-20 left-0 w-full h-20 bg-black/30  transform duration-300 group-hover:bottom-0 ">
                        <div class="relative h-full flex flex-col items-center justify-center">
                            <span class="text-xl text-orange-500 text-center">Nombre del producto</span>
                            <span class="text-base text-white text-center">p/u: $/100</span>
                        </div>
                    </div>
                </div>
                <!--Segundo item-->
                <div class="relative group float-left -mr-[100%] hidden w-full transition-transform duration-[300ms] ease-in-out motion-reduce:transition-none" data-te-carousel-item style="backface-visibility: hidden">
                    <img  src="../images/Monitor.png" class="group-hover:opacity-40 h-full w-full transform duration-300"  alt="..." />
                    <div class="absolute -bottom-20 left-0 w-full h-20 bg-black/30  transform duration-300 group-hover:bottom-0 ">
                        <div class="relative h-full flex flex-col items-center justify-center">
                            <span class="text-xl text-orange-500 text-center">Nombre del producto</span>
                            <span class="text-base text-white text-center">p/u: $/100</span>
                        </div>
                    </div>
                </div>
                <!--Tercer item-->
                <div class="relative group float-left -mr-[100%] hidden w-full transition-transform duration-[300ms] ease-in-out motion-reduce:transition-none"  data-te-carousel-item style="backface-visibility: hidden">
                    <img  src="../images/Monitor.png"  class="group-hover:opacity-40 h-full w-full transform duration-300"  alt="..." />
                    <div class="absolute -bottom-20 left-0 w-full h-20 bg-black/30 transform duration-300 group-hover:bottom-0 ">
                        <div class="relative h-full flex flex-col items-center justify-center">
                            <span class="text-xl text-orange-500 text-center">Nombre del producto</span>
                            <span class="text-base text-white text-center">p/u: $/100</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <button
            class="text-white text-2xl h-full w-[10%] group"
            data-te-target="<%= carouselTarget %>"
            data-te-slide="next">
            <i class="fa-solid fa-chevron-right group-hover:text-rojo-rgb transform duration-300"></i>
        </button>
    </div>

    <div class="relative flex flex-col items-center justify-center space-y-3">
        <span class="text-white text-2xl text-center">Nombre de la promocion</span>
        <p class="text-slate-400 text-center text-base">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Velit et neque est quia doloribus modi eaque perferendis iure blanditiis pariatur?</p>
        <span class="text-base text-center text-white">Precio de la promoción: $/1000</span>
        <a href="" class="w-1/2 text-white bg-rojo-rgb text-center rounded-tl-lg rounded-br-lg text-xl p-1 transform duration-500 hover:bg-cyan-400 hover:text-black">Ver más</a>
    </div>
</div>