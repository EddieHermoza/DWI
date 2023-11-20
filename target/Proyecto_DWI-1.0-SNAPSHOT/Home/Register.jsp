<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<% 
    String err= (String) session.getAttribute("errorRegister");  
%>

<jsp:include page="../Templates/Head.jsp"/> 
<jsp:include page="Components/NavClient.jsp"/>
<main>
    <section id="Login">
        <div class="flex flex-col items-center justify-center min-h-screen bg-[url('../images/banners/ParagonBanner.webp')] bg-cover bg-center">
            <h2 class="text-4xl mt-[70px] text-white text-shadow shadow-rojo-rgb/80 text-center">Crea tu cuenta</h2>

            <form action="../ctrlRegister" method="POST" class="h-auto w-auto bg-stone-950 bg-opacity-90 flex flex-col">
                <jsp:include page="Components/Glitch.jsp"/> 
                <div class="flex flex-col gap-5 p-6">
                    <div class="flex flex-col gap-1">
                        <label for="" class="text-white">Nombres</label>
                        <input type="text" name="nombresRegister" class="w-full text-white h-[40px] outline-none bg-stone-900 focus:bg-black border border-stone-900 p-2 focus:border-[rgb(255,100,0)] transform duration-300">    
                    </div>
                    <div class="flex flex-col gap-1">
                        <label for="" class="text-white">Apellidos</label>
                        <input type="text" name="apellidosRegister" class="w-full text-white h-[40px] outline-none bg-stone-900 focus:bg-black border border-stone-900 p-2 focus:border-[rgb(255,100,0)] transform duration-300">    
                    </div>
                    <div class="flex flex-col gap-1">
                        <label for="" class="text-white">Correo Electrónico</label>
                        <input type="email" name="correoRegister" class="w-full text-white h-[40px] outline-none bg-stone-900 focus:bg-black border border-stone-900 p-2 focus:border-[rgb(255,100,0)] transform duration-300">    
                    </div>
                    <div class="flex flex-col gap-1">
                        <label for="" class="text-white">Número Telefonico</label>
                        <input type="text" name="numeroRegister" class="w-full text-white h-[40px] outline-none bg-stone-900 focus:bg-black border border-stone-900 p-2 focus:border-[rgb(255,100,0)] transform duration-300">    
                    </div>
                    <div class="flex flex-col gap-1">
                        <label for="" class="text-white">Contraseña</label>
                        <input type="password" name="contraRegister" class="w-full text-white  h-[40px] outline-none bg-stone-900 focus:bg-black border border-stone-900 p-2 focus:border-[rgb(255,100,0)] transform duration-300">
                    </div>
                    <% if (err != null && !err.isBlank()) { %>
                        <span class="w-full text-center text-xs text-red-600"><%= err %></span>
                    <% } %>
                    <div class="flex pt-5 items-center justify-between gap-5">
                        <a href="Login.jsp" class="text-black text-center whitespace-nowrap bg-white border w-1/2 flex items-center justify-center rounded-tl-lg p-2 rounded-br-xl h-[50px] hover:bg-black hover:text-white transform duration-200">INICIAR SESIÓN</a>
                        <input type="submit" value="REGISTRARSE" class="cursor-pointer text-white flex items-center w-1/2 justify-center rounded-tl-lg p-2 rounded-br-xl bg-red-600 h-[50px] hover:bg-cyan-400 hover:text-black transform duration-200">
                    </div>
                </div>
            </form>

        </div>
    </section>
</main>
<jsp:include page="Components/ModalNav.jsp"/>
<jsp:include page="Components/ModalCarrito.jsp"/>
<jsp:include page="Components/ModalBuscador.jsp"/>
<jsp:include page="../Templates/Footer.jsp"/> 