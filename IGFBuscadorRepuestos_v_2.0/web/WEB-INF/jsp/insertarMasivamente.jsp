<%-- 
    Document   : insertarMasivamente
    Created on : Jan 6, 2020, 9:08:22 AM
    Author     : Luis
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        
        <title>Insertar</title>
    </head>
    <body>
        <nav class="navbar navbar navbar-expand-lg navbar-dark bg-dark ">
            <a class="navbar-brand text-light" >Agregar via conexion con base de datos</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto"></ul>
                
                <c:choose>
                    <c:when test="${rs==null}">
                        <button class="btn btn-outline-success my-2 my-sm-0" onclick="history.go(-1)">Regresar</button>
                    </c:when>
                    <c:otherwise>
                        <button class="btn btn-outline-success my-2 my-sm-0" onclick="history.go(-2)">Regresar</button>
                    </c:otherwise>
                </c:choose>
                 
                <span class="navbar-text mr-sm-2 text-muted">&nbsp o </span>
                <form class="form-inline my-2 my-lg-0">
                    <a class="btn btn-outline-success my-2 my-sm-0" href="index.htm">Cerrar sesion</a>
                </form>
                
                
            </div>
        </nav>
            
            <br>
            
        <div class="container">
            
            <c:choose>
                <c:when test="${rs==null}">
                    <form action="insertarMasivamente.htm" method="POST">
                        <div class="form-group">
                            <label for="emailEstablecimiento">Url de la base mysql</label>
                            <input name="url_db" class="form-control" id="emailEstablecimiento" aria-describedby="emailHelp" placeholder="ej. jdbc:mysql://[direccion ip]:[puerto]/[nombre de la base]">
                        </div>  
                        <div class="form-group">
                            <label for="contraseniaEstablecimiento">Usuario</label>
                            <input name="user_db" class="form-control" id="contraseniaEstablecimiento" placeholder="Nombre del usuario de la base de datos">
                        </div>
                        <div class="form-group">
                            <label for="contraseniaEstablecimiento">Password</label>
                            <input name="pass_db" type="password" class="form-control" id="contraseniaEstablecimiento" placeholder="Contrasenia">
                        </div>
                        
                        <input name="id_esta"  type="hidden" value="${id_est}">
                        
                        <button type="submit" class="btn btn-primary">Acceder</button>
                    </form>                   
                </c:when>
                <c:otherwise>
                    Estas son las tablas encontradas en la base de datos:
                    <br><br>
                    
                    <ul>
                    <c:forEach var="f" items="${tn}">
                        <li>${f}</li>
                        <br><br>
                    </c:forEach>
                    </ul>
                        
                    
                    <form action="insertarMasivamente.htm" method="post" >
                        <div class="form-group">
                            <label >Escribe el nombre correspondiente a los repuestos</label>
                            <input name="tb_nam" class="form-control" id="emailEstablecimiento" aria-describedby="emailHelp" placeholder="">
                            <small  class="form-text text-muted">Recuerda que la tabla debe contener: nombre, marca, anio,numero de chasis, origen, descripcion, precio y existencia</small>
                        </div>
                        
                        <input type="hidden" name="url_db" value="${url_db}">
                        <input type="hidden" name="user_db" value="${user_db}">
                        <input type="hidden" name="pass_db" value="${pass_db}">
                        <input name="id_esta"  type="hidden" value="${id_est}">
                        
                        <button type="submit" value="/nombretabla"  class="btn btn-primary">Elegir</button>
                    </form> 
                </c:otherwise>
            </c:choose>
        </div> 
                       
    </body>
</html>
