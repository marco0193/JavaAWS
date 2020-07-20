package Interfaces;

public class Buckets {
    private String nombre;
    private String creationDate;

    public Buckets(String nombre, String creationDate) {
        this.nombre = nombre;
        this.creationDate = creationDate;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(String creationDate) {
        this.creationDate = creationDate;
    }
}
