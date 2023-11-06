<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Modelos.Usuario" %>
<%
    Usuario u = (Usuario) session.getAttribute("usuario");
%>

<header>
    <nav class="w-screen flex items-center justify-between h-[80px] bg-black ">
        <div class="w-[260px] h-full flex items-center justify-center">
            <div class="glitch h-[80px] overflow-y-hidden overflow-x-hidden relative w-full flex justify-center items-center">
                <p class="text-[50px] absolute inset-0 m-auto text-center text-shadow shadow-black" >Paragon</p>
                <p class="text-[50px] absolute inset-0 m-auto text-center ">Paragon</p>
                <p class="text-[50px] absolute inset-0 m-auto text-center">Paragon</p>
            </div>
        </div>
        <div class="max-md:hidden md:flex">
        <% if (u != null && u.getRol().equals("administrador")) { %>
            <span class="text-white text-2xl px-10"><%=u.getNombres() +" "+ u.getApellidos() %></span>
        <% } %> 
        </div>
    </nav>
</header>
