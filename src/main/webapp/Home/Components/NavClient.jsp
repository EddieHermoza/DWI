<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Modelos.Usuario" %>
<%@ page import="Modelos.Carro" %>
<%@ page import="DAO.MarcasDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Modelos.Marca" %>
<%@ page import="DAO.CategoriasDAO" %>
<%@ page import="Modelos.Categoria" %>
<%@ page import="Utilidades.Funciones" %>

<%
    String rutaRela = request.getContextPath(); 
    Usuario u = (Usuario) session.getAttribute("usuario");
    Carro carrito = (Carro) session.getAttribute("carro");

    boolean esCliente = (u != null && u.getRol().equals("cliente"));
%>
<% 
    MarcasDAO marcaDAO = new MarcasDAO();
    ArrayList<Marca> marcas = marcaDAO.Listar();

    CategoriasDAO cateDAO = new CategoriasDAO();
    ArrayList<Categoria> categorias = cateDAO.Listar();

    String urlActual = request.getRequestURL().toString();
    boolean pagina1 =Funciones.URLcontiene(urlActual,"Carrito.jsp");
    boolean pagina2 =Funciones.URLcontiene(urlActual,"Pago.jsp");
%>

<header class="w-full fixed top-0 z-50">
    <nav id="navCliente" class="w-full h-[50px] z-50 justify-between text-white flex flex-row items-center bg-black filter saturate-[3]">
        <h1 class="text-3xl mx-5 z-50"><a href="<%= rutaRela %>/Home/"> Paragon</a></h1>
        <div class=" w-full flex flex-row items-center justify-between">
            <ul class="space-x-4 justify-start ">
                <li class="max-md:hidden md:inline-block group relative hover:text-[rgb(255,100,0)]">
                    <span class="flex cursor-default text-xl items-center">Categorias <i class='cursor-default text-2xl transform duration-200 border-transparent group-hover:rotate-180 bx bxs-chevron-up'></i></span>
                    <div class="absolute -z-50 -left-[143%] transform duration-200 -top-[300px] group-hover:-top-[40px] overflow-hidden bg-neutral-950 w-[105vw] bg-opacity-90">
                        <div class="flex w-full justify-center mt-[100px] p-10">
                            <div class="flex flex-wrap gap-10">
                                <% if(categorias.isEmpty()) { %>
                                    <span class="text-xl text-white">No hay categorias disponibles</span>
                                <% } else { %>
                                  <%  for(Categoria cate : categorias) { %> 
                                    <a href="../Home/Categorias.jsp?id=<%= cate.getId()%>" class="text-xl transform duration-200 text-white hover:text-[rgb(255,100,0)]"><%= cate.getNombre()%></a>
                                   <% } %>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </li>
                <li class="max-md:hidden md:inline-block group relative hover:text-[rgb(255,100,0)]">
                    <span class="flex cursor-default text-xl items-center">Marcas <i class='cursor-default text-2xl transform duration-200 group-hover:rotate-180 bx bxs-chevron-up'></i></span>
                    <div class=" absolute -z-50 -left-[343%] transform duration-200 -top-[400px] group-hover:-top-[45px] overflow-hidden bg-neutral-950 w-[105vw] bg-opacity-90">
                        <div class="flex w-full justify-center mt-[100px] p-10">
                            <div class="flex flex-wrap gap-10">
                                <% if(marcas.isEmpty()) { %>
                                    <span class="text-xl text-white">No hay marcas disponibles</span>
                                <% } else { %>
                                    <%  for(Marca marca : marcas) { %> 
                                        <a href="../Home/Marcas.jsp?id=<%= marca.getId()%>" class="text-xl transform duration-200 relative text-white hover:text-[rgb(255,100,0)]"><%= marca.getNombre()%> </a>
                                    <% } %>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </li>
                <li class="max-md:hidden md:inline-block transform relative duration-200 hover:text-[rgb(255,100,0)]">
                    <a href="index.jsp#Contacto" class="text-xl">Contáctanos</a>
                </li>
            </ul>
            <div class="relative w-auto flex justify-end items-center space-x-4 mx-4">
                <button class="max-lg:hidden lg:flex text-3xl items-center transform duration-200 hover:text-[rgb(255,100,0)]"
                 data-te-toggle="modal" data-te-target="#BuscadorModal" data-te-ripple-init data-te-ripple-color="light">
                    <i class='bx bx-search'></i>
                </button>
                <% if (!pagina1 && !pagina2) { %>
                    <button class="flex relative items-center text-3xl transform duration-200 hover:text-[rgb(255,100,0)]" data-te-toggle="modal" data-te-target="#modalCart" data-te-ripple-init data-te-ripple-color="light">
                        <i class='bx bx-cart-alt'></i>
                        <% if(carrito !=null){ %>
                            <span class="text-white text-base p-1" id="carritoCantidad"><%= carrito.getListaDeProductos().size() %> </span>
                        <% } else { %>
                            <span id="carritoCantidad">0</span>
                        <% } %>
                    </button>
                <% } %>    
                <button class="mr-4 block lg:hidden text-3xl transform duration-200 hover:text-[rgb(255,100,0)] hover:scale-125" 
                    data-te-toggle="modal" data-te-target="#modalNavBar" data-te-ripple-init data-te-ripple-color="light">
                    <i class='bx bx-menu-alt-right'></i>
                </button>       
                <div class="max-lg:hidden lg:flex items-center group cursor-pointer ">
                    <i class='text-3xl group-hover:text-[rgb(255,100,0)] transform duration-200 bx bx-user'></i>
                    <div class="hidden fixed right-2 top-[40px]  bg-black group-hover:block">
                        <div class="w-[120px] flex flex-col items-center">
                            <% if (esCliente) { %>
                                <a href="Cuenta.jsp" class="text-sm flex items-center justify-center text-center h-[40px] w-full hover:bg-[rgb(255,120,0)]">Mi Cuenta</a>
                                <form action="../ctrlSession" method="POST" class="w-full cursor-pointer">
                                    <input type="submit" value="Cerrar Sesión" class="cursor-pointer text-sm flex items-center justify-center text-center h-[40px] w-full hover:bg-[rgb(255,120,0)]">
                                </form>
                            <% } else { %>
                                <a href="Login.jsp" class="text-sm flex items-center justify-center text-center h-[40px] w-full hover:bg-[rgb(255,120,0)]">Iniciar Sesión</a>
                                <a href="Register.jsp" class="text-sm flex items-center justify-center text-center h-[40px] w-full hover:bg-[rgb(255,120,0)]">Registrarse</a>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </nav>
</header>