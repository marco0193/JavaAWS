<%@ page import="java.util.ArrayList" %>
<%@ page import="Interfaces.Usuarios" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>IAM Options</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
</head>
<body>
    <div class="container">
        <div class="row justify-content-md-center">
            <div class="col col-lg-8">
                <form method="post" action="IamList">
                    <table class="table">
                        <thead class="thead-dark">
                        <tr>
                            <th scope="col">Id</th>
                            <th scope="col">Name</th>
                            <th scope="col">Create Date</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            ArrayList<Usuarios> list = null;
                            if(request.getAttribute("listUsers") != null){
                                list = (ArrayList<Usuarios>)request.getAttribute("listUsers");
                            }

                            for (Usuarios u: list){
                                out.write("<tr>\n ");
                                out.write("<th scope='row'>");
                                out.print(u.getId());
                                out.write("</th>\n");
                                out.write("<td>");
                                out.print(u.getNombre());
                                out.write("</td>\n");
                                out.write("<td>");
                                out.print(u.getFecha());
                                out.write("</td>\n");
                                out.write("</tr>\n");
                            }

                            list.clear();
                        %>
                        </tbody>
                    </table>
                    <div class="row justify-content-md-center">
                        <div class="col col-sm-6">
                            <button type="submit" class="btn btn-primary btn-lg btn-block">Actualizar</button>
                        </div>
                        <div class="col col-sm-6">
                            <button type="button" class="btn btn-primary btn-lg btn-block" data-toggle="modal" data-target="#exampleModal">
                                Crear Usuario
                            </button>
                        </div>
                    </div>

                    <div class="row justify-content-md-center">
                        <div class="col col-sm-6">
                            <a href="home.jsp" class="btn btn-secondary btn-lg btn-block">Regresar</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Modal -->
        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Nuevo Usuario</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form method="post" action="Iam">
                            <div class="form-group">
                                <label for="exampleName">Name</label>
                                <input name="nombre" type="text" class="form-control" id="exampleName" aria-describedby="nameHelp">
                                <small id="nameHelp" class="form-text text-muted">Ingresa el nombre del usuario que quieres crear</small>
                            </div>
                            <button type="submit" class="btn btn-primary btn-lg btn-block">Crear!</button>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

    </div>
</body>
</html>
