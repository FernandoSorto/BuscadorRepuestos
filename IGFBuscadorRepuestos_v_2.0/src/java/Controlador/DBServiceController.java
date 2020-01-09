/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import Config.Conexion;


import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
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
public class DBServiceController {
    
    Conexion con = new Conexion(); 
    ModelAndView mav = new ModelAndView();
    
    @RequestMapping("insertarMasivamente.htm")
    public ModelAndView extraccion(
            @RequestParam(value = "url_db", required = false) String url, 
            @RequestParam(value = "user_db", required = false) String userName,
            @RequestParam(value = "pass_db", required = false) String contrasenia,
            @RequestParam(value = "id_esta", required = true) int id_esta
    ) throws SQLException{
        
        
       
        ResultSet rs=null; 
        List<String> tn = new ArrayList<>();         
        if(url!=null){
            Connection jdbcConnection = DriverManager.getConnection(url, userName, contrasenia); 
            DatabaseMetaData md = jdbcConnection.getMetaData();
            rs = md.getTables(null, null, "%", null);  
            while (rs.next()) {
                String str = rs.getString("table_name");
                tn.add(str);
            }
        } 
        mav.addObject("rs", rs);
        mav.addObject("tn", tn);        
        mav.addObject("url_db", url);
        mav.addObject("user_db", userName);
        mav.addObject("pass_db", contrasenia);      
        mav.setViewName("insertarMasivamente");
        
        return mav;
    }
    
    @RequestMapping(value="insertarMasivamente.htm", method=RequestMethod.POST, params={"tb_nam","url_db","user_db","pass_db"})
    public ModelAndView mostrarInfo(
            @RequestParam(value = "tb_nam", required = true) String tb_nam,
            @RequestParam(value = "url_db", required = false) String url_db,
            @RequestParam(value = "user_db", required = false) String user_db,
            @RequestParam(value = "pass_db", required = false) String pass_db,
            @RequestParam(value = "id_esta", required = true) int id_esta) throws SQLException{
        
        
        Statement st = null;
        String query = "SELECT * FROM " + tb_nam;        
        Connection jdbcConnection = DriverManager.getConnection(url_db, user_db, pass_db);
        st = jdbcConnection.createStatement();
        ResultSet rs = st.executeQuery(query);       
        ResultSetMetaData md = rs.getMetaData();
        int columns = md.getColumnCount();        
        ArrayList list = new ArrayList();
                
        while (rs.next()){
            HashMap row = new HashMap(columns);
            for(int i=1; i<=columns; ++i){           
                row.put(md.getColumnName(i),rs.getObject(i));
            }
             list.add(row);
        }        
        // pasar los atributos de la conexion
        mav.addObject("url_db", url_db );
        mav.addObject("user_db", user_db );
        mav.addObject("pass_db", pass_db );
        mav.addObject("tb_nam", tb_nam);
        mav.addObject("id_est", id_esta);                
        mav.addObject("rs", list);
        mav.setViewName("insertarMasivamente_2");
        
        return mav;
    }
    
    @RequestMapping("insertarMasivamente_2.htm")
    public ModelAndView finalizar(
            @RequestParam(value = "tb_nam", required = true) String tb_nam,
            @RequestParam(value = "url_db", required = false) String url_db,
            @RequestParam(value = "user_db", required = false) String user_db,
            @RequestParam(value = "pass_db", required = false) String pass_db,
            @RequestParam(value = "id_esta", required = true) int id_esta) throws SQLException{
        
        Statement st = null;
        String query = "SELECT * FROM " + tb_nam;
        Connection jdbcConnection = DriverManager.getConnection(url_db, user_db, pass_db);
        st = jdbcConnection.createStatement();
        ResultSet rs = st.executeQuery(query);        
        // preparando la insercion
        JdbcTemplate jdbcTemplate = new JdbcTemplate(con.conectar());       
        //comenzar bucle desde aca       
        ArrayList list = new ArrayList();
        ResultSetMetaData md = rs.getMetaData();               
        while (rs.next()){  
            int i = 2;          
            // inserciones
            // creando repuesto dado a que no existia
            String sql = "INSERT INTO `repuesto`(`id_repuesto`, `nombre`, `marca`, `anio`, `numero_chasis`, `origen`, `descripcion`, `precio`) VALUES (?,?,?,?,?,?,?,?)";
            jdbcTemplate.update(sql, null, rs.getObject(i), rs.getObject(i+1), rs.getObject(i+2), rs.getObject(i+3), rs.getObject(i+4)
                    , rs.getObject(i+5), rs.getObject(i+6));              
            // i+7 son las existencias id_repuesto
            sql = "SELECT id_repuesto FROM `repuesto` "
            + "WHERE nombre = ? AND marca = ? AND anio = ? AND numero_chasis = ? "
            + "AND origen = ? AND descripcion = ?";
            int id_rep = jdbcTemplate.queryForObject(sql, new Object[]{rs.getObject(i), rs.getObject(i+1), rs.getObject(i+2), 
                rs.getObject(i+3), rs.getObject(i+4), rs.getObject(i+5)}, Integer.class);           
            // agregando valor al inventario
            sql = "INSERT INTO `inventario`(`id_inventario`, `id_repuesto`, `id_establecimiento`, `existencias`) VALUES (?,?,?,?)";
            jdbcTemplate.update(sql, null, id_rep, id_esta, rs.getObject(i+7));
        }
        //terminar bucle aca
        String sql = "SELECT * FROM `repuesto` AS t1 LEFT JOIN( SELECT id_repuesto, existencias FROM `establecimiento_repuesto`" + 
                    " AS t3 INNER JOIN `inventario` AS t4 ON t3.id_establecimiento = t4.id_establecimiento" + 
                    " WHERE t3.id_establecimiento=? ) AS t2 ON t1.id_repuesto = t2.id_repuesto WHERE t1.id_repuesto = t2.id_repuesto ";
        List datos = jdbcTemplate.queryForList(sql, id_esta);   
        
        
        // obteniendo email
        sql = "SELECT correo_electronico FROM `establecimiento_repuesto` WHERE id_establecimiento = ? ";
        String email_est = jdbcTemplate.queryForObject(sql, new Object[]{id_esta}, String.class);
        
        mav.addObject("lista", datos);
        mav.addObject("id_est", id_esta); 
        mav.addObject("email_est", email_est);
        mav.setViewName("home");
        return mav;
    }
    
    @RequestMapping(value = "insertarMasivamente.htm", method = RequestMethod.GET)
    public ModelAndView redirectProductoManual(
            @RequestParam(value = "id_esta", required = true) int id_esta){      
        mav.clear();
        mav.addObject("id_est", id_esta);
        mav.setViewName("insertarMasivamente");
        return mav;
    }    
    
}
