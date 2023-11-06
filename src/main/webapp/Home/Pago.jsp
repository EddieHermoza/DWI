<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Modelos.Usuario" %>
<%@ page import="Modelos.Cliente" %>
<%@ page import="Modelos.Carro" %>
<%@ page import="Modelos.Producto" %>
<%@ page import="DAO.UsuariosDAO" %>
<%@ page import="java.util.ArrayList" %>

<%
    String rutaRela = request.getContextPath(); 
    Usuario u = (Usuario) session.getAttribute("usuario");
    Carro carrito = (Carro) session.getAttribute("carro");
    Cliente c=new Cliente();
    boolean esCliente = (u != null && u.getRol().equals("cliente"));

    if (carrito.getListaDeProductos().size() == 0) {
        response.sendRedirect("index.jsp");
    }
    UsuariosDAO uDAO=new UsuariosDAO();
    if(esCliente){
        c=uDAO.ObtenerCliente(u.getId());
    }
%>
<jsp:include page="../Templates/Head.jsp"/> 
<jsp:include page="Components/NavClient.jsp"/>
<main>
    <section class="pt-[50px] bg-neutral-950">
        <div class="w-full min-h-[calc(100vh-120px)] sm:p-5 flex max-lg:flex-col-reverse max-lg:items-center justify-center relative gap-5">
            <div class="max-lg:w-full lg:w-1/2 max-w-[500px] space-y-5 flex flex-col text-white items-center border p-3 bg-black">
                <span class="text-3xl w-full text-center">Información de entrega</span>
                <div class="w-full flex gap-3 justify-center">
                    <label class="cursor-pointer">
                        <input type="radio" class="peer sr-only" name="entrega" checked id="Recojo"/>
                        <div class="transform rounded-sm bg-transparent border px-5 py-2 text-center hover:saturate-150 filter text-white duration-300 peer-checked:bg-white peer-checked:text-black">
                            <span>Recojo en Tienda</span>
                        </div>
                    </label>
                </div>
                <form action="../ctrlPago" method="post" id="FormContacto"  class="text-base flex flex-col gap-3 w-full px-5">
                    <span class="text-xl">Información de Contacto</span>
                    <div class="flex max-lg:flex-col gap-3 w-full">
                        <label for="" class="flex flex-col">
                            Nombres:
                            <input name="contactoNombres" required type="text" class="outline-none bg-neutral-900 border focus:bg-transparent focus:border-orange-600 transform duration-300 p-2"
                                <% if (esCliente) { %>
                                    readonly="readonly" value="<%= u.getNombres() %>"
                                <% } %>
                            >
                        </label>
                        <label for="" class="flex flex-col">
                            Apellidos :
                            <input name="contactoApellidos" required type="text" class="outline-none bg-neutral-900 border focus:bg-transparent focus:border-orange-600 transform duration-300 p-2" 
                                <% if (esCliente) { %>
                                    readonly="readonly" value="<%= u.getApellidos() %>"
                                <% } %>
                            >
                        </label>
                    </div>
                    <label for="" class="flex flex-col">
                        Correo Electrónico :
                        <input name="contactoCorreo" required type="text" class="outline-none bg-neutral-900 border focus:bg-transparent focus:border-orange-600 transform duration-300 p-2"
                            <% if (esCliente) { %>
                                readonly="readonly" value="<%= u.getCorreo() %>"
                            <% } %>
                        >
                    </label>
                    <label for="" class="flex flex-col">
                        Telefono :
                        <input name="contactoTelefono" required type="text" class="outline-none bg-neutral-900 border focus:bg-transparent focus:border-orange-600 transform duration-300 p-2"
                            <% if (esCliente) { %>
                                readonly="readonly" value="<%= c.getTelefono() %>"
                            <% } %>
                        >
                    </label>
                    <span class="text-xl text-rojo-rgb w-full text-center" id="errorSpan"></span>
                </form>
                <div class="w-full px-5">
                    <button id="pagarBTN"  class="bg-orange-600 px-5 py-3 w-full rounded-sm text-xl hover:bg-white hover:text-black transform duration-300">Pagar con otro método <i class="fa-solid fa-check"></i></button>
                </div> 
                <div class="relative px-5 py-1 h-auto w-full bg-slate-200 z-10">
                    <div id="paypal-button-container"></div>
                </div> 
            </div>
            <div class="max-lg:w-full lg:w-1/2 h-auto max-w-[800px] text-white flex flex-col gap-5 items-center p-3 bg-black">
                <div class="w-full flex justify-center">
                    <span class="text-2xl">Información de Compra</span>
                </div>
                <div class="bg-neutral-950 w-full max-h-[500px] overflow-y-auto scrollbar-track-black scrollbar-thumb-orange-600 scrollbar-thin flex flex-col ">
                    <% for(Producto pro : carrito.getListaDeProductos()) {%>
                    <div class=" relative flex items-center p-3 gap-1 border-b border-orange-600">
                        <span class="text-xl"><%= pro.getCantidad() %>x</span>
                        <img src="<%= pro.getImg() %>" width="100" height="100" alt="">
                        <span class="text-base"><%= pro.getNombre() %></span>
                        <% if(esCliente){ %>
                        <span class="absolute text-base top-2 right-2 line-through ">$/<%= pro.getPrecio()*pro.getCantidad() %></span>
                        <span class="max-lg:text-base lg:text-xl absolute bottom-2 right-2 text-orange-600">$/<%= pro.PrecioConDescuento()*pro.getCantidad() %></span>
                        <% } else { %>
                            <span class="max-lg:text-base lg:text-xl absolute top-3 right-2">$/<%= pro.getPrecio()*pro.getCantidad() %></span>
                        <% } %>
                    </div>
                    <% } %>
                </div>
                <div class="w-full flex flex-col gap-5 text-xl">
                    <div class="flex justify-between">
                        <span>Total sin Decuento:</span>
                        <span>$/<%= carrito.Monto() %></span>
                    </div>
                    <div class="flex justify-between">
                        <span>Descuento total:</span>
                        <% if(esCliente){ %>
                            <span>$/<%= carrito.AhorroTotal() %></span>
                        <% } else { %>
                            <span>$/0</span>
                        <% } %>
                    </div>
                    <div class="flex justify-between bg-white text-black p-2">
                        <span>TOTAL A PAGAR:</span>
                        <% if(esCliente) { %>
                            <span>$/<%= carrito.MontoDescontado() %></span>
                        <% } else { %>
                            <span>$/<%= carrito.Monto() %></span>
                        <% } %>
                    </div>
                    <a href="Carrito.jsp" class=" rounded-tl-lg rounded-br-lg w-full p-2 text-2xl text-center text-white bg-orange-600 hover:text-black hover:bg-cyan-400 transform duration-300">Modificar Carrito</a>
                </div>
            </div>
        </div>
    </section>
