<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<jsp:include page="../Templates/Head.jsp"/> 
    <jsp:include page="Components/NavClient.jsp"/>
    <main>
        <section class="mt-[100px]">
            <h2 class="text-5xl text-white px-5 mb-5">Reseñas y Comentarios.</h2>
            <div class="grid max-xl:grid-cols-1 xl:grid-cols-2 grid-flow-row gap-8 w-full p-5">
                <% for(int i=0;i< 7; i++){   %>
                <jsp:include page="Components/TestimonioCard.jsp">
                    
                    <jsp:param name="usuario" value="Usuario " />          
                    <jsp:param name="comentario" value="Lorem ipsum dolor sit, amet consectetur adipisicing elit. Asperiores minima provident amet? Consequuntur doloribus voluptate recusandae non autem at officia." />
                    <jsp:param name="img" value="../images/Monitor.png"/>
                    <jsp:param name="fecha" value="12-12-2023"/>
                    <jsp:param name="calificacion" value="5"/>
                </jsp:include>
                <% } %>
            </div>
        </section>
        <jsp:include page="Components/SectionMembresia.jsp"/> 
    </main>
    <jsp:include page="Components/ModalNav.jsp"/>
    <jsp:include page="Components/ModalCarrito.jsp"/>
    <jsp:include page="Components/ModalBuscador.jsp"/>

<jsp:include page="../Templates/Footer.jsp"/> 
