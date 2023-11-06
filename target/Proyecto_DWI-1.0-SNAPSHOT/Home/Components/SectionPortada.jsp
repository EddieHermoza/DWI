<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<section id="Portada" class="filter saturate-150">  
    <div id="CarouselPortada" class="relative filter saturate-200" data-te-carousel-init data-te-ride="carousel">
        <!--Carrusel-->
        <div class="relative w-full overflow-hidden after:clear-both after:block after:content-['']">
            <!--Primer item-->
            <div class="relative float-left -mr-[100%] w-full transition-transform duration-[300ms] ease-in-out motion-reduce:transition-none" data-te-carousel-active data-te-carousel-item style="backface-visibility: hidden">
                <div class="absolute inset-x-0 top-0 h-32 bg-gradient-to-b from-black to-transparent opacity-100"></div>
                <img src="../images/banners/AERO-14-Oled.webp" class="hidden md:block w-full " alt="..." />
                <img src="../images/banners/AERO-14-Oled-mobile.webp" class="block md:hidden w-full" alt="">
                <div class="absolute inset-x-0 bottom-0 h-32 bg-gradient-to-t from-black to-transparent opacity-80"></div>
            </div>
            <!--Segundo item-->
            <div class="relative float-left -mr-[100%] hidden w-full transition-transform duration-[300ms] ease-in-out motion-reduce:transition-none" data-te-carousel-item style="backface-visibility: hidden">
                <div class="absolute inset-x-0 top-0 h-32 bg-gradient-to-b from-black to-transparent opacity-100"></div>
                <img  src="../images/banners/ASUSmonitor.webp" class="hidden md:block w-full " alt="..." />
                <img src="../images/banners/ASUSmonitor-mobile.webp" class="block md:hidden w-full" alt="">
                <div class="absolute inset-x-0 bottom-0 h-32 bg-gradient-to-t from-black to-transparent opacity-80"></div>
            </div>
            <!--Tercer item-->
            <div class="relative float-left -mr-[100%] hidden w-full transition-transform duration-[300ms] ease-in-out motion-reduce:transition-none"  data-te-carousel-item style="backface-visibility: hidden">
                <div class="absolute inset-x-0 top-0 h-32 bg-gradient-to-b from-black to-transparent opacity-100"></div>
                <img  src="../images/banners/aorus-17-15.webp"  class="hidden md:block w-full" alt="..." />
                <img src="../images/banners/aorus-17-15-mobile.webp" class="block md:hidden w-full" alt="">
                <div class="absolute inset-x-0 bottom-0 h-32 bg-gradient-to-t from-black to-transparent opacity-80"></div>
            </div>
            <div class="relative float-left -mr-[100%] hidden w-full transition-transform duration-[300ms] ease-in-out motion-reduce:transition-none"  data-te-carousel-item style="backface-visibility: hidden">
                <div class="absolute inset-x-0 top-0 h-32 bg-gradient-to-b from-black to-transparent opacity-100"></div>
                <img  src="../images/banners/HEROS-3.webp"  class="hidden md:block w-full" alt="..." />
                <img src="../images/banners/HEROS-3-mobile.webp" class="block md:hidden w-full" alt="">
                <div class="absolute inset-x-0 bottom-0 h-32 bg-gradient-to-t from-black to-transparent opacity-80"></div>
            </div>
        </div>
        <!--anterior-->
        <button  
            class="absolute bottom-0 left-0 top-0 z-[1] flex w-[15%]"
            type="button"
            data-te-target="#CarouselPortada"
            data-te-slide="prev">
        </button>
        <!--siguiente-->
        <button
            class="absolute bottom-0 right-0 top-0 z-[1] flex w-[15%]"
            type="button"
            data-te-target="#CarouselPortada"
            data-te-slide="next">
        </button>
    </div>
</section>