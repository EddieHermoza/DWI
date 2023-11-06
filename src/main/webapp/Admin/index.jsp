<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Modelos.Usuario" %>

<%
    Usuario u = (Usuario) session.getAttribute("usuario");
    if (u == null || u.getRol().equals("cliente")) {
        response.sendRedirect("../Home/index.jsp");
    } 
%>

<jsp:include page="../Templates/Head.jsp"/> 

    <jsp:include page="Components/NavAdmin.jsp"/> 
    
    <main class="relative w-full flex h-full">
        <jsp:include page="Components/BarraLateral.jsp"/>
        <section class="w-full max-sm:overflow-x-hidden">
            <div class="relative overflow-hidden h-full w-full bg-[rgb(20,20,20)] flex flex-col p-5 gap-10">
                <div class="flex items-center justify-center">
                    <h2 class="text-5xl text-white">Dashboard</h2>
                </div>
                <div class="grid max-md:grid-cols-1 md:grid-cols-2 grid-flow-row gap-5 px-3" >
                    <div class="flex gap-3 bg-red-600 rounded-md text-white text-xl h-32 w-full shadow-xl hover:scale-105 hover:shadow-red-600/50 transform duration-300"> 
                        <div class="border-r w-[25%] h-full flex items-center justify-center text-4xl">
                            <i class="fa-regular fa-file"></i>
                        </div>
                        <div class="flex flex-col gap-2 py-2 w-[75%]">
                            <span>Ventas Realizadas:</span>
                            <span class="w-full text-3xl" id="ventasSPAN"></span>
                        </div>
                    </div>
                    <div class="flex gap-3 bg-orange-600 rounded-md text-white text-xl h-32 w-full shadow-xl hover:scale-105 hover:shadow-orange-600/50 transform duration-300"> 
                        <div class="w-[25%] h-full flex items-center justify-center text-4xl border-r">
                            <i class="fa-solid fa-money-bill"></i>
                        </div>
                        <div class="flex flex-col gap-2 py-2 w-[75%]">
                            <span>Ganancia Total:</span>
                            <span class="w-full text-3xl" id="gananciaSPAN"></span>
                        </div>
                    </div>
                    <div class="flex gap-3 bg-cyan-400 rounded-md text-black text-xl h-32 w-full shadow-xl hover:scale-105 hover:shadow-cyan-400/50 transform duration-300"> 
                        <div class="w-[25%] h-full flex items-center justify-center text-4xl border-r">
                            <i class="fa-solid fa-user-pen"></i>
                        </div>
                        <div class="flex flex-col gap-2 py-2 w-[75%]">
                            <span>Clientes Registrados:</span>
                            <span class="w-full text-3xl" id="clientesSPAN"></span>
                        </div>
                    </div>
                    <div class="flex gap-3 bg-white rounded-md text-black text-xl h-32 w-full shadow-lg hover:scale-105 hover:shadow-white transform duration-300"> 
                        <div class="border-black border-r w-[25%] h-full flex items-center justify-center text-4xl">
                            <i class="fa-solid fa-computer"></i>
                        </div>
                        <div class="flex flex-col gap-2 py-2 w-[75%]">
                            <span>Productos Registrados:</span>
                            <span class="w-full text-3xl" id="productosSPAN"></span>
                        </div>
                    </div>        
                </div>

                <div class="flex max-2xl:flex-col 2xl:flex-row justify-center gap-5 max-sm:p-2 sm:p-5">
                    <div class="w-full flex flex-col justify-center items-center bg-neutral-950 rounded-lg p-3">
                        <h3 class="w-full text-3xl text-white text-center">Ventas de cada Mes (<strong id="añoStrong"></strong>)</h3>
                        <div class="w-full flex justify-center">
                            <canvas class="w-full" id="chartVentasMes"></canvas>
                        </div>
                    </div>
                    <div class="w-full flex flex-col justify-center items-center bg-neutral-950 rounded-lg p-3">
                        <h3 class="w-full text-3xl text-white text-center">Ventas Por Marca</h3>
                        <div class="w-full flex justify-center">
                            <canvas class="max-2xl:w-full 2xl:w-[50%] max-h-[400px]" id="chartVentaMarcas"></canvas>
                        </div>
                    </div>
                </div>

                <div class="flex max-2xl:flex-col 2xl:flex-row justify-center gap-5 max-sm:p-2 sm:p-5">
                    <div class="w-full flex flex-col justify-center items-center bg-neutral-950 rounded-lg p-3">
                        <h3 class="w-full text-3xl text-white text-center">Inventario de Productos</h3>
                        <div class="w-full flex justify-center">
                            <canvas class="w-full" id="chartInventario"></canvas>
                        </div>
                    </div>
                    <div class="w-full flex flex-col justify-center items-center bg-neutral-950 rounded-lg p-3">
                        <h3 class="w-full text-3xl text-white text-center">Preferencia de Metodos de Pago</h3>
                        <div class="w-full flex justify-center">
                            <canvas class="max-w-[500px] max-h-[400px]" id="chartMetodos"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </section> 
    </main>
