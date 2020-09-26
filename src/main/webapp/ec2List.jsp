<%@ page import="Interfaces.Instances" %>
<%@ page import="Interfaces.Credentials" %>
<%@ page import="java.util.ArrayList" %>
<%--
  Created by IntelliJ IDEA.
  User: Marco
  Date: 25/09/2020
  Time: 11:03 a. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>EC2 Options</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
    <link rel="stylesheet" href="https://unpkg.com/bootstrap-table@1.18.0/dist/bootstrap-table.min.css">
    <link rel="stylesheet" href="styles.css">
</head>
<body>


<div class="container-fluid">
    <% String alias = (String) request.getAttribute("alias");%>
    <!-- Image and text -->
    <nav class="navbar navbar-light bg-light justify-content-start">
        <!-- <a class="navbar-brand" href="#">Default</a> -->
        <img src="https://www.guardicore.com/infectionmonkey/docs/images/usage/integrations/aws-ec2.svg?height=250px" width="30" height="30" class="d-inline-block align-top" alt="" loading="lazy">
        <p class="h1 navbar-brand" style="margin-left: 2%; margin-right: 2%; margin-top: 5px;">Listado de Instancias de la cuenta: "<% out.write(alias); %>"</p>
    </nav>

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
        <!-- <button form="reporteGeneral" type="submit" style="height: 50px; position: absolute; left: 71%" class="btn btn-success"><i class="fas fa-file-export"></i></button>-->
    </form>

    <!-- Formulario para obtener los reportes de manera individual-->
    <form id="reporteIndivual" method="get" action="ReporteIndividual">

    </form>

    <form id="principal" method="post" action="Ec2NewGrid" name="principal">
        <div class="row justify-content-end" style="margin-top: 5%; margin-bottom: 2%; margin-right: 5%;">

            <!-- Agrupaión de los botones en la parte superior  -->
            <div class="btn-group" role="group" aria-label="Basic example">
                <input form="principal" style="margin-left: 2%; margin-right: 2%;" type="submit"  class="btn btn-info" value="Actualizar" id="evento_actualizar" name="evento_actualizar" />

                <button form="reporteGeneral" style="margin-left: 2%; margin-right: 2%;" type="submit" class="btn btn-success"><i class="fas fa-file-export"></i></button>

                <div class="btn-group" role="group">
                    <button id="btnGroupDrop1" style="margin-left: 2%; margin-right: 2%;" type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Acciones
                    </button>
                    <div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
                        <input form="principal" type="submit" onclick="getRadioButtonSelectedValuePrender()" class="dropdown-item" value="Prender" id="evento_prender" name="evento_prender" />
                        <input form="principal" type="submit" onclick="getRadioButtonSelectedValueApagar()" class="dropdown-item" value="Apagar" id="evento_apagar" name="evento_apagar" />
                    </div>
                </div>
            </div>

        </div>

        <div class="row justify-content-md-center">
            <div class="col col-lg-12">

                <div class="table-responsive">
                    <table class="table table-striped table-bordered" id="table" data-toggle="table">
                        <thead class="thead-dark">
                        <tr>
                            <th></th>
                            <th data-sortable="true">Id</th>
                            <th data-sortable="true">Instance Name</th>
                            <th data-sortable="true">Ami</th>
                            <th data-sortable="true">Type</th>
                            <th data-sortable="true">State</th>
                            <th data-sortable="true">Launch Time</th>
                            <th data-sortable="true">Placement</th>
                            <th data-sortable="true">Platform</th>
                            <th data-sortable="true">VPC Id</th>
                            <th data-sortable="true">Karnel Id</th>
                            <th data-sortable="true">Private DNS</th>
                            <th>Exportar</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            for(Instances i : list){
                                out.write("<tr>\n ");
                                out.write("<td><label><input class='radio' form='principal' type='radio' id='"+i.getName()+"' name='option' value='"+i.getId()+"' onmousedown='this.c=this.checked' onclick='if (this.c) { this.checked = false }'></label></td>\n ");
                                out.write("<td style='font-size: 12px; font-family: serif;'>"+i.getId()+"</td>\n ");
                                out.write("<td style='font-size: 12px; font-family: serif;'>"+i.getName()+"</td>\n ");
                                out.write("<td style='font-size: 12px; font-family: serif;'>"+i.getAmi()+"</td>\n ");
                                out.write("<td style='font-size: 12px; font-family: serif;'>"+i.getType()+"</td>\n ");
                                out.write("<td style='font-size: 12px; font-family: serif;'>"+i.getState().toLowerCase()+"</td>\n ");
                                out.write("<td style='font-size: 12px; font-family: serif;'>"+i.getLaunchTime()+"</td>\n ");
                                out.write("<td style='font-size: 12px; font-family: serif;'>"+i.getPlacement()+"</td>\n ");
                                out.write("<td style='font-size: 12px; font-family: serif;'>"+i.getPlatgorm()+"</td>\n ");
                                out.write("<td style='font-size: 12px; font-family: serif;'>"+i.getVpcId()+"</td>\n ");
                                out.write("<td style='font-size: 12px; font-family: serif;'>"+i.getKarnelId()+"</td>\n ");
                                out.write("<td style='font-size: 12px; font-family: serif;'>"+i.getPrivateDns()+"</td>\n ");
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


<script type="text/javascript" src="funcionesEC2.js"></script>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js" integrity="sha512-bLT0Qm9VnAYZDflyKcBaQ2gg0hSYNQrJ8RilYldYQ1FxQYoCLtUjuuRuZo+fjqhx/qtq/1itJ0C2ejDxltZVFg==" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://unpkg.com/bootstrap-table@1.18.0/dist/bootstrap-table.min.js"></script>
<script src="https://kit.fontawesome.com/756f11e8ba.js" crossorigin="anonymous"></script>
</body>
</html>
