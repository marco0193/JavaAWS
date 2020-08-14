<%@ page import="Interfaces.Instances" %>
<%@ page import="java.util.ArrayList" %>
<%--
  Created by IntelliJ IDEA.
  User: Marco
  Date: 22/07/2020
  Time: 01:23 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>EC2 Options</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
</head>
<body>
    <div class="container">
        <div class="row justify-content-md-center">
            <div class="col col-lg-8">
                    <%
                        ArrayList<Instances> list = null;

                        if (request.getAttribute("listInstances") != null){
                            list = (ArrayList<Instances>)request.getAttribute("listInstances");
                        }

                        for (Instances i : list){
                            out.write("<table class='table'>\n ");
                            out.write("<thead class='thead-dark'>\n ");
                            out.write("<tr>\n ");
                            out.write("<th scope='col'>Name</th> \n <th scope='col'>Value</th>");
                            out.write("</tr>\n ");
                            out.write("</thead>\n ");
                            out.write("<tbody>\n");
                            out.write("<tr><th scope='row'>Id</th><td><strong>"+i.getId()+"</strong></td></tr>\n");
                            out.write("<tr><th scope='row'>Instance name</th><td><strong>"+i.getName()+"</strong></td></tr>\n");
                            out.write("<tr><th scope='row'>Ami</th><td>"+i.getAmi()+"</td></tr>\n");
                            out.write("<tr><th scope='row'>Type</th><td>"+i.getType()+"</td></tr>\n");
                            out.write("<tr><th scope='row'>State</th><td><strong>"+i.getState().toLowerCase()+"</strong></td></tr>\n");
                            out.write("<tr><th scope='row'>Launch Time</th><td>"+i.getLaunchTime()+"</td></tr>\n");
                            out.write("<tr><th scope='row'>Placement</th><td>"+i.getPlacement()+"</td></tr>\n");
                            out.write("<tr><th scope='row'>Platform</th><td>"+i.getPlatgorm()+"</td></tr>\n");
                            out.write("<tr><th scope='row'>VPC Id</th><td>"+i.getVpcId()+"</td></tr>\n");
                            out.write("<tr><th scope='row'>Karnel Id</th><td>"+i.getKarnelId()+"</td></tr>\n");
                            out.write("<tr><th scope='row'>Private DNS</th><td>"+i.getPrivateDns()+"</td></tr>\n");
                            out.write("<tr><th scope='row'>Public DNS</th><td>"+i.getPublicDns()+"</td></tr>\n");
                            out.write("<tr><th scope='row'>Exportar</th><td><form method='get' action='ReporteGeneral'><input type='hidden' id='fname' name='fname' value='"+i.getId()+"'><button type='submit' class='btn btn-warning'>Exportar</button></form></td></tr>\n");
                            out.write("</tbody>\n");
                            out.write("</table>\n");
                        }

                    %>
                <div class="row justify-content-md-center">
                    <div class="col col-sm-6">
                        <button type="button" class="btn btn-primary btn-lg btn-block" data-toggle="modal" data-target="#exampleModal">
                            Iniciar/Apagar un instancia
                        </button>
                    </div>
                    <div class="col col-sm-6">
                        <form method="post" action="Ec2">
                            <button type="submit" class="btn btn-primary btn-lg btn-block">Actualizar</button>
                        </form>
                    </div>
                </div>

                <div class="row justify-content-md-center">
                    <div class="col col-sm-6">
                    <form method="get" action="ReporteGeneral">
                        <button type="submit" class="btn btn-warning btn-lg btn-block">Descargar Reporte General</button>
                    </form>
                    </div>
                    <div class="col col-sm-6">
                        <a href="home.jsp" class="btn btn-secondary btn-lg btn-block">Regresar</a>
                    </div>
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
                                    <form method="post" action="Ec2">
                                        <div class="form-group">
                                            <label for="exampleFormControlSelect1">Example select</label>
                                            <select class="form-control" id="exampleFormControlSelect1" name="select">
                                              <%
                                                for (Instances i : list){
                                                    out.write("<option value='"+i.getId()+"'>"+i.getName()+" ("+i.getId()+" - "+i.getState().toLowerCase()+")"+"</option>\n");
                                                }
                                              %>
                                            </select>
                                         </div>
                                        <button type="submit" class="btn btn-primary btn-lg btn-block">Prender/Apagar</button>
                                    </form>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
        </div>
    </div>
</body>
</html>
