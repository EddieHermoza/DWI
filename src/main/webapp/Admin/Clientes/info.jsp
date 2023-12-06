<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="DAO.UsuariosDAO" %>
<%@ page import="DAO.VentasDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Modelos.Cliente" %>
<%@ page import="Modelos.Venta" %>
<%@ page import="Modelos.Usuario" %>

<%
    Usuario uSesion = (Usuario) session.getAttribute("usuario");
    if (uSesion == null || uSesion.getRol().equals("cliente")) {
        response.sendRedirect("../../Home/index.jsp");
    } 
%>

<% 
    int id = Integer.parseInt(request.getParameter("id"));

    UsuariosDAO uDAO = new UsuariosDAO();
    VentasDAO vDAO = new VentasDAO();

    Cliente u = uDAO.ObtenerCliente(id);

    ArrayList<Venta> ventas = vDAO.ListarVentasCLiente(u.getId());
    
    int cantidadCompras = vDAO.CantidadVentasCliente(u.getId()); 

%>
<jsp:include page="../../Templates/Head.jsp"/> 
    <jsp:include page="../Components/NavAdmin.jsp"/>  
    <main class="relative w-full flex min-h-[1000px]">
        <jsp:include page="../Components/BarraLateral.jsp"/>
        <section class="w-full max-sm:overflow-x-hidden">
            <div class="relative h-full w-full bg-[rgb(20,20,20)] flex flex-col p-5 gap-10">
                <div class="flex max-sm:flex-col max-sm:gap-3 items-center justify-between">
                    <h2 class="max-sm:text-3xl sm:text-5xl text-white">Cliente <%= u.getNombres() %></h2> 
                    <a href="index.jsp" class="flex items-center justify-center w-[200px] py-2 bg-[rgb(255,100,0)] rounded-tl-md rounded-br-md text-white text-xl hover:bg-white hover:text-black transform duration-300"">Volver</a>
                </div>
                <div class="flex lg:flex-row max-lg:flex-col-reverse gap-10 px-5">
                    <div class="max-lg:w-full lg:w-[40%] h-full relative flex flex-col gap-5 text-white">
                        <div class="flex-col flex gap-2 text-3xl">
                            <span class="text-orange-600">Nombres:</span>
                            <span class="text-2xl"><%=u.getNombres() %></span>
                        </div>
                        <div class="flex-col flex gap-2 text-3xl">
                            <span class="text-orange-600">Apellidos:</span>
                            <span class="text-2xl"><%=u.getApellidos() %></span>
                        </div>
                        <div class="flex-col flex gap-2 text-3xl">
                            <span class="text-orange-600">Correo:</span>
                            <span class="text-2xl"><%=u.getCorreo() %></span>
                        </div>
                        <div class="flex-col flex gap-2 text-3xl">
                            <span class="text-orange-600">Número telefonico:</span>
                            <span class="text-2xl"><%=u.getTelefono() %></span>
                        </div>
                        <div class="flex-col flex gap-2 text-3xl">
                            <span class="text-orange-600">Compras Realizadas:</span>
                            <span class="text-2xl"><%= cantidadCompras %></span>
                        </div>
                    </div>
                    <div class="relative max-md:hidden max-lg:w-full lg:w-[60%] h-full md:flex items-center justify-center">
                        <canvas class="w-full h-full" id="chartVentasCliente"></canvas>
                    </div>
                </div>
                <div class="w-full relative flex justify-center mt-20 px-5">
                    <div class="flex relative w-full overflow-x-auto scrollbar-thin scrollbar-track-black scrollbar-thumb-orange-600">
                        <div class="relative w-full">
                            <table class="w-full text-center max-sm:text-xs sm:text-base">
                                <thead class="border-b bg-neutral-800 text-white">
                                    <tr>
                                        <th scope="col" class=" p-5">ID</th>
                                        <th scope="col" class=" p-5">Transacción</th>
                                        <th scope="col" class=" p-5">fecha</th>
                                        <th scope="col" class=" p-5">hora</th>
                                        <th scope="col" class=" p-5">Monto Pagado</th>
                                        <th scope="col" class=" p-5">Descuento Aplicado</th>
                                        <th scope="col" class=" p-5">Cliente</th>
                                        <th scope="col" class=" p-5">Membresía</th>
                                        <th scope="col" class=" p-5">Método de Pago</th>
                                        <th scope="col" class=" p-5">Detalle</th>
                                    </tr>
                                </thead>
                                <tbody class="text-white">
                                <%  if (ventas == null || ventas.isEmpty()) {  %>
                                    <tr>
                                        <td colspan="9" class="p-5">No se registraron ventas</td>
                                    </tr>
                                 <% } else { %>
                                     <% for (Venta venta : ventas) { %>
                                        <tr class="border-b hover:bg-black transform duration-200">
                                            <td class="px-2 truncate"><%= venta.getId() %></td>
                                            <td class="px-2 truncate"><%= venta.getTransaccion() %></td>
                                            <td class="px-2 truncate max-w-[200px]"><%= venta.getFecha() %></td>
                                            <td class="px-2 truncate max-w-[200px]"><%= venta.getHora() %></td>
                                            <td class="px-2 truncate max-w-[200px]">$/<%= venta.getMonto() %></td>
                                            <td class="px-2 truncate max-w-[200px]">$/<%= venta.getDescuento() %></td>
                                            <td class="px-2 truncate max-w-[200px]"><%= venta.getNombreCliente() %></td>
                                            <td class="px-2 truncate max-w-[200px]"><%= venta.getIdcliente() %></td>
                                            <td class="px-2 truncate max-w-[200px]"><%= venta.getMetodo() %></td>
                                            <td class="flex flex-col gap-2 p-2">
                                                <a href="detalle.jsp?id=<%= venta.getId() %>" class="bg-white text-black px-2 py-1 hover:bg-cyan-300 transform duration-200 rounded-tl-md rounded-br-md">Ver Detalle</a>
                                            </td>
                                        </tr>
                                    <% } %>
                                <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div> 
        </section>
    </main>
    <script>
        async function ActivarGrafica3() {
            try {
                const formData = new FormData();
                formData.append('grafica', 'chartVentasCliente'); 
                formData.append('id','<%=u.getId() %>')
    
                const response = await fetch('../../ctrlGraficas', {
                    method: 'POST', 
                    body: formData,
                });
    
                if (response.ok) {
                const data = await response.json();
                const chartVentasMes = document.getElementById('chartVentasCliente');
                const labelsVentas = data.labels; 
                const dataVentas = data.data;
                const año=data.año;

                new Chart(chartVentasMes, {
                    type: 'line',
                    data: {
                        labels: labelsVentas,
                        datasets: [{
                            label: '$/ (DOLARES)',
                            data: dataVentas,
                            backgroundColor:[
                            'rgba(255, 100, 0, 0.8)'
                            ],
                            borderColor: [
                            'rgb(255, 100, 0)'
                            ],
                            fill: true,
                            borderWidth: 1
                        }]
                    },
                    options: {
                        plugins: {
                            legend: {
                                labels: {
                                    color: 'white', 
                                },
                            },
                        },
                        scales: {
                            x:{
                                grid:{
                                    color:'black'
                                },
                                ticks: {
                                    color: 'white', 
                                }
                            },
                            y: {
                                beginAtZero: true,
                                grid: {
                                    color: 'white'
                                },
                                ticks: {
                                    color: 'white', 
                                }
                            }
                        }
                    }
                });      
                } else {
                console.error('Error');
                }
            } catch (error) {
                console.error('Error:', error);
            }
        }
        ActivarGrafica3();
      </script>
<jsp:include page="../Components/ModalNav.jsp"/>
<jsp:include page="../../Templates/Footer.jsp"/> 