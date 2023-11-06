<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="../Templates/Head.jsp"/> 

        <jsp:include page="Components/NavClient.jsp"/>

        <main>
            <jsp:include page="Components/SectionPortada.jsp"/> 
            <jsp:include page="Components/SectionCategorias.jsp"/>
            <jsp:include page="Components/SectionExplorar.jsp"/>       
            <jsp:include page="Components/SectionMembresia.jsp"/>
            <jsp:include page="Components/SectionContacto.jsp"/>    
        </main>
        <jsp:include page="Components/ModalNav.jsp"/>
        <jsp:include page="Components/ModalCarrito.jsp"/>
        <jsp:include page="Components/ModalBuscador.jsp"/>

<jsp:include page="../Templates/Footer.jsp"/> 
