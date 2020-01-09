/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Entity;

import java.io.Serializable;
import java.util.Collection;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Luis
 */
@Entity
@Table(name = "establecimiento_repuesto")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "EstablecimientoRepuesto.findAll", query = "SELECT e FROM EstablecimientoRepuesto e"),
    @NamedQuery(name = "EstablecimientoRepuesto.findByIdEstablecimiento", query = "SELECT e FROM EstablecimientoRepuesto e WHERE e.idEstablecimiento = :idEstablecimiento"),
    @NamedQuery(name = "EstablecimientoRepuesto.findByNombre", query = "SELECT e FROM EstablecimientoRepuesto e WHERE e.nombre = :nombre"),
    @NamedQuery(name = "EstablecimientoRepuesto.findByDireccion", query = "SELECT e FROM EstablecimientoRepuesto e WHERE e.direccion = :direccion"),
    @NamedQuery(name = "EstablecimientoRepuesto.findByCorreoElectronico", query = "SELECT e FROM EstablecimientoRepuesto e WHERE e.correoElectronico = :correoElectronico")})
public class EstablecimientoRepuesto implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_establecimiento")
    private Integer idEstablecimiento;
    @Size(max = 30)
    @Column(name = "nombre")
    private String nombre;
    @Size(max = 100)
    @Column(name = "direccion")
    private String direccion;
    @Size(max = 50)
    @Column(name = "correo_electronico")
    private String correoElectronico;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idEstablecimiento")
    private Collection<Cuenta> cuentaCollection;
    @OneToMany(mappedBy = "idEstablecimiento")
    private Collection<Inventario> inventarioCollection;

    public EstablecimientoRepuesto() {
    }

    public EstablecimientoRepuesto(Integer idEstablecimiento) {
        this.idEstablecimiento = idEstablecimiento;
    }

    public Integer getIdEstablecimiento() {
        return idEstablecimiento;
    }

    public void setIdEstablecimiento(Integer idEstablecimiento) {
        this.idEstablecimiento = idEstablecimiento;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getCorreoElectronico() {
        return correoElectronico;
    }

    public void setCorreoElectronico(String correoElectronico) {
        this.correoElectronico = correoElectronico;
    }

    @XmlTransient
    public Collection<Cuenta> getCuentaCollection() {
        return cuentaCollection;
    }

    public void setCuentaCollection(Collection<Cuenta> cuentaCollection) {
        this.cuentaCollection = cuentaCollection;
    }

    @XmlTransient
    public Collection<Inventario> getInventarioCollection() {
        return inventarioCollection;
    }

    public void setInventarioCollection(Collection<Inventario> inventarioCollection) {
        this.inventarioCollection = inventarioCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idEstablecimiento != null ? idEstablecimiento.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof EstablecimientoRepuesto)) {
            return false;
        }
        EstablecimientoRepuesto other = (EstablecimientoRepuesto) object;
        if ((this.idEstablecimiento == null && other.idEstablecimiento != null) || (this.idEstablecimiento != null && !this.idEstablecimiento.equals(other.idEstablecimiento))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entidades.EstablecimientoRepuesto[ idEstablecimiento=" + idEstablecimiento + " ]";
    }
    
}
