
package Controlador;

import DAO.CategoriasDAO;
import Modelos.Categoria;
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
public class ctrlCategorias extends HttpServlet {
    
    private CategoriasDAO cDAO=new CategoriasDAO();
    private String rutaDestinoBanner="C:\\Users\\Administrator\\Documents\\NetBeansProjects\\Proyecto_DWI\\src\\main\\webapp\\images\\Categorias\\banners";
    private String rutaDestinoImg="C:\\Users\\Administrator\\Documents\\NetBeansProjects\\Proyecto_DWI\\src\\main\\webapp\\images\\Categorias\\imgs";
    private String rutaArchivoBanner="../images/Categorias/banners/";
    private String rutaArchivoImg="../images/Categorias/imgs/";
    private File archivoDestinoBanner= new File(rutaDestinoBanner);
     private File archivoDestinoImg= new File(rutaDestinoImg);
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
        
        
        
        if (request.getParameter("InsertarCategoria") !=null) {
            String nombreCategoria=request.getParameter("nombreCategoria");
            String descCategoria=request.getParameter("descripcionCategoria");
            Part imgRef=request.getPart("imgCategoria");
            Part bannerRef=request.getPart("bannerCategoria");
            if (validarExtension(imgRef.getSubmittedFileName(), extensiones) && validarExtension(bannerRef.getSubmittedFileName(), extensiones) ) {
                Categoria c=new Categoria(nombreCategoria, descCategoria, rutaArchivoImg+imgRef.getSubmittedFileName(),rutaArchivoBanner+bannerRef.getSubmittedFileName());
                if (c.ConAtributosVacios()) {
                    response.sendRedirect(request.getContextPath() + "/Admin/Categorias/");
                }
                guardarImagen(imgRef, archivoDestinoImg);
                guardarImagen(bannerRef, archivoDestinoBanner);
                if (cDAO.Insertar(c)) {
                    response.sendRedirect(request.getContextPath() + "/Admin/Categorias/");
                }
                
            }
        }
        
        if (request.getParameter("EliminarCategoria")!=null) {
            int idMarca=Integer.parseInt(request.getParameter("idCategoria"));
            if (cDAO.Eliminar(idMarca)) {
                response.sendRedirect(request.getContextPath() + "/Admin/Categorias/");
            }
        }
        
        if (request.getParameter("ModificarCategoria")!=null) {
            
            String nombreCategoria=request.getParameter("nombreCategoria");
            String descCategoria=request.getParameter("descripcionCategoria");
            int idMarca=Integer.parseInt(request.getParameter("idCategoria"));
            Part imgRefNuevo=request.getPart("imgCategoriaNuevo");
            Part bannerRefNuevo=request.getPart("bannerCategoriaNuevo");
            String imgPrev=request.getParameter("imgUrlCate");
            String bannerPrev=request.getParameter("bannerUrlCate");
            
            if (idMarca>0) {
                if (imgRefNuevo.getSubmittedFileName()!="" && bannerRefNuevo.getSubmittedFileName()!="") {
                    Categoria c=new Categoria(nombreCategoria, descCategoria, rutaArchivoImg+imgRefNuevo.getSubmittedFileName(),rutaArchivoBanner+bannerRefNuevo.getSubmittedFileName());
                    c.setId(idMarca);
                    if (c.ConAtributosVacios()) {
                        response.sendRedirect(request.getContextPath() + "/Admin/Categorias/modificar.jsp?id="+c.getId());
                    }
                    guardarImagen(imgRefNuevo, archivoDestinoImg);
                    guardarImagen(bannerRefNuevo, archivoDestinoBanner);
                    if (cDAO.Modificar(c)) {
                        response.sendRedirect(request.getContextPath() + "/Admin/Categorias/");
                    }
                    
                } else if(imgRefNuevo.getSubmittedFileName()!="" && bannerRefNuevo.getSubmittedFileName()==""){
                    Categoria c=new Categoria(nombreCategoria, descCategoria, rutaArchivoImg+imgRefNuevo.getSubmittedFileName(),bannerPrev);
                    c.setId(idMarca);
                    if (c.ConAtributosVacios()) {
                        response.sendRedirect(request.getContextPath() + "/Admin/Categorias/modificar.jsp?id="+c.getId());
                    }
                    guardarImagen(imgRefNuevo, archivoDestinoImg);
                    if (cDAO.Modificar(c)) {
                        response.sendRedirect(request.getContextPath() + "/Admin/Categorias/");
                    }
                } else if(imgRefNuevo.getSubmittedFileName()=="" && bannerRefNuevo.getSubmittedFileName()!=""){
                    Categoria c=new Categoria(nombreCategoria, descCategoria, imgPrev,rutaArchivoBanner+bannerRefNuevo.getSubmittedFileName());
                    c.setId(idMarca);
                    if (c.ConAtributosVacios()) {
                        response.sendRedirect(request.getContextPath() + "/Admin/Categorias/modificar.jsp?id="+c.getId());
                    }
                    guardarImagen(bannerRefNuevo, archivoDestinoBanner);
                    if (cDAO.Modificar(c)) {
                        response.sendRedirect(request.getContextPath() + "/Admin/Categorias/");
                    }
                } else {
                    Categoria c=new Categoria(nombreCategoria, descCategoria, imgPrev,bannerPrev);
                    c.setId(idMarca);
                    if (c.ConAtributosVacios()) {
                        response.sendRedirect(request.getContextPath() + "/Admin/Categorias/modificar.jsp?id="+c.getId());
                    }
                    if (cDAO.Modificar(c)) {
                        response.sendRedirect(request.getContextPath() + "/Admin/Categorias/");
                    }
                }
            }
            
        }
        



   
    }
    

    
    private Boolean guardarImagen(Part part, File archivo){

        try {
            Path ruta= Paths.get(part.getSubmittedFileName());
            String archi =ruta.getFileName().toString();
            InputStream input =part.getInputStream();
            if (input != null) {
                File file=new File(archivo, archi);
                Files.copy(input,file.toPath());
                return true;
            }
        } catch (Exception e) {
        }
        return false;
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
