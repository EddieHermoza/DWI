
package Controlador;

import DAO.DetalleVentasDAO;
import DAO.ProductosDAO;
import DAO.UsuariosDAO;
import DAO.VentasDAO;
import Modelos.Carro;
import Modelos.Cliente;
import Modelos.Producto;
import Modelos.Usuario;
import Modelos.Venta;
import Modelos.Venta_Detalle;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import org.json.JSONException;
import org.json.JSONObject;



@MultipartConfig
public class ctrlPago extends HttpServlet {
    
    private SimpleDateFormat formatoFecha = new SimpleDateFormat("dd-MM-yyyy");
    private SimpleDateFormat formatoHora = new SimpleDateFormat("HH:mm:ss");
    private VentasDAO vdao=new VentasDAO();
    private DetalleVentasDAO dvdao=new DetalleVentasDAO();
    private UsuariosDAO udao=new UsuariosDAO();
    private ProductosDAO pdao=new ProductosDAO();
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        processRequest(request, response);

        HttpSession session = request.getSession();
        Usuario u = (Usuario) session.getAttribute("usuario");
        Carro carro = (Carro) session.getAttribute("carro");

        Date fechaHoraActual = new Date();

        String fecha = formatoFecha.format(fechaHoraActual);
        String hora = formatoHora.format(fechaHoraActual);
        
        String json = request.getParameter("json_data");
        String metodo = request.getParameter("metodo");
        
        if (metodo.equals("OTROS")) {
            
            if (u!=null && u.getRol().equals("cliente")) {
                
                Cliente c=udao.ObtenerCliente(u.getId());
                Venta v = new Venta();
                v.setTransaccion("SIN TRANSACCIÓN");
                v.setFecha(fecha);
                v.setHora(hora);
                v.setMonto(carro.MontoDescontado());
                v.setDescuento(carro.AhorroTotal());
                v.setNombreCliente(u.getNombres()+" "+u.getApellidos());
                v.setCorreoCliente(c.getCorreo());
                v.setTelefonoCliente(c.getTelefono());
                v.setIdcliente(u.getId());
                v.setMetodo(metodo);
                
                if (vdao.Insertar(v)) {
                    
                    int idventa=vdao.ObtenerIDgenerado();
                    
                    if (idventa > 0) {
                        ArrayList<Producto> plist = pdao.Listar(); 
                        Map<Integer, Producto> productMap = new HashMap<>();
                        for (Producto p : plist) {
                            productMap.put(p.getId(), p);
                        }

                        for (Producto prod : carro.getListaDeProductos()) {
                            Producto pInv = productMap.get(prod.getId());
                            if (pInv != null) {
                                pdao.ModificarCantidad(pInv.getId(), pInv.getCantidad() - prod.getCantidad());
                            }

                            Venta_Detalle vd = new Venta_Detalle();
                            vd.setVenta(idventa);
                            vd.setProducto(prod.getId());
                            vd.setMonto_unit(prod.getPrecio());
                            vd.setDesc_aplicado(prod.Ahorro());
                            vd.setCantidad(prod.getCantidad());
                            vd.setSubtotal(prod.PrecioConDescuento()*prod.getCantidad());
                            dvdao.Insertar(vd);
                        }

                        carro.getListaDeProductos().clear();
                                          
                        JSONObject jsonResponse=new JSONObject();
                        jsonResponse.put("message", "Completada");
                        response.setContentType("application/json");
                        response.getWriter().write(jsonResponse.toString());
                        return;
                    }
                }
            } else {
                String nombres =request.getParameter("contactoNombres");
                String apellidos =request.getParameter("contactoApellidos");
                String correo=request.getParameter("contactoCorreo");
                String telefono=request.getParameter("contactoTelefono");
                
                Venta v = new Venta();
                v.setTransaccion("SIN TRANSACCIÓN");
                v.setFecha(fecha);
                v.setHora(hora);
                v.setMonto(carro.Monto());
                v.setDescuento(0);
                v.setNombreCliente(nombres+apellidos);
                v.setCorreoCliente(correo);
                v.setTelefonoCliente(telefono);
                v.setIdcliente(0);
                v.setMetodo(metodo);
                
                if (vdao.Insertar(v)) {
                    
                    int idventa=vdao.ObtenerIDgenerado();
                    
                    if (idventa > 0) {
                        ArrayList<Producto> plist = pdao.Listar(); 
                        Map<Integer, Producto> productMap = new HashMap<>();
                        for (Producto p : plist) {
                            productMap.put(p.getId(), p);
                        }

                        for (Producto prod : carro.getListaDeProductos()) {
                            Producto pInv = productMap.get(prod.getId());
                            if (pInv != null) {
                                pdao.ModificarCantidad(pInv.getId(), pInv.getCantidad() - prod.getCantidad());
                            }

                            Venta_Detalle vd = new Venta_Detalle();
                            vd.setVenta(idventa);
                            vd.setProducto(prod.getId());
                            vd.setMonto_unit(prod.getPrecio());
                            vd.setDesc_aplicado(0);
                            vd.setCantidad(prod.getCantidad());
                            vd.setSubtotal(prod.getPrecio()*prod.getCantidad());
                            dvdao.Insertar(vd);
                        }

                        carro.getListaDeProductos().clear();
                                          
                        JSONObject jsonResponse=new JSONObject();
                        jsonResponse.put("message", "Completada");
                        response.setContentType("application/json");
                        response.getWriter().write(jsonResponse.toString());
                        return;
                    }
                }
            
            }
        }
        
