<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<jsp:include page="../Templates/Head.jsp"/> 
    <jsp:include page="Components/NavClient.jsp"/>
    <main>
        <section class="mt-[100px]">
            <h2 class="text-5xl mb-5 text-white px-5">Combos Especiales</h2>
            <p class="text-xl text-slate-400 px-5 mb-5">¿Por qué comprar las cosas por separado cuando puedes tenerlas en un combo?</p>
            <div class="flex flex-wrap items-center justify-center gap-10 sm:px-10">
                <jsp:include page="Components/ComboCard.jsp">
                    <jsp:param name="id" value="1" />
                </jsp:include>
                <jsp:include page="Components/ComboCard.jsp">
                    <jsp:param name="id" value="2" />
                </jsp:include>
                <jsp:include page="Components/ComboCard.jsp">
                    <jsp:param name="id" value="3" />
                </jsp:include>          
            </div>
        </section>
        <jsp:include page="Components/SectionMembresia.jsp"/> 
    </main>
    <jsp:include page="Components/ModalNav.jsp"/>
    <jsp:include page="Components/ModalCarrito.jsp"/>
    <jsp:include page="Components/ModalBuscador.jsp"/>

<jsp:include page="../Templates/Footer.jsp"/> 
