
package Controlador;

import DAO.DetalleVentasDAO;
import DAO.MarcasDAO;
import DAO.ProductosDAO;
import DAO.UsuariosDAO;
import DAO.VentasDAO;
import Modelos.Marca;
import Modelos.Producto;
import Modelos.Venta;
import Modelos.Venta_Detalle;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.JSONArray;
import org.json.JSONObject;


@MultipartConfig
public class ctrlGraficas extends HttpServlet {
    ProductosDAO pdao=new ProductosDAO();
    VentasDAO vdao=new VentasDAO();
    MarcasDAO mdao=new MarcasDAO();
    UsuariosDAO udao=new UsuariosDAO();
    DetalleVentasDAO dvdao=new DetalleVentasDAO();
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       
        
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
        
        
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
        
        String grafica = request.getParameter("grafica");
        
        if (grafica.equals("data")) {
            int cantidadProductos=pdao.Cantidad();
            int cantidadVentas=vdao.Cantidad();
            int cantidadCliente=udao.CantidadClientes();
            double monto=vdao.GananciaTotal();
            
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("cProductos", cantidadProductos);
            jsonResponse.put("cVentas", cantidadVentas);
            jsonResponse.put("cClientes", cantidadCliente);
            jsonResponse.put("monto", monto);
            response.setContentType("application/json");
            response.getWriter().write(jsonResponse.toString());
        }
        
        if (grafica.equals("chartInventario")) {
            
            ArrayList<Producto> listaProductos = pdao.Listar();
            JSONArray StockLabels = new JSONArray();
            JSONArray StockData = new JSONArray();

            for (Producto producto : listaProductos) {
                StockLabels.put(producto.getNombre());
                StockData.put(producto.getCantidad());
            }
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("labels", StockLabels);
            jsonResponse.put("data", StockData);
            response.setContentType("application/json");
            response.getWriter().write(jsonResponse.toString());
        }
        
        
        if (grafica.equals("chartMetodos")) {
            ArrayList<Venta> listaVentas = vdao.Listar();
            Map<String, Integer> metodoCount = new HashMap<>();

            for (Venta v : listaVentas) {
                String metodoPago = v.getMetodo();
                if (metodoCount.containsKey(metodoPago)) {
                    metodoCount.put(metodoPago, metodoCount.get(metodoPago) + 1);
                } else {
                    metodoCount.put(metodoPago, 1);
                }
            }

            JSONArray VentaLabels = new JSONArray();
            JSONArray VentaData = new JSONArray();
            
            for (Map.Entry<String, Integer> entry : metodoCount.entrySet()) {
                VentaLabels.put(entry.getKey());
                VentaData.put(entry.getValue());
            }
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("labels", VentaLabels);
            jsonResponse.put("data", VentaData);
            response.setContentType("application/json");
            response.getWriter().write(jsonResponse.toString());
          
        }
        
        
        if (grafica.equals("chartVentasMes")) {
            JSONArray vfLabels = new JSONArray();
            JSONArray vfData = new JSONArray();

            Map<String, Double> MontosMes = new HashMap<>();
            SimpleDateFormat fMes = new SimpleDateFormat("MMMM", new Locale("es", "ES"));

            try {
                ArrayList<Venta> listaVentas = vdao.Listar();
                SimpleDateFormat formato = new SimpleDateFormat("dd-MM-yyyy");
                Calendar calendario = Calendar.getInstance();
                int añoActual = calendario.get(Calendar.YEAR);

                ArrayList<String> mesesOrden = new ArrayList<>();
                for (int mes = 1; mes <= 12; mes++) {
                    Calendar fechaMes = Calendar.getInstance();
                    fechaMes.set(Calendar.YEAR, añoActual);
                    fechaMes.set(Calendar.MONTH, mes - 1);
                    String nombreMes = fMes.format(fechaMes.getTime());
                    mesesOrden.add(nombreMes);
                }

                for (Venta v : listaVentas) {
                    Date d = formato.parse(v.getFecha());
                    Calendar fechaVenta = Calendar.getInstance();
                    fechaVenta.setTime(d);

                    if (fechaVenta.get(Calendar.YEAR) == añoActual) {
                        String nombreMes = fMes.format(d);
                        Double ganancia = v.getMonto();
                        MontosMes.put(nombreMes, MontosMes.getOrDefault(nombreMes, 0.0) + ganancia);
                    }
                }

                for (String mes : mesesOrden) {
                    vfLabels.put(mes);
                    Double ganancia = MontosMes.get(mes);
                    if (ganancia == null) {
                        vfData.put(0.0);
                    } else {
                        vfData.put(ganancia);
                    }
                }

                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("año", añoActual);
                jsonResponse.put("labels", vfLabels);
                jsonResponse.put("data", vfData);
                response.setContentType("application/json");
                response.getWriter().write(jsonResponse.toString());
            } catch (ParseException ex) {
                Logger.getLogger(ctrlGraficas.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        
        if (grafica.equals("chartVentaMarcas")) {
            JSONArray vMLabels = new JSONArray();
            JSONArray vMdata = new JSONArray();

            ArrayList<Producto> produList = pdao.Listar();
            ArrayList<Marca> marcasList = mdao.Listar();
            ArrayList<Venta_Detalle> vdList = dvdao.Listar();

            Map<Long, Double> marcaGanancias = new HashMap<>();

            for (Venta_Detalle detalle : vdList) {
                long productoId = detalle.getProducto();
                double ganancia = detalle.getSubtotal();
                System.out.println(ganancia);
                for (Producto producto : produList) {
                    if (producto.getId() == productoId) {
                        long marcaId = producto.getMarca();
                        marcaGanancias.put(marcaId, marcaGanancias.getOrDefault(marcaId, 0.0) + ganancia);
                        break;
                    }
                }
            }

            for (Marca marca : marcasList) {
                long marcaId = marca.getId();
                vMLabels.put(marca.getNombre());
                vMdata.put(marcaGanancias.getOrDefault(marcaId, 0.0));
            }

            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("labels", vMLabels);
            jsonResponse.put("data", vMdata);

            response.setContentType("application/json");
            response.getWriter().write(jsonResponse.toString());
        }
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