<jsp:include page="Components/ModalNav.jsp"/>
<jsp:include page="../Templates/Footer.jsp"/> 

<script>
    async function Data(){
        try {
            const formData =new FormData();
            formData.append("grafica",'data');

            const response= await fetch('../ctrlGraficas',{
                method:'post',
                body:formData
            });
            if (response.ok) {
                const data = await response.json();
                const gananciaSPAN=document.getElementById('gananciaSPAN')
                const clientesSPAN=document.getElementById('clientesSPAN')
                const ventasSPAN=document.getElementById('ventasSPAN')
                const productosSPAN=document.getElementById('productosSPAN')

                gananciaSPAN.innerHTML='$/'+data.monto;
                clientesSPAN.innerHTML=data.cClientes;
                ventasSPAN.innerHTML=data.cVentas;
                productosSPAN.innerHTML=data.cProductos;
            } else {
                console.error('Error');
            }
        } catch (error) {
            console.error('Error:', error);
        }
    }
    Data();
</script>
<script>
    async function ActivarGrafica1() {
        try {
            const formData = new FormData();
            formData.append('grafica', 'chartInventario'); 

            const response = await fetch('../ctrlGraficas', {
                method: 'POST', 
                body: formData,
            });

            if (response.ok) {
            const data = await response.json();
            const chartInventario = document.getElementById('chartInventario');
            const labelsInventario = data.labels; 
            const dataInventario = data.data;

            function asignarColor(cantidad) {
                if (cantidad >= 5) {
                    return 'rgba(255, 100, 0)'; 
                } else {
                    return 'rgba(128, 128, 128)'; 
                } 
            }
            const colores = dataInventario.map(cantidad => asignarColor(cantidad));
            new Chart(chartInventario, {
                type: 'bar',
                data: {
                    labels: labelsInventario,
                    datasets: [{
                        label: 'UNIDADES',
                        data: dataInventario,
                        backgroundColor: colores,
                        borderColor: colores, 
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
    ActivarGrafica1();
</script>
<script>
    async function ActivarGrafica2() {
        try {
            const formData = new FormData();
            formData.append('grafica', 'chartMetodos'); 

            const response = await fetch('../ctrlGraficas', {
                method: 'POST', 
                body: formData,
            });

            if (response.ok) {
            const data = await response.json();
            const chartVentas = document.getElementById('chartMetodos');
            const labelsVentas = data.labels; 
            const dataVentas = data.data;

            new Chart(chartVentas, {
                type: 'doughnut',
                data: {
                    labels: labelsVentas,
                    datasets: [{
                        label: '',
                        data: dataVentas,
                        backgroundColor: [
                        'rgba(255, 233, 0)',
                        'rgba(65, 105, 225)',
                        'rgba(255, 100, 0)',
                        ],
                        borderColor: [
                        'rgb(255, 255, 255)'
                        ],
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
    ActivarGrafica2();
  </script>
  <script>
    async function ActivarGrafica3() {
        try {
            const formData = new FormData();
            formData.append('grafica', 'chartVentasMes'); 

            const response = await fetch('../ctrlGraficas', {
                method: 'POST', 
                body: formData,
            });

            if (response.ok) {
            const data = await response.json();
            console.log(response);
            const chartVentasMes = document.getElementById('chartVentasMes');
            const labelsVentas = data.labels; 
            const dataVentas = data.data;
            const año=data.año;
            const strong=document.getElementById('añoStrong');
            strong.innerHTML=año;

            new Chart(chartVentasMes, {
                type: 'line',
                data: {
                    labels: labelsVentas,
                    datasets: [{
                        label: '$/ (DOLARES)',
                        data: dataVentas,
                        backgroundColor:[
                        'rgba(255, 0, 0, 0.8)'
                        ],
                        borderColor: [
                        'rgb(255, 0, 0)'
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
  <script>
    async function ActivarGrafica4() {
        try {
            const formData = new FormData();
            formData.append('grafica', 'chartVentaMarcas'); 

            const response = await fetch('../ctrlGraficas', {
                method: 'POST', 
                body: formData,
            });

            if (response.ok) {
            const data = await response.json();
            console.log(response);
            const chartVentaMarcas = document.getElementById('chartVentaMarcas');
            const labelsVentas = data.labels; 
            const dataVentas = data.data;

            new Chart(chartVentaMarcas, {
                type: 'bar',
                data: {
                    labels: labelsVentas,
                    datasets: [{
                        label: '$/ (DOLARES)',
                        data: dataVentas,
                        backgroundColor:[
                        'rgb(255, 255, 255)'
                        ],
                        borderColor: [
                        'rgb(255, 255, 255)'
                        ],
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
    ActivarGrafica4();
  </script>

