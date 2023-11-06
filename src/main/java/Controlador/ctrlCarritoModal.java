
package Controlador;

import DAO.ProductosDAO;
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
public class ctrlCarritoModal extends HttpServlet {
    ProductosDAO pDAO=new ProductosDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

   @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);

        HttpSession session = request.getSession();
        Usuario u=(Usuario) session.getAttribute("usuario");
        Carro carro=(Carro) session.getAttribute("carro");
        String accion = request.getParameter("accion");
        
        if (accion.equals("Agregar")) {
           String a = request.getParameter("productoId");
            if (a != null) {
                try {
                    int id = Integer.parseInt(a);
                    Producto p = pDAO.ObtenerProducto(id);
                    
                    if (carro.getListaDeProductos().size()==0) {
                        Producto pNuevo=new Producto();
                        pNuevo.setId(p.getId());
                        pNuevo.setNombre(p.getNombre());
                        pNuevo.setPrecio(p.getPrecio());
                        pNuevo.setImg(p.getImg());
                        pNuevo.setCantidad(1);
                        pNuevo.setDescuento(p.getDescuento());
                        carro.getListaDeProductos().add(pNuevo);
                        
                        JSONObject jsonResponse = new JSONObject();
                        jsonResponse.put("message", "Primer");
                        jsonResponse.put("nombre", pNuevo.getNombre());
                        if (u!=null && u.getRol().equals("cliente")) {
                            jsonResponse.put("precio", pNuevo.PrecioConDescuento());
                        } else {
                            jsonResponse.put("precio", pNuevo.getPrecio());
                        }
                        jsonResponse.put("cantidad", pNuevo.getCantidad());
                        jsonResponse.put("img", pNuevo.getImg());
                        response.setContentType("application/json");
                        response.getWriter().write(jsonResponse.toString());
                        return;
                        
                    } else if(carro.getListaDeProductos().size()!=0){
                        
                        for (Producto pro : carro.getListaDeProductos()) {
                            if (pro.getId()==id) {
                                pro.setCantidad(pro.getCantidad()+1);
                                
                                JSONObject jsonResponse = new JSONObject();
                                jsonResponse.put("message", "Repetido");
                                jsonResponse.put("nombre", pro.getNombre());
                                 if (u!=null && u.getRol().equals("cliente")) {
                                    jsonResponse.put("precio", pro.PrecioConDescuento());
                                } else {
                                    jsonResponse.put("precio", pro.getPrecio());
                                }
                                response.setContentType("application/json");
                                response.getWriter().write(jsonResponse.toString());
                                return;
                            }
                        }
                        
                        Producto pNuevo=new Producto();
                        pNuevo.setId(p.getId());
                        pNuevo.setNombre(p.getNombre());
                        pNuevo.setPrecio(p.getPrecio());
                        pNuevo.setImg(p.getImg());
                        pNuevo.setCantidad(1);
                        pNuevo.setDescuento(p.getDescuento());
                        carro.getListaDeProductos().add(pNuevo);
                        
                        JSONObject jsonResponse = new JSONObject();
                        jsonResponse.put("message", "Nuevo");
                        jsonResponse.put("nombre", pNuevo.getNombre());
                         if (u!=null && u.getRol().equals("cliente")) {
                            jsonResponse.put("precio", pNuevo.PrecioConDescuento());
                        } else {
                            jsonResponse.put("precio", pNuevo.getPrecio());
                        }
                        jsonResponse.put("cantidad", pNuevo.getCantidad());
                        jsonResponse.put("img", pNuevo.getImg());
                        response.setContentType("application/json");
                        response.getWriter().write(jsonResponse.toString());
                        return;
                        
                    }                  

                } catch (Exception e) {
                    e.printStackTrace();
                    JSONObject jsonResponse = new JSONObject();
                    jsonResponse.put("error", "Ocurrió un error en el servidor");
                    response.setContentType("application/json");
                    response.getWriter().write(jsonResponse.toString());
                }
                
            } else {
                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("message", "Sin respuesta");
                response.setContentType("application/json");
                response.getWriter().write(jsonResponse.toString());
            }
            
        } else if (accion.equals("Eliminar")) {
            String a=request.getParameter("productoId");
            try {
                int id=Integer.parseInt(a);
                for (Producto pro : carro.getListaDeProductos()) {
                    if (pro.getId() == id) {
                        carro.getListaDeProductos().remove(pro);

                        JSONObject jsonResponse = new JSONObject();
                        jsonResponse.put("message", "Eliminado");
                        response.setContentType("application/json");
                        response.getWriter().write(jsonResponse.toString());
                        return;
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("error", "Ocurrió un error en el servidor");
                response.setContentType("application/json");
                response.getWriter().write(jsonResponse.toString());
            }
           
       }   
    }
    


    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
