/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import Config.Conexion;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Luis
 */
@Controller
public class Controlador {
    Conexion con = new Conexion();
    JdbcTemplate jdbcTemplate = new JdbcTemplate(con.conectar());
    ModelAndView mav = new ModelAndView();
    
    @RequestMapping("index.htm")
    public ModelAndView Listar( 
                @RequestParam(value = "identificadorRep", required = false) String repId){                
        //Si no hay string
        if(repId == null || repId.equals("")){
            String sql = "SELECT * FROM repuesto";
            List datos = this.jdbcTemplate.queryForList(sql);
            mav.addObject("lista", datos);
            mav.setViewName("index");
            return mav;
        }
        else{
           String sql = "SELECT * FROM repuesto WHERE repuesto.nombre = ?";
           List datos = this.jdbcTemplate.queryForList(sql, repId);
           if(datos.isEmpty()){
               sql = "SELECT * FROM repuesto WHERE repuesto.marca = ?";
               datos = this.jdbcTemplate.queryForList(sql, repId);
               if(datos.isEmpty()){
                   sql = "SELECT * FROM repuesto WHERE repuesto.anio = ?";
                   datos = this.jdbcTemplate.queryForList(sql, repId);
                   if(datos.isEmpty()){
                       sql = "SELECT * FROM repuesto WHERE repuesto.numero_chasis = ?";
                       datos = this.jdbcTemplate.queryForList(sql, repId);
                       if(datos.isEmpty()){
                           sql = "SELECT * FROM repuesto WHERE repuesto.origen = ?";
                           datos = this.jdbcTemplate.queryForList(sql, repId);
                           if(datos.isEmpty()){
                               sql = "SELECT * FROM repuesto WHERE repuesto.precio = ?";
                               datos = this.jdbcTemplate.queryForList(sql, repId);
                           }
                       }
                   }
               }
           }
           mav.addObject("lista", datos);
           mav.setViewName("index");
           return mav; 
        }   
    }
    
    @RequestMapping("registrarse.htm")
    public ModelAndView agregar( 
            @RequestParam(value = "nom_est", required = true) String nom_est,
            @RequestParam(value = "dir_est", required = true) String dir_est,
            @RequestParam(value = "email_est", required = true) String email_est,
            @RequestParam(value = "pass_est", required = true) String pass_est){       
        // creando establecimiento
        String sql = "INSERT INTO `establecimiento_repuesto` (`id_establecimiento`, `nombre`, `direccion`, `correo_electronico`) VALUES (?, ?, ?, ?)";
        jdbcTemplate.update(sql, null, nom_est, dir_est, email_est);        
        // creando cuenta
        // obteniendo id del establecimiento
        sql = "SELECT id_establecimiento FROM `establecimiento_repuesto` WHERE correo_electronico = ?";
        int id = jdbcTemplate.queryForObject(sql, new Object[]{email_est}, Integer.class);
        // obteniendo fecha con formato de inicio
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate date = LocalDate.now(); 
        String fecha_preparada = date.format(formatter);
        LocalDate date_2 = date.plusMonths(2);
        String fecha_2_preparada = date_2.format(formatter);        
        sql = "INSERT INTO `cuenta` (`id_cuenta`, `id_establecimiento`, `contrasenia`, `fecha_inicio`, `fecha_expiracion`, `estado`) VALUES (?, ?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql, null, id, pass_est, fecha_preparada, fecha_2_preparada, "VIGENTE");        
        
        
        sql = "SELECT * FROM `repuesto` AS t1 LEFT JOIN( SELECT id_repuesto FROM `establecimiento_repuesto`" + 
                " AS t3 INNER JOIN `inventario` AS t4 ON t3.id_establecimiento = t4.id_establecimiento" + 
                " WHERE t3.id_establecimiento=? ) AS t2 ON t1.id_repuesto = t2.id_repuesto WHERE t1.id_repuesto = t2.id_repuesto ";
        List datos = this.jdbcTemplate.queryForList(sql, id);          
      
         
        mav.addObject("email_est", email_est);
        mav.addObject("id_est", id);
        mav.addObject("lista", datos );
        mav.setViewName("home");
        return mav;    
    }
    
