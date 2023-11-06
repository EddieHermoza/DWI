<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Modelos.Usuario" %>
<%
    Usuario u = (Usuario) session.getAttribute("usuario");
    if (u == null || u.getRol().equals("cliente")) {
        response.sendRedirect("../../Home/index.jsp");
    } 
%>
<jsp:include page="../../Templates/Head.jsp"/> 

    <jsp:include page="../Components/NavAdmin.jsp"/> 
    
    <main class="w-full flex min-h-[1000px] h-[1000px] overflow-hidden">
        <jsp:include page="../Components/BarraLateral.jsp"/>
        <section class="justify-center h-full w-full bg-[rgb(20,20,20)] flex flex-col p-5 gap-10">
            <h2 class="text-5xl text-white">Promociones</h2>
            <div class="w-full h-full flex items-center justify-center p-2">
                <div class="flex w-[540px] h-full">
                    <form action="" class="text-white text-base flex flex-col gap-3">
                        <div class="flex flex-col w-full gap-1">
                            <label for="">Nombre:</label>
                            <input type="text" class="outline-none border p-2 bg-neutral-950 ">
                        </div>
                        <div class="flex flex-col w-full gap-1">
                            <label for="">Descripción:</label>
                            <textarea cols="30" class="outline-none border min-h-[80px] p-2 bg-neutral-950 "></textarea>
                        </div>
                        <div class="flex flex-col w-full gap-1">
                            <label for="">Precio:</label>
                            <input type="number" step="any" id="precio" name="precio" min="0" placeholder="" class="outline-none border pl-2 py-2 bg-neutral-950">
                        </div>
                        <div class="flex flex-col w-full gap-1">
                            <button class="p-1 rounded-tl-lg rounded-br-lg bg-orange-500 hover:saturate-200 filter trasnform duration-300 ">Agregar Producto</button>
                        </div>
                        <div class="flex flex-col w-full gap-1" id="selectContainer">

                        </div>
                        <button class="bg-white text-xl text-black p-2 rounded-tl-lg rounded-br-lg hover:bg-cyan-300 transform duration-300 hover:shadow-lg hover:shadow-black">Crear Promoción</button>
                    </form>
                </div>
                <div class="flex justify-center w-full h-full mt-16">
                    <div class="overflow-hidden">
                        <table class="min-w-full text-center text-base">
                            <thead class="border-b bg-neutral-800 text-white">
                                <tr>
                                    <th scope="col" class=" p-5">ID</th>
                                    <th scope="col" class=" p-5">Nombre</th>
                                    <th scope="col" class=" p-5">Descripción</th>
                                    <th scope="col" class=" p-5">Precio</th>
                                    <th scope="col" class=" p-5">Acciones</th>
                                </tr>
                            </thead>
                            <tbody class="text-white">
                                <tr class="border-b hover:bg-black transform duration-200">
                                    <td class="whitespace-nowrap  p-5 ">1</td>
                                    <td class="whitespace-nowrap  p-5">Cell</td>
                                    <td class="whitespace-nowrap  p-5">Cell</td>
                                    <td class="whitespace-nowrap  p-5">Cell</td>
                                    <td class="relative flex gap-1 items-center justify-center m-auto  p-5">
                                        <a href="#" class="bg-white text-black px-2 py-1 hover:bg-cyan-300 transform duration-200 rounded-tl-md rounded-br-md">Modificar</a>
                                        <a href="#" class="bg-[rgb(255,100,0)] text-white px-2 py-1 filter hover:bg-rojo-rgb transform duration-200 rounded-tl-md rounded-br-md">Eliminar</a>
                                    </td>
                                </tr>     
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </section> 
    </main>

<jsp:include page="../../Templates/Footer.jsp"/> 