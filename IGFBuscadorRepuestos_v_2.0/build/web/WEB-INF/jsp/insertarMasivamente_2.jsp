<%-- 
    Document   : insertarMasivamente_2
    Created on : Jan 6, 2020, 5:25:22 PM
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
        <a class="navbar-brand text-light" >Confirmacion</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto"></ul>
            
            <button class="btn btn-outline-success my-2 my-sm-0" onclick="history.go(-3)">Cancelar</button>
            <span class="navbar-text mr-sm-2 text-muted">&nbsp o </span>
            <form class="form-inline my-2 my-lg-0">
                <a class="btn btn-outline-success my-2 my-sm-0" href="index.htm">Cerrar sesion</a>
            </form>
            
        </div>
    </nav> 
        
        <div class="container">
            
            <br>         
            <form action="insertarMasivamente_2.htm" method="post">
                <button class="btn btn-primary" type="submit" >Confirmar</button>
                <br><br>
                <input type="hidden" value="${url_db}" name="url_db">
                <input type="hidden" value="${user_db}" name="user_db">
                <input type="hidden" value="${pass_db}" name="pass_db">
                <input type="hidden" value="${tb_nam}" name="tb_nam">
                <input type="hidden" value="${id_est}" name="id_esta"  >
            </form>  

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
                        <th>Existencia</th>
                    </tr>
                </thead>
                <c:forEach var="f" items="${rs}">
                    <tr>
                        <td>${f.nombre}</td>
                        <td>${f.marca}</td>
                        <td>${f.anio}</td>
                        <td>${f.numero_chasis}</td>
                        <td>${f.origen}</td>
                        <td>${f.descripcion}</td>
                        <td>${f.precio}</td>
                        <td>${f.existencias}</td>
                    </tr>
                </c:forEach>
            </table>            
        </div>      
    </body>
</html>
