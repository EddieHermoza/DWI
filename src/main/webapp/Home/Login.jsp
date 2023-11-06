<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<% 
    String err= (String) session.getAttribute("errorLogin");  

%>

<jsp:include page="../Templates/Head.jsp"/> 
<jsp:include page="Components/NavClient.jsp"/>
<main>
    <section id="Login">
        <div class="flex flex-col items-center justify-center h-[calc(100vh-70px)] bg-[url('../images/banners/ParagonBanner.webp')] bg-cover bg-center">
            <h2 class="text-4xl mt-[70px] text-white text-shadow shadow-rojo-rgb/80 text-center">Inicia Sesión</h2>
            
            <form action="../ctrlLogin" method="POST" class="h-auto w-auto bg-stone-950 bg-opacity-90 flex flex-col">
                <jsp:include page="Components/Glitch.jsp"/> 
                <div class="flex flex-col space-y-5 p-6">
                    <div class="flex flex-col space-y-2">
                        <label for="" class="text-white text-xl">Correo Electrónico</label>
                        <input required  type="email" name="correoLogin" class="w-full text-white h-[40px] outline-none bg-stone-900 focus:bg-black border p-2 focus:border-[rgb(255,100,0)] transform duration-300">    
                    </div>
                    <div class="flex flex-col space-y-2">
                        <label for="" class="text-white text-xl">Contraseña</label>
                        <input required type="password" name="contraLogin" class="w-full text-white  h-[40px] outline-none bg-stone-900 focus:bg-black border p-2 focus:border-[rgb(255,100,0)] transform duration-300">
                    </div>
                    <% if (err != null && !err.isBlank()) { %>
                        <span class="w-full text-center text-base text-red-600"><%= err %></span>
                    <% } %>
                    <div class="flex pt-7 items-center space-x-3">
                        <a href="Register.jsp" class="text-black text-center whitespace-nowrap bg-white border w-1/2 flex items-center justify-center rounded-tl-lg p-2 rounded-br-xl h-[50px] hover:bg-black hover:text-white transform duration-200">CREAR CUENTA</a>
                        <button type="submit" class="cursor-pointer text-white flex items-center w-1/2 justify-center rounded-tl-lg p-2 rounded-br-xl bg-red-600 h-[50px] hover:bg-cyan-400 hover:text-black transform duration-200"> INICIAR SESIÓN</button>
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