</main>
<script>
        const btn=document.getElementById('pagarBTN');
        btn.addEventListener('click', Enviar);

        async function Enviar() {
            const formulario = document.getElementById('FormContacto');
            const err = document.getElementById('errorSpan');

            const nombresInput = formulario.querySelector('[name="contactoNombres"]');
            const apellidosInput = formulario.querySelector('[name="contactoApellidos"]');
            const correoInput = formulario.querySelector('[name="contactoCorreo"]');
            const telefonoInput = formulario.querySelector('[name="contactoTelefono"]');

            if ( nombresInput.value.trim() === '' || apellidosInput.value.trim() === '' || correoInput.value.trim() === '' || telefonoInput.value.trim() === '') {
                err.innerHTML = 'No deje los campos vacíos';
                return;
            }

            const formData = new FormData(formulario);

            formData.append("metodo", "OTROS");

            try {
                const response = await fetch('../ctrlPago', {
                    method: "POST",
                    body: formData,
                });

                if (response.ok) {
                    const data = await response.json();
                    if (data.message =='Completada') {
                        window.location.href = "index.jsp";
                    }
                } 

            } catch (error) {
               console.log("Error")
            }
        }
</script>
<script>
    paypal.Buttons({
        style: {
            color: 'blue',
        },
        createOrder: function(data, actions) {
                const formulario = document.getElementById('FormContacto');
                const err = document.getElementById('errorSpan');

                const nombresInput = formulario.querySelector('[name="contactoNombres"]');
                const apellidosInput = formulario.querySelector('[name="contactoApellidos"]');
                const correoInput = formulario.querySelector('[name="contactoCorreo"]');
                const telefonoInput = formulario.querySelector('[name="contactoTelefono"]');

                if ( nombresInput.value.trim() === '' || apellidosInput.value.trim() === '' || correoInput.value.trim() === '' || telefonoInput.value.trim() === '') {
                    err.innerHTML = 'No deje los campos vacíos';
                    return;
                }

            return actions.order.create({
                purchase_units: [{
                    amount: {
                        value: '<%= (esCliente) ? carrito.MontoDescontado() : carrito.Monto() %>'
                    }
                }]
            });
        },
        onApprove: function(data, actions) {
            actions.order.capture().then(function(detalles) {
                
                var json = JSON.stringify({
                    detalles: detalles
                });
                const formulario = document.getElementById('FormContacto');
                var formData = new FormData(formulario);

                formData.append("json_data", json);

                if (detalles.purchase_units[0].soft_descriptor) { 
                    formData.append("metodo","TARJETA")
                } else {
                    formData.append("metodo","PAYPAL")
                }

                fetch('../ctrlPago', {
                    method: 'post',
                    mode: "cors",
                    body: formData
                }).then(function(response) {
                    window.location.href = "index.jsp";
                });
            });
        },
        onCancel: function(data) {
            alert("Método de Pago Cancelado");
        }
    }).render('#paypal-button-container');
</script>
<jsp:include page="Components/ModalNav.jsp"/>
<jsp:include page="Components/ModalBuscador.jsp"/>
<jsp:include page="../Templates/Footer.jsp"/> 