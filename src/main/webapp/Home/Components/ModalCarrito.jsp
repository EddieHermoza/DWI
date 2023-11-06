<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Modelos.Carro" %>
<%@ page import="Modelos.Usuario" %>
<%@ page import="Modelos.Producto" %>
<%
    String url = request.getContextPath();
    Usuario u = (Usuario) session.getAttribute("usuario");
    Carro carrito = (Carro) session.getAttribute("carro");

    boolean esCliente = (u != null && u.getRol().equals("cliente"));
%>
<!-- Carrito -->
<div  data-te-modal-init class="fixed top-0 left-0 z-[1055] hidden h-full w-full" id="modalCart" tabindex="-1" aria-labelledby="rightBottomModalLabel" aria-hidden="true">
    <div data-te-modal-dialog-ref class="absolute border-t top-[50px] right-0 h-auto w-full translate-x-[100%] bg-neutral-950 bg-opacity-90 transition-all duration-300 ease-in-out sm:max-w-[640px]">
        <% if(esCliente) { %>
            <h2 class="text-[rgb(255,100,0)] text-center text-2xl p-4">Carrito de compras<span class="text-white text-xl"> (Descuentos Aplicados)</span></h2>
        <% } else { %>
            <h2 class="text-[rgb(255,100,0)] text-center text-2xl p-4">Carrito de compras</h2>
        <% } %>
        <div class="relative  h-max-[600px] overflow-auto scrollbar-thin scrollbar-thumb-orange-600" data-te-modal-body-ref>
            <div class="flex flex-col relative h-auto w-full bg-transparent">
                <% if (carrito.getListaDeProductos() == null || carrito.getListaDeProductos().isEmpty()) { %>
                    <table class="w-full relative" id="tablaCarrito">
                        <tbody class="w-full relative text-center">
                            <tr class="w-full justify-center text-base text-white hidden gap-5 border-b px-2" id="carritoEncabezado">
                                <td class="w-1/5">
                                    Imagen
                                </td>
                                <td class="w-1/5">
                                    Producto
                                </td>
                                <td class="max-sm:hidden w-1/5">
                                    Precio/U
                                </td>
                                <td class="w-1/5">
                                    Cantidad
                                </td>
                                <td class="w-1/5">
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="w-full flex-col hidden" id="footerCarrito">
                        <% if(esCliente) { %>
                        <span class="w-full text-xl text-white py-3 text-center">Total a Pagar: $/ <span id="montoCarrito"><%= carrito.MontoDescontado() %></span></span>
                        <% } else { %>
                        <span class="w-full text-xl text-white py-3 text-center">Total a Pagar: $/ <span id="montoCarrito"><%= carrito.Monto() %></span></span>
                        <% } %>
                        <a class="text-black text-2xl w-full bg-white hover:bg-[rgb(255,100,0)] hover:text-white py-3 transform duration-300 text-center"  href="<%=url%>/Home/Carrito.jsp">Ver Carrito</a>
                    </div>
                <% } else { %>
                <table class="w-full relative" id="tablaCarrito">
                    <tbody class="w-full relative text-center">
                        <tr class="w-full justify-center max-sm:text-black text-base text-white flex gap-5 border-b px-2" id="carritoEncabezado">
                            <td class="w-1/5">
                                Imagen
                            </td>
                            <td class="w-1/5">
                                Producto
                            </td>
                            <td class="max-sm:hidden w-1/5">
                                Precio/U
                            </td>
                            <td class="w-1/5">
                                Cantidad
                            </td>
                            <td class="w-1/5">
                            </td>
                        </tr>
                        <% for(Producto produ :carrito.getListaDeProductos()) { %>
                        <tr class="w-full justify-center items-center max-sm:text-black text-base text-white flex gap-5 px-2">
                            <td class="w-1/5">
                                <img src="<%= produ.getImg() %>" height="100" width="100" >
                            </td>
                            <td class="w-1/5">
                                <%= produ.getNombre() %>
                            </td>
                            <% if(esCliente) { %>
                            <td class="max-sm:hidden w-1/5">
                                $/ <%= produ.PrecioConDescuento() %>
                            </td>
                            <% } else { %>
                                <td class="max-sm:hidden w-1/5">
                                    $/ <%= produ.getPrecio() %>
                                </td>
                            <% } %>
                            <td class="w-1/5">
                                <%= produ.getCantidad() %>
                            </td>
                            <td class="w-1/5">
                                <button data-producto="<%= produ.getId() %>" class="carrito-Eliminar text-xl hover:text-[rgb(255,100,0)] transform duration-300">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <div class="w-full flex flex-col" id="footerCarrito">
                    <% if(esCliente) { %>
                        <span class=" border-t w-full text-xl text-white py-3 text-center">Total a Pagar: $/ <span id="montoCarrito"><%= carrito.MontoDescontado() %></span></span>
                    <% } else { %>
                        <span class=" border-t w-full text-xl text-white py-3 text-center">Total a Pagar: $/ <span id="montoCarrito"><%= carrito.Monto() %></span></span>
                    <% } %>
                    <a class="text-2xl w-full bg-orange-600 text-white hover:bg-white hover:text-black py-2 transform duration-300 text-center" href="<%=url%>/Home/Carrito.jsp">Ver Carrito</a>
                </div>
                <% }  %>
            </div>
        </div>
    </div>
</div>
<script>
    document.addEventListener('DOMContentLoaded', function() {

        function eliminarProducto(productoId,btn) {
            const formData = new FormData();
            formData.append('productoId', productoId);
            formData.append('accion', 'Eliminar');

            fetch('../ctrlCarritoModal', {
                method: 'post',
                body: formData,
                mode: 'cors'
            })
            .then(response => {
                if (response.ok) {
                    return response.json();
                } else {
                    console.error('Error de servidor:', response.status, response.statusText);
                    throw new Error('Error en la solicitud al servidor');
                }
            })
            .then(data => {
                if (data.message === 'Eliminado') {
                    const contCarrito = document.getElementById('carritoCantidad');
                    const cantidadActual = parseInt(contCarrito.textContent);
                    const nuevaCantidad = cantidadActual - 1;
                    contCarrito.textContent = nuevaCantidad;


                    var fila = btn.parentNode.parentNode;
                    const filaPrecio=parseFloat(fila.cells[2].innerHTML.replace("$/", "").replace(/\s/g, ""));
                    const filaCantidad=parseInt(fila.cells[3].innerHTML.replace(/\s/g, ""));
                    const montoCarrito=document.getElementById("montoCarrito");
                    const montoActual=parseFloat(montoCarrito.innerHTML.replace(/\s/g, ""));

                    montoCarrito.innerHTML=montoActual-filaPrecio*filaCantidad;
                    

                    let tabla = fila.parentNode;
                    tabla.deleteRow(fila.rowIndex);

                    if (nuevaCantidad === 0) {
                        const encabezado = document.getElementById('carritoEncabezado');
                        encabezado.classList.remove('flex');
                        encabezado.classList.add('hidden');

                        const footerCarrito=document.getElementById("footerCarrito");
                        footerCarrito.classList.remove("flex");
                        footerCarrito.classList.add("hidden");
                    }
                }
            })
            .catch(error => {
                console.error('Error de js:', error);
            });
        }


        const btnsEliminarCarrito = document.querySelectorAll('.carrito-Eliminar');
        btnsEliminarCarrito.forEach(boton => {
            boton.onclick = function() {
                const productoId = this.getAttribute('data-producto');
                eliminarProducto(productoId,boton);
            };
        });


        const botonesCarrito = document.querySelectorAll('.carrito-boton');
        const carritoNotis = document.querySelectorAll('.carrito-noti');

        botonesCarrito.forEach(async function(boton, index) {
            boton.addEventListener('click', async function(e) {
                e.preventDefault();

                const productoId = this.getAttribute('data-producto');
                const formData = new FormData();
                formData.append('productoId', productoId);
                formData.append('accion', 'Agregar');
                botonesCarrito[index].disabled = true;
                carritoNotis[index].classList.remove('hidden');

                setTimeout(async function() {
                        try {
                            const response = await fetch('../ctrlCarritoModal', {
                                method: 'post',
                                body: formData,
                                mode: 'cors'
                            });

                            if (response.ok) {
                                const data = await response.json();
                                if (data.message == 'Primer') {
                                    PrimerProducto(data, productoId);
                                } else if (data.message == 'Nuevo') {
                                    ProductoNuevo(data, productoId);
                                } else if (data.message == 'Repetido') {
                                    ProductoRepetido(data);
                                }
                            } else {
                                console.error('Error de servidor:', response.status, response.statusText);
                            }
                        } catch (error) {
                            console.error('Error de js:', error);
                        } finally {
                            carritoNotis[index].classList.add('hidden');
                            botonesCarrito[index].disabled = false;
                        }
                }, 1000); 
            });
        });

        function PrimerProducto(data,id){
            const contCarrito=document.getElementById('carritoCantidad')
            const cantidadActual = parseInt(contCarrito.textContent); 
            const nuevaCantidad = cantidadActual + 1;
            contCarrito.textContent = nuevaCantidad;

            const encabezado = document.getElementById("carritoEncabezado");    

            encabezado.classList.remove("hidden");
            encabezado.classList.add("flex");

            const footerCarrito=document.getElementById("footerCarrito");
            footerCarrito.classList.remove("hidden");
            footerCarrito.classList.add("flex")

            const tabla = document.getElementById("tablaCarrito");
            var filaNueva = tabla.insertRow();

            filaNueva.classList.add("w-full","items-center", "justify-center","text-base", "text-white", "flex","gap-5","px-2");

            var cell1 = filaNueva.insertCell(0);
            var img = document.createElement("img");
            img.src = data.img; 
            img.setAttribute("width", "100"); 
            img.setAttribute("height", "100"); 
                            
            cell1.classList.add("w-1/5");
            cell1.appendChild(img);

            var cell2 = filaNueva.insertCell(1);
            cell2.classList.add("w-1/5");

            cell2.innerHTML = data.nombre;

            var cell3 = filaNueva.insertCell(2);
            cell3.innerHTML ="$/ "+ data.precio;
            cell3.classList.add("w-1/5","max-sm:hidden");

            var cell4 = filaNueva.insertCell(3);
            cell4.innerHTML = data.cantidad;
            cell4.classList.add("w-1/5");

            var cell5 = filaNueva.insertCell(4);
            cell5.classList.add("w-1/5");
            var boton = document.createElement("button");
            var icono = document.createElement("i");
            icono.classList.add("fas", "fa-trash"); 
            boton.appendChild(icono);
            boton.classList.add("carrito-Eliminar","text-xl","hover:text-[rgb(255,100,0)]","transform","duration-300")
            boton.setAttribute("data-producto",id );
            boton.onclick = function() {
                const productoId = this.getAttribute("data-producto");
                eliminarProducto(productoId,boton);
            };
            cell5.appendChild(boton);

            const montoCarrito=document.getElementById("montoCarrito")
            const montoActual=parseFloat(montoCarrito.innerHTML.replace(/\s/g, ""))

            montoCarrito.innerHTML=montoActual+data.precio;

        }


        function ProductoNuevo(data,id){
            const contCarrito=document.getElementById('carritoCantidad')
            const cantidadActual = parseInt(contCarrito.textContent); 
            const nuevaCantidad = cantidadActual + 1;
            contCarrito.textContent = nuevaCantidad;

            const tabla = document.getElementById("tablaCarrito");
            var filaNueva = tabla.insertRow();

            filaNueva.classList.add("w-full","items-center", "justify-center", "text-base", "text-white", "flex","gap-5","px-2");

            var cell1 = filaNueva.insertCell(0);
            var img = document.createElement("img");
            img.src = data.img; 
            img.setAttribute("width", "100"); 
            img.setAttribute("height", "100"); 
                            
            cell1.classList.add("w-1/5");
            cell1.appendChild(img);

            var cell2 = filaNueva.insertCell(1);
            cell2.classList.add("w-1/5");

            cell2.innerHTML = data.nombre;


            var cell3 = filaNueva.insertCell(2);
            cell3.innerHTML ="$/ "+ data.precio;
            cell3.classList.add("w-1/5","max-sm:hidden");

            var cell4 = filaNueva.insertCell(3);
            cell4.innerHTML = data.cantidad;
            cell4.classList.add("w-1/5");

            var cell5 = filaNueva.insertCell(4);
            cell5.classList.add("w-1/5");
            var boton = document.createElement("button");
            var icono = document.createElement("i");
            icono.classList.add("fas", "fa-trash"); 
            boton.appendChild(icono);
            boton.classList.add("carrito-Eliminar","text-xl","hover:text-[rgb(255,100,0)]","transform","duration-300")
            boton.setAttribute("data-producto",id );
            boton.onclick = function() {
                const productoId = this.getAttribute("data-producto");
                eliminarProducto(productoId,boton);
            };
            cell5.appendChild(boton);

            const montoCarrito=document.getElementById("montoCarrito")
            const montoActual=parseFloat(montoCarrito.innerHTML.replace(/\s/g, ""))

            montoCarrito.innerHTML=montoActual+data.precio;

        }


        function ProductoRepetido(data) {
            const tabla = document.getElementById("tablaCarrito");
            for (let i = 1; i < tabla.rows.length; i++) {

                const celdaNombre = tabla.rows[i].cells[1];

                if (celdaNombre.textContent.replace(/\s+/g, '') == data.nombre.replace(/\s+/g, '')) {

                    const celdaPrecio = tabla.rows[i].cells[2];
                    const precio=parseFloat(celdaPrecio.innerHTML.replace("$/", "").replace(/\s/g, ""));
                    const celdaCantidad = tabla.rows[i].cells[3];
                    const cantidadActual = parseInt(celdaCantidad.innerHTML);
                    celdaCantidad.innerHTML = cantidadActual + 1;

                    const montoCarrito=document.getElementById("montoCarrito")
                    const montoActual=parseFloat(montoCarrito.innerHTML.replace(/\s/g, ""))

                    montoCarrito.innerHTML=montoActual+precio;

                    break;

                } 
            }
        }
        

        
    })
</script>