<%--
  Created by IntelliJ IDEA.
  User: Marco
  Date: 10/07/2020
  Time: 03:46 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Home</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-sm">
            <div class="card" style="width: 18rem;">
                <img src="https://img2.freepng.es/20180614/hie/kisspng-amazon-com-amazon-s3-amazon-web-services-aws-lambd-5b22b5a800fc30.002230971529001384004.jpg" class="card-img-top" alt="..." height="250px" width="250">
                <div class="card-body">
                    <h5 class="card-title">AWS S3</h5>
                    <p class="card-text">¿Deseas ver las diferentes opciones que tenemos para gestiones tus buckets de S3Create?</p>
                    <form class="form-inline" method="post" action="S3List">
                        <button type="submit" class="btn btn-primary btn-lg btn-block">Vamos</button>
                    </form>
                </div>
            </div>
        </div>
        <div class="col-sm">
            <div class="card" style="width: 18rem;">
                <img src="https://www.pngitem.com/pimgs/m/152-1522254_aws-iam-logo-hd-png-download.png" class="card-img-top" alt="..." height="250px" width="250">
                <div class="card-body">
                    <h5 class="card-title">AWS IAM</h5>
                    <p class="card-text">¿Deseas ver las diferentes opciones que tenemos para gestiones tus usuarios de IAM?</p>
                    <form class="form-inline" method="post" action="IamList">
                        <button type="submit" class="btn btn-primary btn-lg btn-block">Vamos</button>
                    </form>
                </div>
            </div>
        </div>
        <div class="col-sm">
            <div class="card" style="width: 18rem;">
                <img src="https://justanotherdevbloghome.files.wordpress.com/2017/02/4a6f9-1p105pizbet4nc0mm41hhia.png?w=424" class="card-img-top" alt="..." height="250px" width="250">
                <div class="card-body">
                    <h5 class="card-title">AWS EC2</h5>
                    <p class="card-text">¿Deseas ver las diferentes opciones que tenemos para gestiones tus instancias de EC2?</p>
                    <form class="form-inline" method="post" action="Ec2">
                        <button type="submit" class="btn btn-primary btn-lg btn-block">Vamos</button>
                    </form>
                    <!-- <a href="ec2.jsp" class="btn btn-primary btn-lg active btn-lg btn-block" role="button" aria-pressed="true">Vamos</a>-->
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
