import Interfaces.Credentials;
import Interfaces.Instances;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.ec2.AmazonEC2Client;
import com.amazonaws.services.ec2.model.*;

//Importaciones para el uso de alias

import com.amazonaws.services.identitymanagement.AmazonIdentityManagementClient;
import com.amazonaws.services.identitymanagement.model.ListAccountAliasesResult;
import com.amazonaws.services.identitymanagement.model.AmazonIdentityManagementException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/Ec2NewGrid")
public class Ec2 extends HttpServlet {
    public static ArrayList<Instances> listInstances = new ArrayList<>();
    public static ArrayList<Credentials> listCredentials = new ArrayList<>();

    //Valor de alias de la cuenta
    public String aliasGeneral = "";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String accessKey = req.getParameter("accessKay");
        String secretKay = req.getParameter("aecretKay");
        String idIns = req.getParameter("option");

        //Evento apagar o encender instancia
        String inputPrender = req.getParameter("evento_prender");
        String inputApagar = req.getParameter("evento_apagar");

        //String idInsrance = req.getParameter("select");
        listInstances.clear();

        if(accessKey != null && secretKay != null){
            listCredentials.clear();
        }

        Credentials credentials = new Credentials(accessKey, secretKay);
        listCredentials.add(credentials);

        BasicAWSCredentials awsCreds = new BasicAWSCredentials(listCredentials.get(0).getAccessKey(),listCredentials.get(0).getSecretKey());

        AmazonEC2Client ec2 = new AmazonEC2Client(awsCreds).withRegion(Regions.US_EAST_1);
        AmazonIdentityManagementClient iam = new AmazonIdentityManagementClient(awsCreds);

        //Llamamos al metodo que se encarga de crear la lista de instancias
        listEc2(ec2);

        //Llamamos al metodo que se encarga
        getAlias(iam);

        //llamamos al metodo para prender la instancia
        if(inputPrender != null) {
            if(idIns != null){
                StartInstancesRequest request = new StartInstancesRequest().withInstanceIds(idIns);
                ec2.startInstances(request);
                //onOffInstance(ec2, idInstanceOffOn);

            }
        }

        //llamamos al metodo para apagar la instancia
        if(inputApagar != null) {
            if(idIns != null){
                StopInstancesRequest request = new StopInstancesRequest().withInstanceIds(idIns);
                ec2.stopInstances(request);
            }
        }

        //Cerramos el cliente de Amazon Ec2
        ec2.shutdown();

        req.setAttribute("listInstances", listInstances);
        req.setAttribute("listCred", listCredentials);
        req.setAttribute("alias", aliasGeneral);

        getServletConfig().getServletContext().getRequestDispatcher("/ec2NewGrid.jsp").forward(req, resp);
        //getServletConfig().getServletContext().getRequestDispatcher("/ec2List.jsp").forward(req, resp);
    }

    //Se encarga de crear el listado de intancias
    public void listEc2(AmazonEC2Client ec2){
        boolean done = false;

        DescribeInstancesRequest request = new DescribeInstancesRequest();

        while(!done){
            DescribeInstancesResult response = ec2.describeInstances(request);

            for(Reservation reservation:response.getReservations()){
                for (Instance instance : reservation.getInstances()){
                    Instances instances = new Instances(instance.getInstanceId(),
                            instance.getTags().get(0).getValue(),
                            instance.getImageId(),
                            instance.getInstanceType(),
                            instance.getState().getName(),
                            instance.getLaunchTime().toString(),
                            instance.getPlacement().getAvailabilityZone(),
                            instance.getPlatform(),
                            instance.getVpcId(),
                            instance.getKernelId(),
                            instance.getPrivateDnsName());

                    listInstances.add(instances);
                }

                request.setNextToken(response.getNextToken());

                if(response.getNextToken() == null){
                    done = true;
                }
            }
        }
    }

    public void getAlias(AmazonIdentityManagementClient iam){
        try {
            ListAccountAliasesResult response = iam.listAccountAliases();

            for(String alias : response.getAccountAliases()){
                aliasGeneral = alias;
            }
        }catch (AmazonIdentityManagementException e){
            aliasGeneral = "SIN ALIAS";
        }
    }

    /*public void onOffInstance(AmazonEC2Client ec2, String idInstance){
        for(Instances instace : listInstances){
            if(idInstance.equals(instace.getId())){
                if(instace.getState().equals("stopped")){
                    StartInstancesRequest request = new StartInstancesRequest().withInstanceIds(idInstance);
                    ec2.startInstances(request);
                }else if (instace.getState().equals("running")){
                    StopInstancesRequest request = new StopInstancesRequest().withInstanceIds(idInstance);
                    ec2.stopInstances(request);
                }
            }
        }
    }*/
}
