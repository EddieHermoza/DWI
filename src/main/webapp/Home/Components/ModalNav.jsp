<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Modelos.Usuario" %>
<%@ page import="Modelos.Carro" %>
<%@ page import="DAO.MarcasDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Modelos.Marca" %>
<%@ page import="DAO.CategoriasDAO" %>
<%@ page import="Modelos.Categoria" %>
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
%>
<div data-te-modal-init class="fixed top-0 left-0 z-[1055] hidden h-full w-full" id="modalNavBar" tabindex="-1" aria-labelledby="rightBottomModalLabel" aria-hidden="true">
    <div data-te-modal-dialog-ref class="absolute top-0 right-0 h-full w-full translate-x-[100%] bg-black transition-all duration-300 sm:max-w-[640px]">
        <div class="relative " data-te-modal-body-ref>
            <div class="flex flex-col relative w-full text-white">
                <div class="flex justify-between items-center p-5">
                    <h2 class="text-5xl">Paragon</h2>
                    <button class="text-5xl rotate-45 hover:-rotate-45 hover:text-orange-600 transform duration-300" type="button" data-te-modal-dismiss data-te-ripple-init><i class='bx bx-cross'></i></i></button> 
                </div>
                <div>
                    <div class="px-5 py-3">
                        <form action="Search.jsp" method="post" class="w-full flex justify-between gap-3">
                            <input type="text" class="outline-none bg-neutral-950 border w-full text-white focus:border-[rgb(255,100,0)] transform duration-200 h-[40px] p-2" name="keyword">
                            <button type="submit"  class="flex text-3xl items-center transform duration-200 hover:text-[rgb(255,100,0)]"><i class='bx bx-search'></i></button>
                        </form>
                    </div>
                    <div id="accordionExample">
                        <div class="">
                            <button class="group relative text-xl flex gap-2 w-full items-center p-5 transition [&:not([data-te-collapse-collapsed])]:text-orange-600" type="button" data-te-collapse-init data-te-collapse-collapsed data-te-target="#collapseUser" aria-expanded="false" aria-controls="collapseUser">
                            <i class="fa-solid fa-user"></i>Mi Sesión
                            <i class="fa-solid fa-chevron-up group-[[data-te-collapse-collapsed]]:rotate-0 [&:not([data-te-collapse-collapsed])]:rotate-180 transform duration-300"></i>
                            </button>
                            <div id="collapseUser"  class="!visible hidden" data-te-collapse-item aria-labelledby="headingUser" data-te-parent="#accordionExample">
                                <div class="px-5 py-2 flex flex-col flex-wrap gap-3 bg-neutral-950">
                                    <% if (esCliente) { %>
                                        <a href="Cuenta.jsp" class="text-xl flex items-center justify-center text-center h-[40px] w-full hover:bg-[rgb(255,120,0)]">Mi Cuenta</a>
                                        <form action="../ctrlSession" method="POST" class="w-full cursor-pointer">
                                            <input type="submit" value="Cerrar Sesión" class="cursor-pointer text-xl flex items-center justify-center text-center h-[40px] w-full hover:bg-[rgb(255,120,0)]">
                                        </form>
                                    <% } else { %>
                                        <a href="Login.jsp" class="text-xl flex items-center justify-center text-center h-[40px] w-full hover:bg-[rgb(255,120,0)]">Iniciar Sesión</a>
                                        <a href="Register.jsp" class="text-xl flex items-center justify-center text-center h-[40px] w-full hover:bg-[rgb(255,120,0)]">Registrarse</a>
                                    <% } %>
                                </div>
                            </div>
                        </div>
                        <div class="">
                            <button class="group relative text-xl flex gap-2 w-full items-center p-5 transition [&:not([data-te-collapse-collapsed])]:text-orange-600" type="button" data-te-collapse-init data-te-collapse-collapsed data-te-target="#collapseMarcas" aria-expanded="false" aria-controls="collapseMarcas">
                            <i class="fa-solid fa-laptop"></i> Marcas  
                            <i class="fa-solid fa-chevron-up group-[[data-te-collapse-collapsed]]:rotate-0 [&:not([data-te-collapse-collapsed])]:rotate-180 transform duration-300"></i>
                            </button>
                            <div id="collapseMarcas"  class="!visible hidden" data-te-collapse-item aria-labelledby="headingMarcas" data-te-parent="#accordionExample">
                                <div class="px-5 py-2 flex flex-col flex-wrap gap-3 bg-neutral-950">
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
                        <div class="">
                            <button  class="group relative text-xl flex gap-2 w-full items-center p-5 transition [&:not([data-te-collapse-collapsed])]:text-orange-600"  type="button" data-te-collapse-init data-te-collapse-collapsed data-te-target="#collapseCategorias" aria-expanded="false" aria-controls="collapseCategorias">
                            <i class='bx bxs-category'></i>Categorias  
                            <i class="fa-solid fa-chevron-up group-[[data-te-collapse-collapsed]]:rotate-0 [&:not([data-te-collapse-collapsed])]:rotate-180 transform duration-300"></i>
                            </button>
                            <div id="collapseCategorias"  class="!visible hidden" data-te-collapse-item aria-labelledby="headingCategorias" data-te-parent="#accordionExample">
                                <div class="px-5 py-2 flex flex-col flex-wrap gap-3 bg-neutral-950">
                                    <% if(categorias.isEmpty()) { %>
                                        <span class="text-xl text-white">No hay Categorias disponibles</span>
                                    <% } else { %>
                                        <%  for(Categoria cate : categorias) { %> 
                                            <a href="../Home/Categorias.jsp?id=<%= cate.getId()%>" class="text-xl transform duration-200 relative text-white hover:text-[rgb(255,100,0)]"><%= cate.getNombre()%> </a>
                                        <% } %>
                                    <% } %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
