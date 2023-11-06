<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  String url = request.getContextPath(); 
%>
<section class="relative w-[260px] hidden lg:flex">
    <div class="sticky top-[5%] w-[260px] h-[800px] bg-black px-2">
        <ul class="w-full text-xl text-white flex flex-col items-center border-[rgb(255,100,0)] border">
            <li class=" w-full h-[80px]">
                <a class="w-full h-full flex items-center justify-center text-center hover:bg-[rgb(255,100,0)] transform duration-150 tracking-wide p-2 gap-2" href="<%=url %>/Admin/"><i class="fa-solid fa-chart-line"></i> Dashboard</a>
            </li>
            <li class=" w-full h-[80px]">
                <a class="w-full h-full flex items-center justify-center text-center hover:bg-[rgb(255,100,0)] transform duration-150 tracking-wide p-2 gap-2" href="<%=url %>/Admin/Productos/"><i class="fa-solid fa-computer"></i> Productos</a>
            </li>
            <li class=" w-full h-[80px]">
                <a class="w-full h-full flex items-center justify-center text-center hover:bg-[rgb(255,100,0)] transform duration-150 tracking-wide p-2 gap-2" href="<%=url %>/Admin/Inventario/"><i class="fa-solid fa-box"></i> Inventario</a>
            </li>
            <li class=" w-full h-[80px]">
                <a class="w-full h-full flex items-center justify-center text-center hover:bg-[rgb(255,100,0)] transform duration-150 tracking-wide p-2 gap-2" href="<%=url %>/Admin/Marcas/"><i class="fa-solid fa-laptop"></i> Marcas</a>
            </li>
            <li class=" w-full h-[80px] ">
                <a class="w-full h-full flex items-center justify-center text-center hover:bg-[rgb(255,100,0)] transform duration-150 tracking-wide p-2 gap-2" href="<%=url %>/Admin/Categorias/"><i class='bx bxs-category'></i> Categorías</a>
            </li>
            <li class=" w-full h-[80px] ">
                <a class="w-full h-full flex items-center justify-center text-center hover:bg-[rgb(255,100,0)] transform duration-150 tracking-wide p-2 gap-2" href="<%=url %>/Admin/Promociones/"><i class="fa-solid fa-gift"></i>Promociones</a>
            </li>
            <li class=" w-full h-[80px] ">
                <a class="w-full h-full flex items-center justify-center text-center hover:bg-[rgb(255,100,0)] transform duration-150 tracking-wide p-2 gap-2" href="<%=url %>/Admin/Clientes/"><i class="fa-regular fa-user"></i> Clientes</a>
            </li>
            <li class=" w-full h-[80px] ">
                <a class="w-full h-full flex items-center justify-center text-center hover:bg-[rgb(255,100,0)] transform duration-150 tracking-wide p-2 gap-2" href="<%=url %>/Admin/Ventas/"><i class="fa-regular fa-file"></i> Ventas</a>
            </li>
            <li class=" w-full h-[80px] ">
                <a class="w-full h-full flex items-center justify-center text-center hover:bg-[rgb(255,100,0)] transform duration-150 tracking-wide p-2 gap-2" href="<%=url %>/Admin/Administradores/"><i class='bx bx-shield-quarter'></i> Administradores</a>
            </li>
        </ul>

        <form action="<%=url %>/ctrlSession" method="post" class="w-full mt-5 flex items-center justify-center">
            <input type="submit" value="Cerrar Sesión" class="cursor-pointer border text-white px-5 py-1 rounded-tl-lg rounded-br-lg hover:border-orange-500 hover:bg-orange-500 transform duration-300">
        </form>
    </div>
</section>