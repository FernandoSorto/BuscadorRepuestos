<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <title>Buscador de repuestos</title>
    </head>

    <body>
        
        <nav class="navbar navbar-dark bg-dark">
            <a class="navbar-brand text-light ">Bienvenido al Buscador de Repuestos!</a>
            <form class="form-inline">
                
                <span class="navbar-text mr-sm-2 text-muted">Quieres registrar tu establecimiento?</span>
                <a class="btn btn-outline-success my-2 my-sm-0" href="registrarse.htm">click aca!</a>
                <span class="navbar-text mr-sm-2 text-muted">&nbsp o </span>
                <a class="btn btn-outline-success my-2 my-sm-0" href="iniciaSesion.htm">inicia sesion</a>
            </form>
        </nav>
        
        <br>
        <div class="container">
            
            <form action="index.htm" method="POST" >
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <input class="btn btn-outline-secondary" type="submit" value="Buscar"></input>
                    </div>
                    <input type="text" name="identificadorRep" value="" class="form-control" placeholder="" aria-label="" aria-describedby="basic-addon1">
                </div>
            </form>
            
            <div>
                <table class="table table-bordered">
                    <thead class="thead-light">
                        <tr>
                            <th>Nombre</th>
                            <th>Marca</th>
                            <th>Anio</th>
                            <th>Numero de chasis</th>
                            <th>Origen</th>
                            <th>Descripcion</th>
                            <th>Precio($)</th>
                            <th>Informacion</th>
                        </tr>
                    </thead>
                    <c:forEach var="f" items="${lista}">
                        <tr>
                            <td>${f.nombre}</td>
                            <td>${f.marca}</td>
                            <td>${f.anio}</td>
                            <td>${f.numero_chasis}</td>
                            <td>${f.origen}</td>
                            <td>${f.descripcion}</td>
                            <td>${f.precio}</td>
                            
                        <form action="comparacionRepuesto.htm" >
                            <td><button type="submit" class="btn btn-primary">Seleccionar</button></td>
                            <input type="hidden" name="id_rep" value="${f.id_repuesto}">
                        </form>      
                        </tr>
                    </c:forEach>
                </table>
            </div>
            
        </div>
    </body>
</html>
