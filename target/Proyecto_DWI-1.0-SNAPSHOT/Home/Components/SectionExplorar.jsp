<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<section id="Explorar" class="mt-[140px] flex justify-center ">
    <div class="flex flex-col gap-5 justify-center">
        <div class="relative flex flex-col items-center justify-center text-center">
            <h2 class="max-sm:text-3xl sm:text-5xl text-white">EXPLORAR</h2>
            <p class="max-sm:text-base sm:text-xl text-slate-400 text-center p-2">Nuestra excelencia como tienda se refleja en lo que le ofrecemos a los clientes.</p>
        </div>
        <div class="grid grid-rows-6 gap-2 md:grid-rows-4 h-[1300px] max-w-[1400px] w-full">
            <div class="row-span-3 gap-2 md:row-span-2 grid grid-rows-3 md:grid-rows-none md:grid-cols-4 ">
                <div class="col-span-3 gap-2 md:col-span-2 grid row-span-2 md:row-span-3 md:grid-rows-2">
                    <jsp:include page="SectionExplorarCard.jsp">
                        <jsp:param name="titulo" value="Combos especiales" />
                        <jsp:param name="descripcion" value="¿Por qué comprar las cosas por separado cuando puedes tenerlas en un combo?" />
                        <jsp:param name="imgurl" value="../images/Ofertas.webp"/>
                        <jsp:param name="url" value="Combos.jsp"/>
                    </jsp:include>
                    <jsp:include page="SectionExplorarCard.jsp">
                        <jsp:param name="titulo" value="Lo Más Vendido" />
                        <jsp:param name="descripcion" value="Productos que, sorprendentemente, otros clientes también están comprando." />
                        <jsp:param name="imgurl" value="../images/MasVendido.webp"/>
                        <jsp:param name="url" value="MasVendido.jsp"/>
                    </jsp:include>
                </div>
                <div class="col-span-3 md:col-span-2 row-span-3">
                    <jsp:include page="SectionExplorarCard.jsp">
                        <jsp:param name="titulo" value="Ultimas Adquisiciones" />
                        <jsp:param name="descripcion" value="Donde mostramos lo último... hasta que llegue algo nuevo y mejor" />
                        <jsp:param name="imgurl" value="../images/NuevasAdquisiciones.webp"/>
                        <jsp:param name="url" value="Adquisiciones.jsp"/>
                    </jsp:include>
                </div>
            </div>
            <div class=" row-span-2 md:row-span-1 gap-2 grid grid-rows-2 md:grid-rows-none grid-cols-1 md:grid-cols-3">
                <div class="col-span-1">
                    <jsp:include page="SectionExplorarCard.jsp">
                        <jsp:param name="titulo" value="¿Quienes Somos?" />
                        <jsp:param name="descripcion" value="Descubre quienes estan detras de Paragon" />
                        <jsp:param name="imgurl" value="../images/QuienesSomos.webp"/>
                        <jsp:param name="url" value="About.jsp"/>
                    </jsp:include>
                </div>
                <div class="col-span-2">
                    <jsp:include page="SectionExplorarCard.jsp">
                        <jsp:param name="titulo" value="Reseñas y Comentarios" />
                        <jsp:param name="descripcion" value="Desde el exagerado hasta el crítico profesional, aquí encontrarás muchas opiniones" />
                        <jsp:param name="imgurl" value="../images/Reseñas-Coment.webp"/>
                        <jsp:param name="url" value="Testimonios.jsp"/>
                    </jsp:include>
                </div>
            </div>
            <jsp:include page="SectionExplorarCard.jsp">
                <jsp:param name="titulo" value="Productos en Descuento" />
                <jsp:param name="descripcion" value="Con descuentos tan bajos que te harán cuestionar la realidad." />
                <jsp:param name="imgurl" value="../images/ProductosDescuentos.webp"/>
                <jsp:param name="url" value="Descuentos.jsp"/>
            </jsp:include>
        </div>
    </div>
</section>