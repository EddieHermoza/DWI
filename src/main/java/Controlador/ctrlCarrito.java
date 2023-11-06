package Controlador;


import Modelos.Carro;
import Modelos.Producto;
import Modelos.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

import org.json.JSONObject;

@MultipartConfig
public class ctrlCarrito extends HttpServlet {
    

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        
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
        Usuario u=(Usuario) session.getAttribute("usuario");
        Carro carro=(Carro) session.getAttribute("carro");
        String accion = request.getParameter("accion");
        
        if (accion.equals("añadir")) {
            int id=Integer.parseInt(request.getParameter("productoId"));
            
            
            for (Producto pro : carro.getListaDeProductos()) {
                if (pro.getId()== id) {
                    pro.setCantidad(pro.getCantidad()+1);
                    
                    JSONObject jsonResponse = new JSONObject();
                    jsonResponse.put("message", "añadido");
                    if (u!=null && u.getRol().equals("cliente")) {
                        jsonResponse.put("ahorro", pro.Ahorro()*pro.getCantidad());
                        jsonResponse.put("subtotal", pro.PrecioConDescuento()*pro.getCantidad());
                        jsonResponse.put("monto", carro.MontoDescontado());
                    } else{
                        jsonResponse.put("subtotal", pro.getPrecio()*pro.getCantidad());
                        jsonResponse.put("monto", carro.Monto());
                    }
                    response.setContentType("application/json");
                    response.getWriter().write(jsonResponse.toString());
                    return;
                }
            }
        }
        
        if (accion.equals("quitar")) {
            int id=Integer.parseInt(request.getParameter("productoId"));
            for (Producto pro : carro.getListaDeProductos()) {
                if (pro.getId()== id) {
                    pro.setCantidad(pro.getCantidad()-1);
                    
                    JSONObject jsonResponse = new JSONObject();
                    jsonResponse.put("message", "quitado");
                    if (u!=null && u.getRol().equals("cliente")) {
                        jsonResponse.put("ahorro", pro.Ahorro()*pro.getCantidad());
                        jsonResponse.put("subtotal", pro.PrecioConDescuento()*pro.getCantidad());
                        jsonResponse.put("monto", carro.MontoDescontado());
                    } else{
                        jsonResponse.put("subtotal", pro.getPrecio()*pro.getCantidad());
                        jsonResponse.put("monto", carro.Monto());
                    }
                    response.setContentType("application/json");
                    response.getWriter().write(jsonResponse.toString());
                    return;
                }
            }
        }
        
        if (accion.equals("eliminar")) {
            int id=Integer.parseInt(request.getParameter("productoId"));
            for (Producto pro : carro.getListaDeProductos()) {
                if (pro.getId() == id) {
                    carro.getListaDeProductos().remove(pro);
                    if (carro.getListaDeProductos().size()== 0) {     
                        return;
                    }
                    JSONObject jsonResponse = new JSONObject();
                    jsonResponse.put("message", "eliminado");
                    if (u!=null && u.getRol().equals("cliente")) {
                        jsonResponse.put("monto", carro.MontoDescontado());
                    } else{
                        jsonResponse.put("monto", carro.Monto());
                    }
                    response.setContentType("application/json");
                    response.getWriter().write(jsonResponse.toString());
                    return;
                }
            }
        }
        
        
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
