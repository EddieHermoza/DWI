<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String url = request.getContextPath();
%>
<jsp:include page="../Templates/Head.jsp"/> 

        <jsp:include page="Components/NavClient.jsp"/>
        <main>
            <section>

                <div class="group">
                     <div class="group-focus:bg-sky-400">

                     </div>
                </div>
                <div class="bg-cover bg-top w-full h-[700px] bg-[url('../images/banners/ParagonBanner.webp')]">

                </div>
            </section>
            <section class="mt-[50px] pb-5">
                <jsp:include page="Components/Glitch.jsp"/>
                <div class="mt-[50px] flex relative items-center justify-center">
                    <div class="grid max-xl:grid-rows-2 xl:grid-cols-2 sm:px-10 md:px-16 lg:px-20">
                        <div class="grid max-lg:grid-rows-2 max-lg:grid-cols-1 lg:grid-cols-2">
                            <div class="flex flex-col bg-[rgb(255,100,0)] filter saturate-150 space-y-3 h-96 items-center justify-center p-5 ">
                                <i class="text-5xl text-white fa-solid fa-people-group"></i>
                                <span class="text-white text-2xl">¿Quienes Somos?</span>
                                <p class="text-center text-xl text-white"> Lorem ipsum dolor sit amet consectetur adipisicing elit. Unde accusamus doloribus facere perspiciatis neque, nostrum ratione possimus ex ad hic.</p>
                            </div>
                            <div class="flex flex-col space-y-3 h-96 items-center justify-center p-5 ">
                                <i class="text-5xl text-white fas fa-rocket"></i>
                                <span class="text-white text-2xl">Nuestra Misión</span>
                                <p class="text-center text-xl text-white">Lorem ipsum dolor sit amet consectetur adipisicing elit. Incidunt optio obcaecati tempore distinctio impedit maiores repellat, id illo perferendis consequuntur?</p>
                            </div>
                        </div>
                        <div class="grid max-lg:grid-rows-2 max-lg:grid-cols-1 lg:grid-cols-2">
                            <div class="flex flex-col bg-[rgb(255,100,0)] filter saturate-150 space-y-3 h-96 items-center justify-center p-5 ">
                                <i class="text-white text-5xl fas fa-eye"></i>
                                <span class="text-white text-2xl">Nuestra Visión</span>
                                <p class="text-center text-xl text-white">Lorem ipsum dolor sit amet consectetur adipisicing elit. Rerum error inventore accusantium maiores ipsa eveniet obcaecati. Eum sunt mollitia asperiores?</p>
                            </div>
                            <div class="flex flex-col space-y-3 h-96 items-center justify-center p-5 ">
                                <i class="text-white text-5xl fa-solid fa-users"></i>
                                <span class="text-white text-2xl">Nuestro Compromiso</span>
                                <p class="text-center text-xl text-white">Lorem ipsum dolor sit amet consectetur adipisicing elit. Rerum delectus minus a totam iure, fugiat magni quod nulla eligendi itaque?</p>
                            </div>
                        </div>
                    </div>
                </div> 
            </section>
            <jsp:include page="Components/SectionMembresia.jsp"/>
        </main>
        <jsp:include page="Components/ModalNav.jsp"/>
        <jsp:include page="Components/ModalCarrito.jsp"/>
        <jsp:include page="Components/ModalBuscador.jsp"/>
<jsp:include page="../Templates/Footer.jsp"/> 
