<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  String url = request.getContextPath(); 
%>
<div class="fixed top-0 justify-center items-center w-screen h-screen bg-black/90 hidden lg:hidden" id="mobileNav">
    <div class="flex flex-col w-full items-center bg-transparent">
        <ul class="text-xl text-white flex flex-col items-center w-full">
            <li class=" w-full">
                <a class="w-full h-full flex items-center hover:bg-[rgb(255,100,0)] transform duration-150 tracking-wide py-4 px-10 gap-2" href="<%=url %>/Admin/"><i class="fa-solid fa-chart-line"></i> Dashboard</a>
            </li>
            <li class=" w-full">
                <a class="w-full h-full flex items-center hover:bg-[rgb(255,100,0)] transform duration-150 tracking-wide  py-4 px-10 gap-2" href="<%=url %>/Admin/Productos/"><i class="fa-solid fa-computer"></i> Productos</a>
            </li>
            <li class=" w-full ">
                <a class="w-full h-full flex items-center hover:bg-[rgb(255,100,0)] transform duration-150 tracking-wide  py-4 px-10 gap-2" href="<%=url %>/Admin/Inventario/"><i class="fa-solid fa-box"></i> Inventario</a>
            </li>
            <li class=" w-full ">
                <a class="w-full h-full flex items-center hover:bg-[rgb(255,100,0)] transform duration-150 tracking-wide  py-4 px-10 gap-2" href="<%=url %>/Admin/Marcas/"><i class="fa-solid fa-laptop"></i> Marcas</a>
            </li>
            <li class=" w-full">
                <a class="w-full h-full flex items-center hover:bg-[rgb(255,100,0)] transform duration-150 tracking-wide  py-4 px-10 gap-2" href="<%=url %>/Admin/Categorias/"><i class='bx bxs-category'></i> Categorías</a>
            </li>
            <li class=" w-full">
                <a class="w-full h-full flex items-center hover:bg-[rgb(255,100,0)] transform duration-150 tracking-wide  py-4 px-10 gap-2"href="<%=url %>/Admin/Promociones/"><i class="fa-solid fa-gift"></i>Promociones</a>
            </li>
            <li class=" w-full">
                <a class="w-full h-full flex items-center hover:bg-[rgb(255,100,0)] transform duration-150 tracking-wide  py-4 px-10 gap-2" href="<%=url %>/Admin/Clientes/"><i class="fa-regular fa-user"></i> Clientes</a>
            </li>
            <li class=" w-full ">
                <a class="w-full h-full flex items-center hover:bg-[rgb(255,100,0)] transform duration-150 tracking-wide py-4 px-10 gap-2"href="<%=url %>/Admin/Ventas/"><i class="fa-regular fa-file"></i> Ventas</a>
            </li>
            <li class=" w-full ">
                <a class="w-full h-full flex items-center hover:bg-[rgb(255,100,0)] transform duration-150 tracking-wide  py-4 px-10 gap-2"href="<%=url %>/Admin/Administradores/"><i class='bx bx-shield-quarter'></i> Administradores</a>
            </li>
        </ul>
    
        <form action="<%=url %>/ctrlSession" method="post" class="w-full mt-5 flex items-center px-10">
            <input type="submit" value="Cerrar Sesión" class="cursor-pointer border text-white px-5 py-1 rounded-tl-lg rounded-br-lg hover:border-orange-500 hover:bg-orange-500 transform duration-300">
        </form>
    </div>
</div>
<div class="fixed bottom-5 right-5 max-lg:flex lg:hidden">
    <button class="text-white text-3xl rounded-full bg-transparent backdrop-blur-md border px-6 py-5 hover:text-orange-600 hover:border-orange-600 transform duration-300" id="mobileNavBtn">
        <i class="fa-solid fa-bars"></i>
    </button>
</div>
<script>
    const btn=document.getElementById("mobileNavBtn");
    const div=document.getElementById("mobileNav");
    btn.addEventListener("click", function() {
        if (div.classList.contains("hidden")) {
            div.classList.remove("hidden");
            div.classList.add("flex");
        } else {
            div.classList.remove("flex");
            div.classList.add("hidden");
        }
    });

</script>