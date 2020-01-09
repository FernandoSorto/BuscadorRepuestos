<%-- 
    Document   : home
    Created on : Dec 19, 2019, 12:25:22 PM
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
        
        <title>Home</title>
    </head>
    
    <body>
        <nav class="navbar navbar navbar-expand-lg navbar-dark bg-dark ">
            <a class="navbar-brand text-light" >Bienvenido ${email_est}!</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Agregar productos</a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a type="button" class="dropdown-item" data-toggle="modal" data-target="#exampleModal">Manualmente</a>
                            
                            <form action="insertarMasivamente.htm" method="get">
                                <button class="dropdown-item" type="submit" >Masivamente</button>
                                <input name="id_esta"  type="hidden" value="${id_est}">
                            </form>
                        </div>
                    </li>
                    
                </ul>
                
                <form class="form-inline my-2 my-lg-0">
                    <a class="btn btn-outline-success my-2 my-sm-0" href="index.htm">Cerrar sesion</a>
                </form>
                
                
            </div>
        </nav>       
        <br>
        <div class="container">
            <h1>${mensaje}</h1>
            
            <div>
                <h2>Tus Repuestos </h2>
            </div>    
            <br>
        
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
                            <th>Existencias</th>
                            <th>Modificar</th>
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
                            <td>${f.existencias}</td>
                            
                        
                            <td><button class="btn btn-primary" data-toggle="modal" data-target="#editarModal${f.id_repuesto}">Editar</button></td>
                            
                            
                        
                <!-- COMIENZO DEL MODAL editar producto -->
                <div class="modal fade" id="editarModal${f.id_repuesto}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Editando repuesto</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            
                            <form action="home.htm" method="post" >
                                
                                <div class="modal-body">  
                                    <!-- nombre -->
                                    <div class="form-group">
                                        <label for="exampleInputEmail1">Nombre</label>
                                        <input name="nom_rep"  class="form-control" aria-describedby="emailHelp" placeholder="Digita el nombre del repuesto" value="${f.nombre}">
                                    </div>
                                    <!-- marca -->
                                    <div class="form-group">
                                        <label for="exampleInputEmail1">Marca</label>
                                        <input name="mar_rep"  class="form-control" aria-describedby="emailHelp" placeholder="Digita el nombre del repuesto" value="${f.marca}">
                                    </div>
                                    <!-- anio -->
                                    <div class="form-group">
                                        <label for="exampleInputEmail1">Año del repuesto</label>
                                        <input name="ani_rep"  class="form-control" aria-describedby="emailHelp" placeholder="Formato: YYYY" value="${f.anio}">
                                    </div>
                                    <!-- numero_chasis -->
                                    <div class="form-group">
                                        <label for="exampleInputEmail1">Numero de chasis</label>
                                        <input name="num_rep"  class="form-control" aria-describedby="emailHelp" placeholder="Debe seguir el estandar, y tener 17 caracteres" value="${f.numero_chasis}">
                                    </div>
                                    <!-- origen -->
                                    <div class="form-group">
                                        <label for="exampleInputEmail1">Origen</label>
                                        <input name="ori_rep"  class="form-control" aria-describedby="emailHelp" placeholder="Nombre del pais de origen del repuesto" value="${f.origen}">
                                    </div>
                                    <!-- descripcion-->
                                    <div class="form-group">
                                        <label for="exampleInputEmail1">Descripcion</label>
                                        <input name="des_rep"  class="form-control" aria-describedby="emailHelp" placeholder="Breve descripcion. Puedes especificar el modelo del auto aca" value="${f.descripcion}">
                                    </div>
                                    <!-- precio -->
                                    <div class="form-group">
                                        <label for="exampleInputEmail1">Precio</label>
                                        <input name="pre_rep"  class="form-control" aria-describedby="emailHelp" placeholder="$ 0.00" value="${f.precio}">
                                    </div>
                                    
                                    <!-- existencias -->
                                    <div class="form-group">
                                        <label for="exampleInputEmail1">Existencias</label>
                                        <input name="exi_rep"  class="form-control" aria-describedby="emailHelp" placeholder="Numero de articulos disponibles" value="${f.existencias}">
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                                    <button type="submit"  class="btn btn-primary">Guardar</button>
                                </div>
                                <input name="id_esta"  type="hidden" value="${id_est}">
                                <input name="email_est" type="hidden" value="${email_est}">
                                <input name="id_rep" type="hidden" value="${f.id_repuesto}">
                            </form>
                        </div>
                    </div>
                </div>
                <!-- FIN DEL MODAL editar producto -->
                            
                            
                            
                        </tr>
                    </c:forEach>
                </table>
            </div>    
        </div>     
        <!-- COMIENZO DEL MODAL agregar producto -->
                <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Agregando repuesto manualmente</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <form action="home.htm"  method="POST">
                                
                                <div class="modal-body">  
                                    <!-- nombre -->
                                    <div class="form-group">
                                        <label for="exampleInputEmail1">Nombre</label>
                                        <input name="nom_rep"  class="form-control" aria-describedby="emailHelp" placeholder="Digita el nombre del repuesto">
                                    </div>
                                    <!-- marca -->
                                    <div class="form-group">
                                        <label for="exampleInputEmail1">Marca</label>
                                        <input name="mar_rep"  class="form-control" aria-describedby="emailHelp" placeholder="Digita el nombre del repuesto">
                                    </div>
                                    <!-- anio -->
                                    <div class="form-group">
                                        <label for="exampleInputEmail1">Año del repuesto</label>
                                        <input name="ani_rep"  class="form-control" aria-describedby="emailHelp" placeholder="Formato: YYYY">
                                    </div>
                                    <!-- numero_chasis -->
                                    <div class="form-group">
                                        <label for="exampleInputEmail1">Numero de chasis</label>
                                        <input name="num_rep"  class="form-control" aria-describedby="emailHelp" placeholder="Debe seguir el estandar, y tener 17 caracteres">
                                    </div>
                                    <!-- origen -->
                                    <div class="form-group">
                                        <label for="exampleInputEmail1">Origen</label>
                                        <input name="ori_rep"  class="form-control" aria-describedby="emailHelp" placeholder="Nombre del pais de origen del repuesto">
                                    </div>
                                    <!-- descripcion-->
                                    <div class="form-group">
                                        <label for="exampleInputEmail1">Descripcion</label>
                                        <input name="des_rep"  class="form-control" aria-describedby="emailHelp" placeholder="Breve descripcion. Puedes especificar el modelo del auto aca">
                                    </div>
                                    <!-- precio -->
                                    <div class="form-group">
                                        <label for="exampleInputEmail1">Precio</label>
                                        <input name="pre_rep"  class="form-control" aria-describedby="emailHelp" placeholder="$ 0.00">
                                    </div>
                                    
                                    <!-- existencias -->
                                    <div class="form-group">
                                        <label for="exampleInputEmail1">Existencias</label>
                                        <input name="exi_rep"  class="form-control" aria-describedby="emailHelp" placeholder="Numero de articulos disponibles">
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                                    <button type="submit"  class="btn btn-primary">Guardar</button>
                                </div>
                                <input name="id_esta"  type="hidden" value="${id_est}">
                                <input name="email_est" type="hidden" value="${email_est}">
                            </form>
                        </div>
                    </div>
                </div>
            <!-- FIN DEL MODAL agregar producto -->
            
    </body>
</html>
