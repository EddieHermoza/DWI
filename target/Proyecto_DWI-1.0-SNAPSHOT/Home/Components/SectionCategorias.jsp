<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="DAO.CategoriasDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Modelos.Categoria" %>

<% 
    CategoriasDAO cateDAO = new CategoriasDAO();
    ArrayList<Categoria> categorias = cateDAO.Listar();
%>

<section id="Categorias" class="mt-[140px] filter saturate-150">
    <div class="w-full relative flex flex-col items-center justify-center">
        <h2 class="max-sm:text-3xl sm:text-5xl text-white">CATEGORIAS</h2>
        <p class="max-sm:text-base sm:text-xl text-slate-400 text-center p-2">Nuestra excelencia como tienda se refleja en lo que le ofrecemos a los clientes.</p>
        <div class="glide flex flex-row  w-full">
            <div class="glide__arrows relative w-[10%]" data-glide-el="controls">
                <button class="glide__arrow glide__arrow--left w-full h-full flex justify-center items-center hover:text-orange-600" data-glide-dir="<"><i class='bx bx-chevron-left text-5xl text-white'></i></button>
            </div>
            <div class="glide__track w-[80%] overflow-x-hidden overflow-y-hidden" data-glide-el="track">
                <ul class="glide__slides flex flex-row gap-5 items-center">
                    <% if(categorias.isEmpty()) {%>
                        <span class="text-3xl text-white w-full text-center">No hay Categorias Disponibles</span>
                    <% } else {%>
                        <% for (Categoria cate : categorias) { %>
                            <jsp:include page="SectionCategoriasCard.jsp">
                                <jsp:param name="nombre" value="<%= cate.getNombre() %>" />
                                <jsp:param name="id" value="<%= cate.getId() %>"/>
                                <jsp:param name="img" value="<%= cate.getImgRef() %>"/>
                            </jsp:include>
                        <% } %>
                    <% } %>
                </ul>
            </div>
            <div class="glide__arrows relative w-[10%]" data-glide-el="controls">
                <button class="glide__arrow glide__arrow--right w-full h-full flex justify-center items-center hover:text-orange-600" data-glide-dir=">"><i class='bx bx-chevron-right text-5xl text-white'></i></button>
            </div>
        </div>
    </div>
</section>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        const config = {
            type: 'carousel',
            startAt: 0,
            perView: 5,
            breakpoints:{
                1536:{
                    perView: 4
                },
                1280:{
                    perView: 3
                },
                768:{
                    perView: 2
                },
                640:{
                    perView: 1
                }
            }
        };

        new Glide('.glide', config).mount();
    });
</script>
