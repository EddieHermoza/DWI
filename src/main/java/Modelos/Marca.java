
package Modelos;


public class Marca {
    private int id;
    private String nombre;
    private String desc;
    private String BannerRef;
    
    public Marca(){}
    
    public Marca(String nombre, String desc, String BannerRef) {
        this.nombre = nombre;
        this.desc = desc;
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
        (BannerRef == null || BannerRef.isBlank());
    }
    
}