        try {
            JSONObject o = new JSONObject(json);

            String id_transaccion = o.getJSONObject("detalles").getString("id");
            String monto = o.getJSONObject("detalles").getJSONArray("purchase_units").getJSONObject(0).getJSONObject("amount").getString("value");

            
            double mont =Double.parseDouble(monto);
            
            if (u!=null && u.getRol().equals("cliente")) {
                Cliente c=udao.ObtenerCliente(u.getId());
                Venta v = new Venta();
                v.setTransaccion(id_transaccion);
                v.setFecha(fecha);
                v.setHora(hora);
                v.setMonto(mont);
                v.setDescuento(carro.AhorroTotal());
                v.setNombreCliente(u.getNombres()+" "+u.getApellidos());
                v.setCorreoCliente(c.getCorreo());
                v.setTelefonoCliente(c.getTelefono());
                v.setIdcliente(u.getId());
                v.setMetodo(metodo);
                
                if (vdao.Insertar(v)) {
                    
                    int idventa=vdao.ObtenerIDgenerado();
                    
                    if (idventa > 0) {
                        ArrayList<Producto> plist = pdao.Listar(); 
                        Map<Integer, Producto> productMap = new HashMap<>();
                        for (Producto p : plist) {
                            productMap.put(p.getId(), p);
                        }

                        for (Producto prod : carro.getListaDeProductos()) {
                            Producto pInv = productMap.get(prod.getId());
                            if (pInv != null) {
                                pdao.ModificarCantidad(pInv.getId(), pInv.getCantidad() - prod.getCantidad());
                            }

                            Venta_Detalle vd = new Venta_Detalle();
                            vd.setVenta(idventa);
                            vd.setProducto(prod.getId());
                            vd.setMonto_unit(prod.getPrecio());
                            vd.setDesc_aplicado(prod.Ahorro());
                            vd.setCantidad(prod.getCantidad());
                            vd.setSubtotal(prod.PrecioConDescuento()*prod.getCantidad());
                            dvdao.Insertar(vd);
                        }

                        carro.getListaDeProductos().clear();
                    }
                }
                
            } else {
                String nombres =request.getParameter("contactoNombres");
                String apellidos =request.getParameter("contactoApellidos");
                String correo=request.getParameter("contactoCorreo");
                String telefono=request.getParameter("contactoTelefono");
                
                Venta v = new Venta();
                v.setTransaccion(id_transaccion);
                v.setFecha(fecha);
                v.setHora(hora);
                v.setMonto(mont);
                v.setDescuento(0);
                v.setNombreCliente(nombres+apellidos);
                v.setCorreoCliente(correo);
                v.setTelefonoCliente(telefono);
                v.setIdcliente(0);
                v.setMetodo(metodo);
                
                if (vdao.Insertar(v)) {
                    
                    int idventa=vdao.ObtenerIDgenerado();
                    
                    if (idventa > 0) {
                        ArrayList<Producto> plist = pdao.Listar(); 
                        Map<Integer, Producto> productMap = new HashMap<>();
                        for (Producto p : plist) {
                            productMap.put(p.getId(), p);
                        }

                        for (Producto prod : carro.getListaDeProductos()) {
                            Producto pInv = productMap.get(prod.getId());
                            if (pInv != null) {
                                pdao.ModificarCantidad(pInv.getId(), pInv.getCantidad() - prod.getCantidad());
                            }

                            Venta_Detalle vd = new Venta_Detalle();
                            vd.setVenta(idventa);
                            vd.setProducto(prod.getId());
                            vd.setMonto_unit(prod.getPrecio());
                            vd.setDesc_aplicado(0);
                            vd.setCantidad(prod.getCantidad());
                            vd.setSubtotal(prod.getPrecio()*prod.getCantidad());
                            dvdao.Insertar(vd);
                        }

                        carro.getListaDeProductos().clear();
                    }
                }
            
            }
            
        } catch (JSONException e) {
            e.printStackTrace();
            System.out.println(e);

        }
    }
    


    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
