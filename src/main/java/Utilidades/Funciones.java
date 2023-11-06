
package Utilidades;

import java.net.MalformedURLException;
import java.net.URL;

public class Funciones {
    
    public static boolean URLcontiene(String urlSTR,String archivo) {
        try {
            URL url = new URL(urlSTR);
            String ruta = url.getPath();
            if (ruta.contains(archivo)) {
                return true;
            } else {
                return false;
            }
        } catch (MalformedURLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
