<%@ page import="Interfaces.Instances" %>
<%@ page import="Interfaces.Credentials" %>
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
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    <script src="https://kit.fontawesome.com/756f11e8ba.js" crossorigin="anonymous"></script>

</head>
<body>
    <div class="container">

        <%ArrayList<Instances> list = null;
            ArrayList<Credentials> listCred = null;

            if (request.getAttribute("listInstances") != null){
                list = (ArrayList<Instances>)request.getAttribute("listInstances");
                listCred = (ArrayList<Credentials>)request.getAttribute("listCred");
            }

            String accesskey = listCred.get(0).getAccessKey();
            String secretkey = listCred.get(0).getSecretKey(); %>

        <form method="post" action="Ec2NewGrid">
            <div class="row" style="margin-top: 5%; margin-bottom: 2%">

                <!--<form method="post" action="Ec2">
                    <button type="submit" class="btn btn-primary" style="height: 50px; position: absolute; left: 64%"><i class="fas fa-sync-alt"></i></button>
                </form>-->

                <input type="submit" style="height: 50px; position: absolute; left: 61%" class="btn btn-info" value="Actualizar" id="evento_actualizar" name="evento_actualizar" />

                <form method="get" action="ReporteGeneral">
                    <input type="hidden" id="faccess" name="faccess" value=<%= accesskey %>>
                    <input type="hidden" id="fsecret" name="fsecret" value=<%= secretkey %>>
                    <button type="submit" style="height: 50px; position: absolute; left: 67%" class="btn btn-success"><i class="fas fa-file-export"></i></button>
                </form>

                <div class="dropdown" style="position: relative; left: 80%">
                    <button class="btn btn-primary dropdown-toggle" style="height: 50px" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Acciones
                    </button>
                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                        <input type="submit" class="dropdown-item" value="Prender" id="evento_prender" name="evento_prender" />
                        <input type="submit"  class="dropdown-item" value="Apagar" id="evento_apagar" name="evento_prender" />
                    </div>
                </div>
                <!--
                    <button style="height: 50px; position: relative; left: 80%" type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
                        Iniciar/Apagar un instancia
                    </button>
                -->

            </div>

            <div class="row justify-content-md-center">
                <div class="col col-lg-12">

                    <div class="table-responsive">
                        <table class="table table-striped table-bordered" >
                            <thead class="thead-dark">
                            <tr>
                                <th></th>
                                <th>Id</th>
                                <th>Instance Name</th>
                                <th>Ami</th>
                                <th>Type</th>
                                <th>State</th>
                                <th>Launch Time</th>
                                <th>Placement</th>
                                <th>Platform</th>
                                <th>VPC Id</th>
                                <th>Karnel Id</th>
                                <th>Private DNS</th>
                                <th>Reporte</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%


                                for(Instances i : list){
                                    out.write("<tr>\n ");
                                    out.write("<td><div class='radio'><label><input type='radio' id='option' name='option' value='"+i.getId()+"' onmousedown='this.c=this.checked' onclick='if (this.c) { this.checked = false }'></label></div></td>\n ");
                                    out.write("<td><strong>"+i.getId()+"</strong></td>\n ");
                                    out.write("<td><strong>"+i.getName()+"</strong></td>\n ");
                                    out.write("<td><strong>"+i.getAmi()+"</strong></td>\n ");
                                    out.write("<td><strong>"+i.getType()+"</strong></td>\n ");
                                    out.write("<td><strong>"+i.getState().toLowerCase()+"</strong></td>\n ");
                                    out.write("<td><strong>"+i.getLaunchTime()+"</strong></td>\n ");
                                    out.write("<td><strong>"+i.getPlacement()+"</strong></td>\n ");
                                    out.write("<td><strong>"+i.getPlatgorm()+"</strong></td>\n ");
                                    out.write("<td><strong>"+i.getVpcId()+"</strong></td>\n ");
                                    out.write("<td><strong>"+i.getKarnelId()+"</strong></td>\n ");
                                    out.write("<td><strong>"+i.getPrivateDns()+"</strong></td>\n ");
                                    out.write("<td><form method='get' action='ReporteIndividual'>"+
                                            "<input type='hidden' id='fname' name='fname' value='"+i.getId()+"'>"+
                                            "<input type='hidden' id='faccess' name='faccess' value='"+accesskey+"'>"+
                                            "<input type='hidden' id='fsecret' name='fsecret' value='"+secretkey+"'>"+
                                            "<button type='submit' class='btn btn-success'>Exportar</button>"+
                                            "</form></td>\n");
                                    out.write("</tr>\n ");
                                }
                            %>
                            </tbody>
                        </table>

                    </div>

                </div>
            </div>

            <div class="row justify-content-md-center" style="margin-top: 2%">
                <div class="col col-sm-12">
                    <a href="home.jsp" class="btn btn-secondary btn-lg btn-block">Regresar</a>
                </div>
            </div>
        </form>


    </div>



    </div>

    <!--
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
    -->

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
    <!-- <script type="text/javascript">
        function unselect(){
            document.querySelectorAll('[name=option]').forEach((x) => x.checked=false);
        }
    </script>-->
</body>
</html>