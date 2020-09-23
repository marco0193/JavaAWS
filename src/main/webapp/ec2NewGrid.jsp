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
    <link rel="stylesheet" href="styles.css">

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
        <form id="reporteGeneral" method="get" action="ReporteGeneral">
            <input form="reporteGeneral" type="hidden" id="faccess" name="faccess" value=<%= accesskey %>>
            <input form="reporteGeneral" type="hidden" id="fsecret" name="fsecret" value=<%= secretkey %>>
            <button form="reporteGeneral" type="submit" style="height: 50px; position: absolute; left: 67%" class="btn btn-success"><i class="fas fa-file-export"></i></button>
        </form>

        <!-- Formulario para obtener los reportes de manera individual-->
        <form id="reporteIndivual" method="get" action="ReporteIndividual">

        </form>

        <form id="principal" method="post" action="Ec2NewGrid" name="principal">
            <div class="row" style="margin-top: 5%; margin-bottom: 2%">

                <!--<form method="post" action="Ec2">
                    <button type="submit" class="btn btn-primary" style="height: 50px; position: absolute; left: 64%"><i class="fas fa-sync-alt"></i></button>
                </form>-->

                <input form="principal" type="submit" style="height: 50px; position: absolute; left: 61%" class="btn btn-info" value="Actualizar" id="evento_actualizar" name="evento_actualizar" />



                <div class="dropdown" style="position: relative; left: 80%">
                    <button class="btn btn-primary dropdown-toggle" style="height: 50px" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Acciones
                    </button>
                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                        <input form="principal" type="submit" onclick="getRadioButtonSelectedValuePrender()" class="dropdown-item" value="Prender" id="evento_prender" name="evento_prender" />
                        <input form="principal" type="submit" onclick="getRadioButtonSelectedValueApagar()" class="dropdown-item" value="Apagar" id="evento_apagar" name="evento_apagar" />
                        <!--<input form="reporteIndivual" type="submit"  class="dropdown-item" value="Generar Reporte" id="evento_reporte" name="evento_reporte" /> -->
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
                                <th>Exportar</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%
                                for(Instances i : list){
                                    out.write("<tr>\n ");
                                    out.write("<td><label><input class='radio' form='principal' type='radio' id='"+i.getName()+"' name='option' value='"+i.getId()+"' onmousedown='this.c=this.checked' onclick='if (this.c) { this.checked = false }'></label></td>\n ");
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
                                    out.write("<td><input form='reporteIndivual' type='submit' class='btn btn-success' value='Descargar Reporte'></td>\n");

                                    out.write("</tr>\n ");

                                    out.write( "<input form='reporteIndivual' type='hidden' id='fname' name='fname' value='"+i.getId()+"'>");
                                    out.write( "<input form='reporteIndivual' type='hidden' id='fstate' name='fstate' value='"+i.getState()+"'>");
                                    out.write( "<input form='reporteIndivual' type='hidden' id='faccess' name='faccess' value='"+accesskey+"'>");
                                    out.write( "<input form='reporteIndivual' type='hidden' id='fsecret' name='fsecret' value='"+secretkey+"'>");
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

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
    <script type="text/javascript" src="funcionesEC2.js"></script>
</body>
</html>