<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<section id="Contacto" class="mt-[60px] filter saturate-150">
    <div class="flex flex-col justify-center items-center">
        <div class="w-full text-center mb-5 space-y-4">
            <jsp:include page="Glitch.jsp"/> 
            <p class="text-2xl text-slate-400 p-2 font-light">"Donde la excelencia se convierte en tecnología"</p>    
            <ul class="flex flex-wrap w-full items-center justify-center gap-5 sm:text-xl text-white p-4">
                <li class="hover:text-[rgb(255,100,0)] transform duration-200">
                    <a href="">
                        <i class="fa-brands fa-facebook"></i> Facebook
                    </a>
                </li>
                <li class="hover:text-[rgb(255,100,0)] transform duration-200">
                    <a href="">
                        <i class="fa-brands fa-instagram"></i> Instagram
                    </a>
                </li>
                <li class="hover:text-[rgb(255,100,0)] transform duration-200">
                    <a href="">
                        <i class="fa-brands fa-tiktok"></i> Tik Tok
                    </a>
                </li>
                <li class="hover:text-[rgb(255,100,0)] transform duration-200">
                    <a href="">
                        <i class="fa-brands fa-whatsapp"></i> WhatsApp
                    </a>
                </li>
            </ul>
        </div>
        <div class="grid gap-3 sm:gap-0 sm:grid-cols-2">
            <div class=" flex flex-col space-y-3 text-center">
                <h2 class="text-white text-4xl">Contáctanos</h2>
                <p class="px-8 text-slate-300 text-xl">¿Tienes alguna pregunta? Estamos aquí para ayudarte. En Paragon, damos la mejor atención y asesoramiento sobre nuestros productos</p>
            </div>
            <div class="">
                <form action="" class=" space-y-6">
                    <div class="flex flex-col gap-1 px-6 text-white">
                        <label class="" for="">Nombre</label>
                        <input class="outline-none p-4 border h-[50px] focus:border-[rgb(255,100,0)] transform duration-300 bg-transparent " type="text">
                    </div>
                    <div class="flex flex-col gap-1 px-6 text-white">
                        <label class="" for="">Correo</label>
                        <input class="outline-none p-4 border h-[50px] focus:border-[rgb(255,100,0)] transform duration-300 bg-transparent " type="text">
                    </div>
                    <div class="flex flex-col gap-1 px-6 text-white">
                        <label class="" for="">Mensaje</label>
                        <textarea class="outline-none p-4 border focus:border-[rgb(255,100,0)] transform duration-300 bg-transparent" name="" id="" cols="30" rows="4"></textarea>
                    </div>
                    <div class="w-full flex justify-start px-6">
                        <button class="text-white text-xl h-[50px] w-full border border-black rounded-tl-xl rounded-br-xl bg-[rgb(255,100,0)] hover:bg-cyan-400 hover:text-black transform duration-300">Enviar Mensaje</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>