    @RequestMapping("iniciaSesion.htm")
    public ModelAndView Acceder( 
            @RequestParam(value = "email_est", required = true) String email_est,
            @RequestParam(value = "pass_est", required = true) String pass_est){        
        // primera validacion necesaria
        String sql = "SELECT id_establecimiento FROM `establecimiento_repuesto` WHERE correo_electronico = ?";
        int id = jdbcTemplate.queryForObject(sql, new Object[]{email_est}, Integer.class);        
        // segunda validacion necesaria
        sql = "SELECT * FROM `cuenta` WHERE contrasenia = ? AND id_establecimiento = ?";
        List cuenta = jdbcTemplate.queryForList(sql, pass_est, id);        
        //Falta "atrapar" las excepciones
        //
        //
        //        
        if(!cuenta.isEmpty()){
            sql = "SELECT * FROM `repuesto` AS t1 LEFT JOIN( SELECT id_repuesto, existencias FROM `establecimiento_repuesto`" + 
                    " AS t3 INNER JOIN `inventario` AS t4 ON t3.id_establecimiento = t4.id_establecimiento" + 
                    " WHERE t3.id_establecimiento=? ) AS t2 ON t1.id_repuesto = t2.id_repuesto WHERE t1.id_repuesto = t2.id_repuesto ";
            List datos = this.jdbcTemplate.queryForList(sql, id);          
            mav.addObject("lista", datos);
            mav.addObject("email_est", email_est);
            mav.addObject("id_est", id);
            mav.setViewName("home");
            return mav;  
        }
        else{
            mav.setViewName("iniciaSesion");
            return mav;         
        }
    }
    
    @RequestMapping("home.htm")
    public ModelAndView guardarProducto( 
            @RequestParam(value = "nom_rep", required = true) String nom_rep,
            @RequestParam(value = "mar_rep", required = true) String mar_rep,
            @RequestParam(value = "ani_rep", required = true) String ani_rep,
            @RequestParam(value = "num_rep", required = true) String num_rep,
            @RequestParam(value = "ori_rep", required = true) String ori_rep,
            @RequestParam(value = "des_rep", required = true) String des_rep,
            @RequestParam(value = "pre_rep", required = true) String pre_rep,
            @RequestParam(value = "exi_rep", required = true) String exi_rep,
            @RequestParam(value = "id_esta", required = true) int id_esta,
            @RequestParam(value = "email_est", required = true) String eml_est){     
        // verificando que repuesto exista
        String mensaje = "";       
        String sql = "SELECT * FROM `repuesto` "
                + "WHERE nombre = ? AND marca = ? AND anio = ? AND numero_chasis = ? "
                + "AND origen = ? AND descripcion = ?";
        List repuestos = this.jdbcTemplate.queryForList(sql, nom_rep, mar_rep, ani_rep, num_rep, ori_rep, des_rep );       
        if(repuestos.isEmpty()){
            // creando repuesto dado a que no existia
            sql = "INSERT INTO `repuesto`(`id_repuesto`, `nombre`, `marca`, `anio`, `numero_chasis`, `origen`, `descripcion`, `precio`) VALUES (?,?,?,?,?,?,?,?)";
            jdbcTemplate.update(sql, null, nom_rep, mar_rep, ani_rep, num_rep, ori_rep, des_rep, pre_rep);               
            // id_repuesto
            sql = "SELECT id_repuesto FROM `repuesto` "
                + "WHERE nombre = ? AND marca = ? AND anio = ? AND numero_chasis = ? "
                + "AND origen = ? AND descripcion = ?";
            int id_rep = jdbcTemplate.queryForObject(sql, new Object[]{nom_rep, mar_rep, ani_rep, num_rep, ori_rep, des_rep}, Integer.class);           
            // agregando valor al inventario
            sql = "INSERT INTO `inventario`(`id_inventario`, `id_repuesto`, `id_establecimiento`, `existencias`) VALUES (?,?,?,?)";
            jdbcTemplate.update(sql, null, id_rep, id_esta, exi_rep);
        }
        else{           
            // comparano que no existiera con el mismo precio
            sql = "SELECT precio FROM `repuesto` "
                + "WHERE nombre = ? AND marca = ? AND anio = ? AND numero_chasis = ? "
                + "AND origen = ? AND descripcion = ? ";
            float precio = jdbcTemplate.queryForObject(sql, new Object[]{nom_rep, mar_rep, ani_rep, num_rep, ori_rep, des_rep }, Float.class);
            if(precio == Float.valueOf(pre_rep)){
                
                mensaje = "Repuesto ya existe cambiar descripcion o precio";
            }
            else{
                mensaje = "Repuesto ya existe cambiar descripcion ";
            }    
        }    
        sql = "SELECT * FROM `repuesto` AS t1 LEFT JOIN( SELECT id_repuesto, existencias FROM `establecimiento_repuesto`" + 
                    " AS t3 INNER JOIN `inventario` AS t4 ON t3.id_establecimiento = t4.id_establecimiento" + 
                    " WHERE t3.id_establecimiento=? ) AS t2 ON t1.id_repuesto = t2.id_repuesto WHERE t1.id_repuesto = t2.id_repuesto ";
        List datos = this.jdbcTemplate.queryForList(sql, id_esta);
        
        
        
        mav.addObject("lista", datos);
        mav.addObject("email_est", eml_est);
        mav.addObject("id_est", id_esta);
        mav.addObject("mensaje", mensaje);
        mav.setViewName("home");
        return mav;    
    }
    
