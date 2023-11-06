
package Modelos;


public class Categoria {
    private int id;
    private String nombre;
    private String desc;
    private String imgRef;
    private String BannerRef;

    public Categoria() {}
   
    
    public Categoria(String nombre, String desc, String imgRef, String BannerRef) {
        this.nombre = nombre;
        this.desc = desc;
        this.imgRef = imgRef;
        this.BannerRef = BannerRef;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    
    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public String getImgRef() {
        return imgRef;
    }

    public void setImgRef(String imgRef) {
        this.imgRef = imgRef;
    }

    public String getBannerRef() {
        return BannerRef;
    }

    public void setBannerRef(String BannerRef) {
        this.BannerRef = BannerRef;
    }
    
    public boolean ConAtributosVacios() {
        return
        (nombre == null || nombre.isBlank()) ||
        (desc == null || desc.isBlank()) ||
        (imgRef == null || imgRef.isBlank()) ||
        (BannerRef == null || BannerRef.isBlank());
    }
    
    
}
