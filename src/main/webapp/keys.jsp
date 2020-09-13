<%--
  Created by IntelliJ IDEA.
  User: Marco
  Date: 25/07/2020
  Time: 01:05 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert your kays</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
</head>
<body>
<div class="container">
    <div class="row justify-content-md-center">
        <form method="post" action="Ec2NewGrid" class="col col-lg-6">
            <div class="form-group">
                <h2>Introduce los Datos</h2>
            </div>
            <div class="form-group">
                <label>Access Key Id</label>
                <input type="text" class="form-control" id="user" name="accessKay">
            </div>
            <div class="form-group">
                <label>Secret Access Key</label>
                <input type="password" class="form-control" id="password" name="aecretKay">
            </div>
            <div class="row justify-content-md-center">
            <div class="col col-sm-6">
                <button type="submit" class="btn btn-primary btn-lg btn-block">Entrar</button>
            </div>
            <div class="col col-sm-6">
                <a href="home.jsp" class="btn btn-secondary btn-lg btn-block">Regresar</a>
            </div>
    </div>
        </form>
    </div>
</div>
</body>
</html>