    @RequestMapping(value = "registrarse.htm", method = RequestMethod.GET)
    public String redirectRegistrarse(){
        return "registrarse";
    }
    
    @RequestMapping(value = "iniciaSesion.htm", method = RequestMethod.GET)
    public String redirectInicioSesion(){
        return "iniciaSesion";
    }
    
    @RequestMapping(value = "insertarMasivamente.htm", method = RequestMethod.POST)
    public ModelAndView redirectProductoManual(
            @RequestParam(value = "id_esta", required = true) int id_esta,
            @RequestParam(value = "email_est", required = true) int email_est){      
        
        mav.addObject("email_est", email_est);
        mav.setViewName("insertarMasivamente");
        return mav;
    }
    
    @RequestMapping("comparacionRepuesto.htm")
    public ModelAndView redirectComparacion(
            @RequestParam(value = "id_rep", required = true) int id_rep){      
               
        String sql = "SELECT * FROM `inventario` WHERE id_repuesto = ?";
        List infoInv = this.jdbcTemplate.queryForList(sql, id_rep);       
        sql = "SELECT id_establecimiento FROM `inventario` WHERE id_repuesto = ?";
        int id_est = jdbcTemplate.queryForObject(sql, new Object[]{id_rep}, Integer.class);         
        sql = "SELECT * FROM `establecimiento_repuesto` WHERE id_establecimiento = ?";
        List infoEst = this.jdbcTemplate.queryForList(sql, id_est);       
        sql = "SELECT * FROM `repuesto` WHERE id_repuesto = ?";
        List infoRep = this.jdbcTemplate.queryForList(sql, id_rep);      
        mav.addObject("id_rep", id_rep);
        mav.addObject("infoInv", infoInv);
        mav.addObject("infoEst", infoEst);
        mav.addObject("infoRep", infoRep);
        mav.setViewName("comparacionRepuesto");
        return mav;
    }
    
       @RequestMapping(value="home.htm", method=RequestMethod.POST, params={"nom_rep","mar_rep","ani_rep","num_rep","ori_rep","des_rep","pre_rep","exi_rep","id_esta","email_est", "id_rep"})
        public ModelAndView editarRepuesto(
            @RequestParam(value = "nom_rep", required = true) String nom_rep,
            @RequestParam(value = "mar_rep", required = true) String mar_rep,
            @RequestParam(value = "ani_rep", required = true) String ani_rep,
            @RequestParam(value = "num_rep", required = true) String num_rep,
            @RequestParam(value = "ori_rep", required = true) String ori_rep,
            @RequestParam(value = "des_rep", required = true) String des_rep,
            @RequestParam(value = "pre_rep", required = true) String pre_rep,
            @RequestParam(value = "exi_rep", required = true) String exi_rep,
            @RequestParam(value = "id_esta", required = true) int id_esta,
            @RequestParam(value = "email_est", required = true) String eml_est,
            @RequestParam(value = "id_rep", required = true) int id_rep){  
        
            String sql = "UPDATE `repuesto` SET `nombre`= ?,`marca`=?,"
                    + "`anio`=?,`numero_chasis`=?,`origen`=?,`descripcion`=?,`precio`=? WHERE id_repuesto = ?";
            
            jdbcTemplate.update(sql, nom_rep, mar_rep, ani_rep, num_rep, ori_rep, des_rep, pre_rep, id_rep);
            
            sql = "UPDATE `inventario` SET `existencias`= ? WHERE id_repuesto = ?";
            jdbcTemplate.update(sql, exi_rep, id_rep);
            
            
            sql = "SELECT * FROM `repuesto` AS t1 LEFT JOIN( SELECT id_repuesto, existencias FROM `establecimiento_repuesto`" + 
                    " AS t3 INNER JOIN `inventario` AS t4 ON t3.id_establecimiento = t4.id_establecimiento" + 
                    " WHERE t3.id_establecimiento=? ) AS t2 ON t1.id_repuesto = t2.id_repuesto WHERE t1.id_repuesto = t2.id_repuesto ";
            List datos = this.jdbcTemplate.queryForList(sql, id_esta);
            mav.addObject("lista", datos);
            mav.addObject("email_est", eml_est);
            mav.addObject("id_est", id_esta);
            mav.setViewName("home");
            return mav;
        } 
        
        
}
