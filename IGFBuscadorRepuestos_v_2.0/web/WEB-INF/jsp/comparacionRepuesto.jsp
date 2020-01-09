<%-- 
    Document   : comparacionRepuesto
    Created on : Jan 8, 2020, 11:16:12 AM
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
        <title>Detalles </title>
    </head>
    <body>
        <nav class="navbar navbar-dark bg-dark">
            <a class="navbar-brand text-light ">Informacion del producto</a>
            <form class="form-inline">
                
                <span class="navbar-text mr-sm-2 text-muted">Buscar repuesto</span>
                <a class="btn btn-outline-success my-2 my-sm-0" href="index.htm">Regresar</a>
            </form>
        </nav>
        <br>
        
        <div class="container">
            
                  
            <div>
                <h4>Informacion acerca del repuesto</h4><br>
                <table class="table table-bordered">
                    <thead class="thead-light">
                        <tr>
                            <th>Nombre</th>
                            <th>Marca</th>
                            <th>Anio</th>
                            <th>Numero de chasis</th>
                            <th>Origen</th>
                            <th>Descripcion</th>
                            <th>Precio</th>
                        </tr>
                    </thead>
                    <c:forEach var="f" items="${infoRep}">
                        <tr>
                            <td>${f.nombre}</td>
                            <td>${f.marca}</td>
                            <td>${f.anio}</td>
                            <td>${f.numero_chasis}</td>
                            <td>${f.origen}</td>
                            <td>${f.descripcion}</td>
                            <td>${f.precio}</td>     
                        </tr>
                    </c:forEach>
                </table>
                        
                <br><h4>Informacion acerca del local</h4><br>
                
                <table class="table table-bordered">
                    <thead class="thead-light">
                        <tr>
                            <th>Nombre</th>
                            <th>Direccion</th>
                            <th>Correo electronico</th>
                        </tr>
                    </thead>
                    <c:forEach var="f" items="${infoEst}">
                        <tr>
                            <td>${f.nombre}</td>
                            <td>${f.direccion}</td>
                            <td>${f.correo_electronico}</td>   
                        </tr>
                    </c:forEach>
                </table>        
                 
                <br><h4>Informacion acerca de las existencias</h4><br>
                
                <table class="table table-bordered">
                    <thead class="thead-light">
                        <tr>
                            <th>Existencias</th>
                        </tr>
                    </thead>
                    <c:forEach var="f" items="${infoInv}">
                        <tr>
                            <td>${f.existencias}</td>  
                        </tr>
                    </c:forEach>
                </table>                        
            </div>            
        </div>           
    </body>
</html>
