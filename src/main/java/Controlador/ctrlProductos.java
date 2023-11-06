
package Controlador;

import DAO.ProductosDAO;
import Modelos.Producto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@MultipartConfig(
    fileSizeThreshold = 5 * 1024 * 1024, 
    maxFileSize = 5 * 1024 * 1024,     
    maxRequestSize = 5 * 1024 * 1024     
)
public class ctrlProductos extends HttpServlet {
    private ProductosDAO pDAO=new ProductosDAO();
    private String rutaAbsoluta ="C:\\Users\\Administrator\\Documents\\NetBeansProjects\\Proyecto_DWI\\src\\main\\webapp\\images\\Productos";
    private File archivoDestino=new File(rutaAbsoluta);
    private String rutaArchivo="../images/Productos/";
    private String[] extensiones ={".png",".jpg",".jpeg",".webp"};
    
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
        
        
        
        if (request.getParameter("InsertarProducto") != null) {
            String nombreProdu=request.getParameter("nombreProducto");
            String descripProdu=request.getParameter("descripcionProducto");
            int marcaProdu=Integer.parseInt(request.getParameter("marcaProducto"));
            int cateProdu=Integer.parseInt(request.getParameter("categoriaProducto"));
            double precioProdu=Double.parseDouble(request.getParameter("precioProducto"));
            double descuentoProducto=Double.parseDouble(request.getParameter("descuentoProducto"));
            String especiProducto= request.getParameter("especificacionesProducto");
            Part imgProdu=request.getPart("imgProducto");
            
            if (validarExtension(imgProdu.getSubmittedFileName(), extensiones)) {
                guardarImagen(imgProdu, archivoDestino);
                Producto p=new Producto(nombreProdu, descripProdu, rutaArchivo+imgProdu.getSubmittedFileName(), marcaProdu, cateProdu, descuentoProducto, precioProdu, 0, "Habilitado",especiProducto);
                    
                if (p.ConAtributosVacios()) {
                    response.sendRedirect(request.getContextPath() + "/Admin/Productos/");
                }
                    
                if (pDAO.Insertar(p)) {
                    response.sendRedirect(request.getContextPath() + "/Admin/Productos/");
                }
            }
        }
        
        if (request.getParameter("ModificarProducto") != null) {
            
            int idProdu=Integer.parseInt(request.getParameter("idProducto"));
            String nombreProdu=request.getParameter("nombreProducto");
            String descripProdu=request.getParameter("descripcionProducto");
            int marcaProdu=Integer.parseInt(request.getParameter("marcaProducto"));
            int cateProdu=Integer.parseInt(request.getParameter("categoriaProducto"));
            int cantProdu=Integer.parseInt(request.getParameter("cantidadProducto"));
            String estadoProducto=request.getParameter("estadoProducto");
            double precioProdu=Double.parseDouble(request.getParameter("precioProducto"));
            double descuentoProducto=Double.parseDouble(request.getParameter("descuentoProducto"));
            String especiProducto= request.getParameter("especificacionesProducto");
            String imgPrev=request.getParameter("urlProducto");
            Part imgProduNuevo=request.getPart("imgProductoNuevo");
            if (idProdu>0) { 
                if (imgProduNuevo.getSubmittedFileName() !="") {

                    Producto p=new Producto(nombreProdu, descripProdu, rutaArchivo+imgProduNuevo.getSubmittedFileName(), marcaProdu, cateProdu, descuentoProducto, precioProdu, cantProdu, estadoProducto,especiProducto);
                    p.setId(idProdu);
                    if (p.ConAtributosVacios()) {
                        response.sendRedirect(request.getContextPath() + "/Admin/Productos/modificar.jsp?id="+p.getId());
                    }
                    guardarImagen(imgProduNuevo, archivoDestino);
                    if (pDAO.Modificar(p)) {
                        response.sendRedirect(request.getContextPath() + "/Admin/Productos/");
                    }
                } else {
                    Producto p=new Producto(nombreProdu, descripProdu,imgPrev, marcaProdu, cateProdu, descuentoProducto, precioProdu, cantProdu, estadoProducto,especiProducto);
                    p.setId(idProdu);
                    if (p.ConAtributosVacios()) {
                        response.sendRedirect(request.getContextPath() + "/Admin/Productos/modificar.jsp?id="+p.getId());
                    }
                    if (pDAO.Modificar(p)) {
                        response.sendRedirect(request.getContextPath() + "/Admin/Productos/");
                    }
                }
            }                                   
        }
        
     
        
        if (request.getParameter("EliminarProducto")!=null) {
            int id=Integer.parseInt(request.getParameter("idprodu"));
            if (pDAO.Eliminar(id)) {
                response.sendRedirect(request.getContextPath()+"/Admin/Productos/");
            }
        }
        
        if (request.getParameter("InhabilitarProducto")!=null) {
            int id=Integer.parseInt(request.getParameter("idprodu"));
            if (pDAO.Inhabilitar(id)) {
                response.sendRedirect(request.getContextPath()+"/Admin/Productos/");
            }
        }
        
        if (request.getParameter("HabilitarProducto")!=null) {
            int id=Integer.parseInt(request.getParameter("idprodu"));
            if (pDAO.Habilitar(id)) {
                response.sendRedirect(request.getContextPath()+"/Admin/Productos/");
            }
        }
  
        
    }

    
    private void guardarImagen(Part part, File archivo){

        try {
            Path ruta= Paths.get(part.getSubmittedFileName());
            String archi =ruta.getFileName().toString();
            InputStream input =part.getInputStream();
            if (input != null) {
                File file=new File(archivo, archi);
                Files.copy(input,file.toPath());
            }
        } catch (Exception e) {
            System.out.println(""+e);
        }
    }
    
    
    private Boolean validarExtension(String archivo, String[] exts){
        for (String ext : exts) {
            if (archivo.toLowerCase().endsWith(ext)) {
                return true;
            }
            
        }
        return false;
    }
    
    
}
