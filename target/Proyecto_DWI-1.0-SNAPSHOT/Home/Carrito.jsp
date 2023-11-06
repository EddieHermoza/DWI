<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Modelos.Usuario" %>
<%@ page import="Modelos.Carro" %>
<%@ page import="Modelos.Producto" %>
<%@ page import="java.util.ArrayList" %>

<%
    String rutaRela = request.getContextPath(); 
    Usuario u = (Usuario) session.getAttribute("usuario");
    Carro carrito = (Carro) session.getAttribute("carro");

    boolean esCliente = (u != null && u.getRol().equals("cliente"));

    
    if (carrito.getListaDeProductos().size() == 0) {
        response.sendRedirect("index.jsp");
    }
%>
<jsp:include page="../Templates/Head.jsp"/> 

    <jsp:include page="Components/NavClient.jsp"/>

    <main>
        <section class="pt-[50px] bg-neutral-950">
            <div class="min-h-[calc(100vh-120px)] w-full relative sm:p-5 flex max-lg:flex-col max-lg:items-center max-lg:justify-start lg:justify-center gap-5 max-sm:py-2">
                <div class="max-lg:w-full lg:w-1/2 max-w-[700px] space-y-5">
                    <% for (Producto pro : carrito.getListaDeProductos()) { %>
                        <jsp:include page="Components/CarritoCard.jsp">
                            <jsp:param name="id" value="<%= pro.getId() %>"/>
                            <jsp:param name="img" value="<%= pro.getImg() %>" />
                            <jsp:param name="nombre" value="<%= pro.getNombre() %>" />
                            <jsp:param name="cantidad" value="<%= pro.getCantidad() %>"/>
                            <jsp:param name="ahorro" value='<%= (u != null && u.getRol().equals("cliente")) ? (pro.Ahorro() * pro.getCantidad()) : "" %>'/>
                            <jsp:param name="subtotal" value='<%= (u != null && u.getRol().equals("cliente")) ? (pro.PrecioConDescuento() * pro.getCantidad()) : (pro.getPrecio() * pro.getCantidad()) %>'/>
                        </jsp:include>
                    <% } %>
                </div>
                <div class="max-lg:w-full lg:w-1/2 max-w-[700px]">
                    <div class="flex flex-col gap-5 items-center bg-black border rounded-sm p-2">
                        <span class="max-sm:text-2xl max-md:text-3xl md:text-4xl text-white w-full">Procesar Pago</span>
                        <% if(esCliente) { %>
                        <span class="text-xl text-orange-600 w-full">(Descuentos Aplicados)</span>
                        <% } %>
                        <div class="relative w-full flex justify-between max-sm:text-xl max-md:text-2xl md:text-3xl text-slate-300 border-b p-2">
                            <span>Total:</span>
                            <% if(esCliente) { %>
                                <span id="Monto">$/ <%= carrito.MontoDescontado() %></span>
                            <% } else { %>
                                <span id="Monto">$/ <%= carrito.Monto() %></span>
                            <% } %>
                        </div>
                        <a href="Pago.jsp" class="text-center text-xl w-full p-2 bg-orange-600 text-white hover:bg-white hover:text-black transform duration-300">Proceder a Pagar</a>
                    </div>
                </div>
        </section>        
    </main>


    <Script>
        document.addEventListener('DOMContentLoaded', function() {
            const Inputs = document.querySelectorAll('.cantidad-input');
            const IncrementarBTNS = document.querySelectorAll('.añadir-btn');
            const DecrementarBTNS = document.querySelectorAll('.quitar-btn');
            const EliminarBTNS= document.querySelectorAll('.eliminar-btn');
            const Subtotales=document.querySelectorAll('.subtotal');
            const Ahorros=document.querySelectorAll('.ahorro');

            IncrementarBTNS.forEach((button, index) => {
                button.addEventListener('click', function () {
                    const productoId = this.getAttribute('data-producto');
                    Inputs[index].value = parseInt(Inputs[index].value) + 1;
                    if (productoId != null) {
                        Enviar(productoId,"añadir",Subtotales[index],Ahorros[index])
                    }
                });
            });

            DecrementarBTNS.forEach((button, index) => {
                button.addEventListener('click', function () {
                    const productoId = this.getAttribute('data-producto');
                    const newValue = parseInt(Inputs[index].value) - 1;
                    Inputs[index].value = newValue >= 1 ? newValue : 1;
                    if (productoId != null && newValue > 0) { 
                        Enviar(productoId, "quitar",Subtotales[index]);
                    }
                });
            });

            EliminarBTNS.forEach((button,index) =>{
                button.addEventListener('click',function(){
                    const productoId =this.getAttribute('data-producto');
                    if(productoId != null){
                        Enviar(productoId,"eliminar",Subtotales[index])
                    }
                })
            })
        })

        async function Enviar(id,accion,subtotal,ahorro) {
            const formData = new FormData();

            formData.append("productoId", id);
            formData.append("accion",accion);

            try {
                const response = await fetch('../ctrlCarrito', {
                    method: "POST",
                    body: formData,
                    mode:"cors"
                });

                if (response.ok) {
                    const data = await response.json();

                    if(data.message === 'añadido'){
                        const monto=document.getElementById("Monto");
                        monto.innerHTML="$/ "+data.monto;
                        subtotal.innerHTML=data.subtotal;
                        if (data.ahorro) {
                            ahorro.innerHTML=data.ahorro;
                        }
                    }
                    if (data.message === 'quitado') {
                        const monto=document.getElementById("Monto");
                        monto.innerHTML="$/ "+data.monto;
                        subtotal.innerHTML=data.subtotal;
                        if (data.ahorro) {
                            ahorro.innerHTML=data.ahorro;
                        }
                    }
                    if (data.message === 'eliminado') {
                        const monto=document.getElementById("Monto");
                        monto.innerHTML="$/ "+data.monto;
                        const div=subtotal.parentNode.parentNode.parentNode;
                        div.remove();
                    }
                } 


            } catch (error) {
                location.reload();
            }
        }

        </Script>
        <jsp:include page="Components/ModalNav.jsp"/>
        <jsp:include page="Components/ModalBuscador.jsp"/>

<jsp:include page="../Templates/Footer.jsp"/> 
